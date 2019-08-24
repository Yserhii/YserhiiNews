//
//  SourseViewController.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/20/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SourseViewController: UIViewController {
    
    private var allSourses: JSON?
    private let requestsManager = RequestManeger()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        getSourses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSourses?["sources"].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourseCell", for: indexPath) as? SourseTableViewCell
            cell?.sourseLable.text = allSourses?["sources"][indexPath.row]["name"].string ?? ""
            cell?.id =  allSourses?["sources"][indexPath.row]["id"].string ?? ""
        if sourseForUrl[cell?.id ?? ""] != nil {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SourseTableViewCell
        categoryForUrl = ""
        countryForUrl = ""
        sourseForUrl[cell?.id ?? ""] = cell?.id ?? ""
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SourseTableViewCell
        sourseForUrl[cell?.id ?? ""] = nil
    }
}

extension SourseViewController {
    //Request for the sourses
    func getSourses() {
        requestsManager.getAllSourses(completationHandler: { (response) in
            if response != nil && response?.isEmpty == false {
                self.allSourses = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.alertError(title: "Error", message: "No connection to the news source server. Try later")
            }
        })
    }
    
    func alertError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
