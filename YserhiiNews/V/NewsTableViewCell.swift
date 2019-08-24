//
//  NewsTableViewCell.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/19/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsTableViewCell: UITableViewCell {

    var urlNews: String? = ""
    @IBOutlet weak var sourceLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionsLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    var data: JSON? {
        didSet {
            if data != nil {
                urlNews = data?["url"].string ?? ""
                sourceLable.text = data?["source"]["name"].string ?? ""
                titleLable.text = data?["title"].string ?? ""
                descriptionsLable.text = data?["description"].string ?? ""
                authorLable.text = data?["author"].string ?? ""
                self.imageNews.image = .none
                
                if let newsImage = URL(string: data?["urlToImage"].string ?? "") {
                    let queue = DispatchQueue.global(qos: .utility)
                    queue.async {
                        if let isNewsImage = try? Data(contentsOf: newsImage) {
                            DispatchQueue.main.async {
                                self.imageNews.image = UIImage(data: isNewsImage)
                                self.imageNews.contentMode = .scaleAspectFit
                            }
                        }
                    }
                }
            }
        }
    }
    
    func dataEmpty() {
        urlNews = ""
        sourceLable.text = ""
        titleLable.text = ""
        descriptionsLable.text = ""
        authorLable.text = ""
        self.imageNews.image = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
