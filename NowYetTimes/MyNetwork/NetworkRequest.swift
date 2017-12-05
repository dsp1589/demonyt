//
//  NetworkRequest.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/2/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation

typealias NResponseCallBack = ((Any) -> Void)

class NetworkRequest {
    
    var successBlock : NResponseCallBack
    var failureBlock : NResponseCallBack
    
    var url : URL!
    
    init(endPoint : URL, success : @escaping NResponseCallBack, failure :@escaping NResponseCallBack) {
        url = endPoint
        successBlock = success
        failureBlock = failure
    }
    
    func getAsURLQuery() {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            self.debugJson(data: data)
            
            guard let d = data, error == nil else{
                let err = NSError(domain: "com.systameta.ios.neterror", code: 2000, userInfo: ["Error" : error as Any])
                self.failureBlock(err)
                return
            }
            self.successBlock(d)
        }
        
        task.resume()
    }
    func debugJson(data : Data?){
        if let d = data{
//            print(JSONSerialization.jsonObject(with: d, options: .allowFragments))
            
        }
        
    }
}
