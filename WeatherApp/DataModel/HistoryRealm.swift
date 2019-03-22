//
//  HistoryRealm.swift
//  WeatherApp
//
//  Created by myuquilima on 3/21/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryRealm:Object {
    @objc dynamic var city:String = ""
    @objc dynamic var date:Date = Date()
    @objc dynamic var main:String = ""
    
    convenience init(city:String, main:String){
        self.init()
        self.city = city
        self.main = main
        
    }
}
