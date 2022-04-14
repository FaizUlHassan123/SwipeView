//
//  MatchData.swift
//  swipeView
//
//  Created by Faiz Ul Hassan on 3/24/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

class matchData: NSObject {

    var age:String!
    var first_name:String!
    var height:String!
    var id:String!
    var last_name:String!
    var latitude:String!
    var longitude:String!
    var location:String!
    var looking_for:String!
    var image_id: String!
    var image_url: String!

    init(age:String,first_name:String,height:String,id:String,last_name:String,lat:String,long:String,location:String,looking_for:String,image_id:String,image_url:String) {
        self.age = age
        self.first_name = first_name
        self.height = height
        self.id = id
        self.last_name = last_name
        self.latitude = lat
        self.longitude = long
        self.location = location
        self.looking_for = looking_for
        self.image_id = image_id
        self.image_url = image_url

    }

}
