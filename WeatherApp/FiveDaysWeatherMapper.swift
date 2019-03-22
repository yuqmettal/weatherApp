//
//  FiveDaysWeatherMapper.swift
//  WeatherApp
//
//  Created by myuquilima on 3/14/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import ObjectMapper

class FiveDaysWeatherMapper:Mappable{
    var list:[WeatherInfo]?
    var city:City?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        list <- map["list"]
        city <- map["city"]
    }
}

class WeatherInfo:Mappable{
    var dt:Int?
    var dt_txt:String?
    var main:Main?
    var weather:[Weather]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        dt <- map["dt"]
        dt_txt <- map["dt_txt"]
        main <- map["main"]
        weather <- map["weather"]
    }
}

class City:Mappable{
    var id:Int?
    var name:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    
}
