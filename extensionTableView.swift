//
//  extensionTableView.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/23/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

//Extension to automatically scroll up
extension UITableView {
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTop(animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}
