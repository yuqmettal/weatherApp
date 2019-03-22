//
//  LocalWeatherMapper.swift
//  WeatherApp
//
//  Created by myuquilima on 3/13/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import ObjectMapper

class LocalWeatherMapper:Mappable{
    var id:Int?
    var name:String?
    var weather:[Weather]?
    var main:Main?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        weather <- map["weather"]
        main <- map["main"]
    }
}

class Weather: Mappable {
    var main:String?
    var description:String?
    var icon:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

class Main : Mappable{
    var temp:Double?
    var pressure:Int?
    var humidity:Int?
    var temp_min:String?
    var temp_max:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        print(map["temp"])
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
}
