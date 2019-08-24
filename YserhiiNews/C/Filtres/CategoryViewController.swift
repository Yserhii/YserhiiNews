//
//  CategoryViewController.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/20/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell
        cell?.categoryLable.text = Array(allCategory.keys.sorted())[indexPath.row]
        cell?.category = allCategory[ cell?.categoryLable.text ?? ""] ?? ""
        if categoryForUrl == cell?.category {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell
        sourseForUrl.removeAll()
        categoryForUrl = cell?.category ?? ""
    }
}
