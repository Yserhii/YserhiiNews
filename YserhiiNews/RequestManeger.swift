//
//  RequestManeger.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/19/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RequestManeger: UIViewController {
    
    // KeyAPI
    private let newsKey: String = "be3ad182d5b6442db8ad24e319ea5b3f"
    
    // Request for all resources
    func getAllSourses(completationHandler: @escaping(JSON?)->Void) {
        
        let reqUrlCurrent = "https://newsapi.org/v2/sources?" + "apiKey=\(newsKey)"
        
        Alamofire.request(reqUrlCurrent).responseJSON { response in
            if response.result.isSuccess {
                completationHandler(JSON(response.data!))
            } else {
                print(response.error!.localizedDescription)
                completationHandler(nil)
            }
        }.resume()
    }
    
    // Request to receive all news by keyword
    func getSerachNews(search: String, page: Int, completationHandler: @escaping(JSON?)->Void) {
        
                let reqUrlCurrent = "https://newsapi.org/v2/everything?" +
                                    "pageSize=20&" +
                                    "page=\(page)&" +
                                    "qInTitle=\(search)&" +
                                    "sortBy=publishedAt&" +
                                    "apiKey=\(newsKey)"
        
        Alamofire.request(reqUrlCurrent).responseJSON { response in
            if response.result.isSuccess {
                completationHandler(JSON(response.data!))
            } else {
                print(response.error!.localizedDescription)
                completationHandler(nil)
            }
        }.resume()
    }
    // Request to receive all news by filters
    func getNews(category: String, country: String, sources: String, page: Int, completationHandler: @escaping(JSON?)->Void) {
        
        let reqUrlCurrent = "https://newsapi.org/v2/top-headlines?" +
                            "pageSize=20&" +
                            "page=\(page)&" +
                            "sources=\(sources)&" +
                            "country=\(country)&" +
                            "category=\(category)&" +
                            "sortBy=publishedAt&" +
                            "apiKey=\(newsKey)"
        Alamofire.request(reqUrlCurrent).responseJSON { response in
            if response.result.isSuccess {
                completationHandler(JSON(response.data!))
            } else {
                print(response.error!.localizedDescription)
                completationHandler(nil)
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
