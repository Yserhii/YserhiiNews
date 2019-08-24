//
//  SourseTableViewCell.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/20/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class SourseTableViewCell: UITableViewCell {

    var id: String = ""
    @IBOutlet weak var sourseLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}
