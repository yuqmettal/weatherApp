//
//  NetworkManagerProvider.swift
//  WeatherApp
//
//  Created by myuquilima on 3/13/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import Moya

enum NetworkManagerProvider {
    case getLocalWeather(lat:Double, lon:Double)
    case getCityWeather(city:String)
    case getFiveDaysWeather(lat:Double, lon:Double)
}

extension NetworkManagerProvider: TargetType {
    var baseURL: URL {
        return URL(string:"https://api.openweathermap.org/data/2.5")!
    }
    
    var path: String {
        switch self {
        case .getLocalWeather(_, _):
            return String("weather")
        case .getFiveDaysWeather(_,_):
            return String("forecast")
        case .getCityWeather(_):
            return String("weather")
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var parameters: [String: Any] {
        var parameters = [String: Any]()
        parameters["APPID"] = "97e4d09afbe34d8c2fb45fe7adbe3198"
        parameters["units"] = "metric"
        parameters["cn"] = "0"
        switch self {
        case .getLocalWeather(let lat, let lon):
            parameters["lat"] = lat
            parameters["lon"] = lon
            return parameters
        case .getFiveDaysWeather(let lat, let lon):
            parameters["lat"] = lat
            parameters["lon"] = lon
            return parameters
        case .getCityWeather(let city):
            parameters["q"] = city
            return parameters
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
