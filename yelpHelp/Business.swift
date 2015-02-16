//
//  Business.swift
//  yelpHelp
//
//  Created by Anoop tomar on 2/10/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//


class Business: NSObject {
    
    var Id: String!;
    var imageUrl: String!;
    var name: String!;
    var ratingImageUrl: String!;
    var numReviews: Int!;
    var address: String!;
    var categories: String!;
    var distance: Float!;
    var latitude: Double!;
    var longitude: Double!;
    
    func convertDictionaryToBusiness(param: NSDictionary!) -> Business{
        
        // get business id
        self.Id = param["id"] as NSString;
        
        if(param["categories"] != nil){
            var category: NSArray = param["categories"] as NSArray;
            var categoryNames = NSMutableArray();
            
            //println(category);
            
            category.enumerateObjectsUsingBlock({
                object, index, stop in categoryNames.addObject(object[0]);
            });
            
            self.categories = categoryNames.componentsJoinedByString(", ");
        }
        
       // println(param["name"]);
        self.name = param["name"] as NSString;
        
        self.imageUrl = param["image_url"] == nil ? "http://icons.iconarchive.com/icons/graphicloads/colorful-long-shadow/128/Restaurant-icon.png": param["image_url"] as NSString;
        
       // println(param.valueForKeyPath("location.address"));
        var street = (param.valueForKeyPath("location.address") as NSArray).count > 0 ? (param.valueForKeyPath("location.address") as NSArray)[0] as NSString : "";
        
       // println(param.valueForKeyPath("location.neighborhoods"));
        var neighborhood="NONE";
        
        if(param.valueForKeyPath("location.neighborhoods") != nil){
           neighborhood = (param.valueForKeyPath("location.neighborhoods") as NSArray).count > 0 ?(param.valueForKeyPath("location.neighborhoods") as NSArray)[0] as NSString : "";
        }
        
        if(param.valueForKeyPath("location.coordinate.latitude") != nil){
            latitude = param.valueForKeyPath("location.coordinate.latitude") as Double;
            longitude = param.valueForKeyPath("location.coordinate.longitude") as Double;
        }
        
        self.address = "\(street), \(neighborhood)";
        
       // println(param["review_count"]);
        self.numReviews = param["review_count"] as Int;
        
       // println(param["rating_img_url"]);
        self.ratingImageUrl = param["rating_img_url"] as NSString;
        
        var milesPerMeter: Float = 0.000621371;
        
       // println(param["distance"]);
        self.distance = (param["distance"] as Float) * milesPerMeter;
        
       // println("--------------------------------------------------");
        return self;
    }
    
    func businessesWithDictionaries(array: NSArray) -> [Business]{
        var businesses:[Business] = [Business]();
        
        if(array.count > 0){
            for dictionary in array {
                if((dictionary as NSDictionary).count>0){
                    var business: Business = Business().convertDictionaryToBusiness(dictionary as NSDictionary);
                    businesses.append(business);
                }
            }
        }
        
        return businesses;
    }
}
