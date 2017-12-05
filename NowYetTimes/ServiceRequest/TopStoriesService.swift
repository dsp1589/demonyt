//
//  TopStoriesService.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/2/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation



class TopStoriesService : BaseService {
    
    var success : ((Dictionary<String,TopStoriesResponse>) -> Void)
    var failure : ((String) -> Void)
    var section : String = "home"
    init(section : String, successCallBack : @escaping ((Dictionary<String,TopStoriesResponse>) -> Void), failureCallBack : @escaping ((String) -> Void)) {
        self.success = successCallBack
        self.failure = failureCallBack
        self.section = section
        super.init()
    }
    
    func getTopStories(){
        print("TopStoriesService.getTopStories")
        let mSection = "/topstories"
        let type = "/\(section).json"//First call on load
        var comp = URLComponents(string: baseSvcEndPoint+mSection+SVC_VERSION+type)
        
        let queryItems = URLQueryItem(name: "api-key", value: API_KEY)
        comp?.queryItems = [queryItems]
        
        let nw = NetworkRequest(endPoint: comp!.url!, success: { (data) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(TopStoriesResponse.self, from: data as! Data)
                var d = Dictionary<String,TopStoriesResponse>()
                d["Response"] = responseModel
                self.success(d)
            }catch (_){
                //we can check for type of issue here, but user supposed to not know abt teck iss
                self.failure("Unable to fetch Top Stories right now, please try again later.")
            }            
        }) { (error) in
            self.failure("Unable to fetch Top Stories right now, please try again later.")
        }
        nw.getAsURLQuery()
    }
    
}
