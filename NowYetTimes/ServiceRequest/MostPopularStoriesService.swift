//
//  MostPopularStories.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/3/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class MostPopularStoriesService: BaseService {
    
    var success : ((Dictionary<String,MostPopularStoriesResponse>) -> Void)
    var failure : ((String) -> Void)
    var section : String = "home"
    
    init(section : String, successCallBack : @escaping ((Dictionary<String,MostPopularStoriesResponse>) -> Void), failureCallBack : @escaping ((String) -> Void)) {
        self.success = successCallBack
        self.failure = failureCallBack
        self.section = section
        super.init()
    }
    
    
    func getMostPopularStories(mode:String, contentType:String){
        print("MostPopularStoriesService.getMostPopularStories")
        
        let mSection = "/mostpopular"
        let type = "/\(mode)/\(contentType)/\(section).json"//First call on load
        var comp = URLComponents(string: baseSvcEndPoint+mSection+SVC_VERSION+type)
        
        let queryItems = URLQueryItem(name: "api-key", value: API_KEY)
        comp?.queryItems = [queryItems]
        
        
        let nw = NetworkRequest(endPoint: comp!.url!, success: { (data) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MostPopularStoriesResponse.self, from: data as! Data)
                var d = Dictionary<String,MostPopularStoriesResponse>()
                d["Response"] = responseModel
                self.success(d)
            }catch (let ee){
                print(ee.localizedDescription)
                //we can check for type of issue here, but user supposed to not know abt teck iss
                self.failure("Unable to fetch Most Popular Stories right now, please try again later.")
            }
        }) { (error) in
            self.failure("Unable to fetch Most Popular Stories right now, please try again later.")
        }
        nw.getAsURLQuery()
    }
    
}
