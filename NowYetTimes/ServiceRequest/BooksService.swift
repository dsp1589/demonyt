//
//  BooksService.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/3/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class BooksService : BaseService{
    
    var success : ((Dictionary<String,BookNamesResponse>) -> Void)?
    var failure : ((String) -> Void)?
    var section : String = "/books"
    
    let mSVC_VERSION = "/v3"
    
    init(section : String, successCallBack : @escaping ((Dictionary<String,BookNamesResponse>) -> Void), failureCallBack : @escaping ((String) -> Void)) {
        self.success = successCallBack
        self.failure = failureCallBack
        self.section = section
        super.init()
    }
    
    init(section : String) {
        self.section = section
        super.init()
    }
    
    
    //Book Type, not to be confused with boot titles/author bs
    func getListOfBooks(){
        let type = "/lists/names.json"
        var comp = URLComponents(string: baseSvcEndPoint+section+mSVC_VERSION+type)
        let queryItems = URLQueryItem(name: "api-key", value: API_KEY)
        comp?.queryItems = [queryItems]
        
        let nw = NetworkRequest(endPoint: comp!.url!, success: { (data) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(BookNamesResponse.self, from: data as! Data)
                var d = Dictionary<String,BookNamesResponse>()
                d["Response"] = responseModel
                self.success!(d)
            }catch (let ee){
                print(ee.localizedDescription)
                //we can check for type of issue here, but user supposed to not know abt teck iss
                self.failure!("Unable to fetch Most Popular Stories right now, please try again later.")
            }
        }) { (error) in
            self.failure!("Unable to fetch Most Popular Stories right now, please try again later.")
        }
        nw.getAsURLQuery()
        
    }
    
    func getBooksOfType(encodedName : String, successCallBack : @escaping ((Dictionary<String,BooksOfTypeResponse>) -> Void), failureCallBack : @escaping ((String) -> Void)){
        let type = "/lists.json"
        var comp = URLComponents(string: baseSvcEndPoint+section+mSVC_VERSION+type)
        let queryItemsApi = URLQueryItem(name: "api-key", value: API_KEY)
        let queryItemsEncodedName = URLQueryItem(name: "list", value: encodedName)
        comp?.queryItems = [queryItemsApi,queryItemsEncodedName]
        
        let nw = NetworkRequest(endPoint: comp!.url!, success: { (data) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(BooksOfTypeResponse.self, from: data as! Data)
                var d = Dictionary<String,BooksOfTypeResponse>()
                d["Response"] = responseModel
                successCallBack(d)
            }catch (let ee){
                print(ee.localizedDescription)
                //we can check for type of issue here, but user supposed to not know abt teck iss
                failureCallBack("Unable to fetch Most Popular Stories right now, please try again later.")
            }
        }) { (error) in
            failureCallBack("Unable to fetch Most Popular Stories right now, please try again later.")
        }
        nw.getAsURLQuery()
    }
    
}
