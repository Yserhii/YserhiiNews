//
//  NewsViewController.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/19/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices

class NewsViewController: UIViewController, UISearchBarDelegate, SFSafariViewControllerDelegate {

    private var page: Int = 1
    private var countNews: Int = 0
    private var selectSourses = ""
    private var selectCountry = ""
    private var selectCategory = ""
    private var searchWord = ""
    private var searchReqOnOFF = false
    private var openSafariOnOff = false
    private let defaults = UserDefaults.standard
    private let requestsManager = RequestManeger()
    private var arrNews: [JSON?] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchButtom(_ sender: UIBarButtonItem) {
        //Show Search bar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func upTopTableClick(_ sender: UIButton) {
        //scrollToTop when click buttom
        self.tableView.scrollToTop(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Hide search bar and request a search by word
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        self.searchReqOnOFF = true
        self.searchWord = searchBar.text ?? ""
        getSearchNews(searchString: self.searchWord)
    }
    
    @objc func handleRefreshControl() {
            getNews()
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func configureRefreshControl () {
        //Pull to refresh and request by filters
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    func changeFilters() {
        //I convert filters to strings and save filters to UserDefaults
        self.selectSourses = ""
        for sourses in sourseForUrl {
            self.selectSourses += "\(sourses.value),"
        }
        if self.selectSourses != "" {
            self.selectSourses.removeLast()
        }
        self.selectCategory = categoryForUrl
        self.selectCountry = countryForUrl
        self.defaults.set(self.selectCategory, forKey: "category")
        self.defaults.set(self.selectCountry, forKey: "country")
        self.defaults.set(self.selectSourses, forKey: "sourse")
    }
    override func viewDidAppear(_ animated: Bool) {
        //Automatically display new news after changing filters
        if openSafariOnOff == false {
            changeFilters()
            getNews()
        } else {
            openSafariOnOff = false
        }
    }
    
    func checkingSelectedFiltersiSEmpty() -> Bool {
        // Updating filters from UserDefaults
        categoryForUrl = defaults.string(forKey: "category") ?? ""
        countryForUrl =  defaults.string(forKey: "country") ?? ""
        selectSourses =  defaults.string(forKey: "sourse") ?? ""
        if selectSourses == "" && countryForUrl == "" && categoryForUrl == "" {
            return true
        }
        let splitSourses = selectSourses.components(separatedBy: ",")
        for sourse in splitSourses {
            sourseForUrl[sourse] = sourse
        }
           return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkingSelectedFiltersiSEmpty() {
            self.alertError(title: "Welcome", message: "You must select filters to search for news.")
        }
        configureRefreshControl()
        tableView.prefetchDataSource = self
    }
}


extension NewsViewController : UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        if arrNews.count > indexPath.row {
            cell.data = arrNews[indexPath.row]
            self.tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        } else {
            cell.dataEmpty()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        if let url = URL(string: cell.urlNews!) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            openSafariOnOff = true
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        //Auto-load news using prefetchRowsAt. For one request, get 20 news.
        for indexPath in indexPaths {
            if indexPath.row % 20 == 0 && indexPath.row < countNews && indexPath.row != 0 {
                self.fetchNews(ofIndex: indexPath.row)
            }
        }
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewsViewController {

    //Request for the next page with 20 news
    func fetchNews(ofIndex index: Int) {
        
        self.page += 1
        if self.searchReqOnOFF {
            requestsManager.getSerachNews(search: searchWord, page: page, completationHandler: {
                (response) in
                if response != nil && response?.isEmpty == false {
                    self.arrNews.append(contentsOf: response?["articles"].array ?? [])
                }
            })
        } else {
            requestsManager.getNews(category: selectCategory, country: selectCountry, sources: selectSourses, page: page, completationHandler: { (response) in
                if response != nil && response?.isEmpty == false {
                    self.arrNews.append(contentsOf: response?["articles"].array ?? [])
                }
            })
        }
    }
    //Request for the news
    func getNews() {
        self.tableView.scrollToTop(animated: false)
        self.page = 1
        requestsManager.getNews(category: selectCategory, country: selectCountry, sources: selectSourses, page: self.page, completationHandler: {
            (response) in
            print(self.selectSourses)
            self.searchReqOnOFF = false
            if response != nil && response?.isEmpty == false {
                self.countNews = response?["totalResults"].int ?? 0
                self.arrNews.removeAll()
                self.arrNews.append(contentsOf: response?["articles"].array ?? [])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.alertError(title: "Error", message: "No connection to the news source server. Try later")
            }
        })
    }
    //Request for the news by search word
    func getSearchNews(searchString: String) {
        self.page = 1
        self.tableView.scrollToTop(animated: false)
        requestsManager.getSerachNews(search: searchString, page: page, completationHandler: {
            (response) in
            if response != nil && response?.isEmpty == false {
                self.countNews = response?["totalResults"].int ?? 0
                self.arrNews.removeAll()
                self.arrNews.append(contentsOf: response?["articles"].array ?? [])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.alertError(title: "", message: "Nothing found")
            }
        })
    }
    
    func alertError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
