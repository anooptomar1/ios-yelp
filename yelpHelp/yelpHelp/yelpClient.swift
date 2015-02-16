//
//  yelpClient.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/10/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String,limit: Int, offset: Int,param: NSDictionary, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        
        var allParams = NSMutableDictionary();
        
        var parameters = ["term": term, "ll" : "37.791412, -122.395606", "limit": limit, "offset": offset];
        //var parameters = ["ll" : "37.791412, -122.395606", "limit": limit, "offset": offset];
        allParams.addEntriesFromDictionary(parameters);
        
        if(param.count>0){
            allParams.addEntriesFromDictionary(param);
        }
        
        //println(allParams);
        
        return self.GET("search", parameters: allParams, success: success, failure: failure)
    }
    
    func getBusinessById(businessId: String, success:(AFHTTPRequestOperation!, AnyObject!) -> Void, faliure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation{
        return self.GET("business/\(businessId)", parameters: nil, success: success, failure: faliure)
    }
    
}
