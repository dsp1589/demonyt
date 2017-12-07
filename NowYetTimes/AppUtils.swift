//
//  AppUtils.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/6/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class AppUtils{
    static func addBook(item : [String:String]){
        let userDefaults = UserDefaults(suiteName: "com.systameta.NowYetTimes.APP")
        if let availableBooks = userDefaults?.array(forKey: "Books"){
            var available = availableBooks
            if !availableBooks.contains(where: { (dict) -> Bool in
                return (dict as? [String:String])?["isbns_13"] == item["isbns_13"]
            }){
                available.append(item)
                userDefaults?.set(available, forKey: "Books")
            }
            
        }else{
            userDefaults?.set([item], forKey: "Books")
        }
        userDefaults?.synchronize()
    }
    
    static func savedBooks() -> [[String:String]]?{
        let userDefaults = UserDefaults(suiteName: "com.systameta.NowYetTimes.APP")
        if let availableBooks = userDefaults?.array(forKey: "Books") {
            return availableBooks as? [[String:String]]
        }
        return nil
    }
    
    static func isBookSaved(isbn_13 : String) -> Bool{
        let notFound = false
        return savedBooks()?.contains(where: { (items) -> Bool in
            return items["isbns_13"] == isbn_13
        }) ?? notFound
    }
    
}
