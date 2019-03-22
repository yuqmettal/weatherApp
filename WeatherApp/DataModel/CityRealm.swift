//
//  CityRealm.swift
//  WeatherApp
//
//  Created by myuquilima on 3/21/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import RealmSwift

class CityRealm:Object {
    @objc dynamic var name:String=""
    @objc dynamic var days:Int=1
    
    convenience init(name:String, days:Int) {
        self.init()
        self.name = name
        self.days = days
    }
}
