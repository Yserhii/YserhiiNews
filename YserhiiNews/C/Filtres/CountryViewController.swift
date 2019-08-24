//
//  CountryViewController.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/20/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func alertError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if sourseForUrl.count == 0 && countryForUrl == "" && categoryForUrl == "" {
            self.alertError(title: "Attention", message: "You can't use resource filters with country and category filters.")
        }
    }
}

extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(allCountryDic.keys.sorted()).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell
        cell?.countryLable.text = Array(allCountryDic.keys.sorted())[indexPath.row]
        cell?.country = allCountryDic[cell?.countryLable.text ?? ""] ?? ""
        if countryForUrl == cell?.country {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell
        countryForUrl = cell?.country ?? ""
        sourseForUrl.removeAll()
    }
}
