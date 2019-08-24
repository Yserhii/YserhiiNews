//
//  DataForPickers.swift
//  YserhiiNews
//
//  Created by Yolankyi SERHII on 8/20/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import Foundation

var countryForUrl: String = ""
var categoryForUrl: String = ""
var sourseForUrl: [String : String] = [:]

let allCategory: [String : String] =
    ["All category"  : "",
     "Business"      : "business",
     "Entertainment" : "entertainment",
     "General"       : "general",
     "Health"        : "health",
     "Science"       : "science",
     "Sports"        : "sports",
     "Technology"    : "technology"]

let allCountryDic: [String : String] =
    ["-Not selected-"         : "",
     "United Arab Emirates" : "ae",
     "Argentina"            : "ar",
     "Austria"              : "at",
     "Australia"            : "au",
     "Belgium"              : "be",
     "Bulgaria"             : "bg",
     "Brazil"               : "br",
     "Canada"               : "ca",
     "Switzerland"          : "ch",
     "China"                : "cn",
     "Colombia"             : "co",
     "Cuba"                 : "cu",
     "Czech Republic"       : "cz",
     "Germany"              : "de",
     "Egypt"                : "eg",
     "France"               : "fr",
     "United Kingdom"       : "gb",
     "Greece"               : "gr",
     "Hong Kong"            : "hk",
     "Hungary"              : "hu",
     "Indonesia"            : "id",
     "Ireland"              : "ie",
     "Israel"               : "il",
     "India"                : "in",
     "Italy"                : "it",
     "Japan"                : "jp",
     "Republic of Korea"    : "kr",
     "Lithuania"            : "lt",
     "Latvia"               : "lv",
     "Morocco"              : "ma",
     "Mexico"               : "mx",
     "Malaysia"             : "my",
     "Nigeria"              : "ng",
     "Netherlands"          : "nl",
     "Norway"               : "no",
     "New Zealand"          : "nz",
     "Philippines"          : "ph",
     "Poland"               : "pl",
     "Portugal"             : "pt",
     "Romania"              : "ro",
     "Serbia"               : "rs",
     "Russian Federation"   : "ru",
     "Saudi Arabia"         : "sa",
     "Sweden"               : "se",
     "Singapore"            : "sg",
     "Slovenia"             : "si",
     "Slovakia"             : "sk",
     "Thailand"             : "th",
     "Turkey"               : "tr",
     "Taiwan"               : "tw",
     "Ukraine"              : "ua",
     "USA"                  : "us",
     "Venezuela"            : "ve",
     "South Africa"         : "za"]
