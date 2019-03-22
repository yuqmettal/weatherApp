//
//  WeatherService.swift
//  WeatherApp
//
//  Created by myuquilima on 3/13/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

typealias LocalWeatherSequence = PrimitiveSequence<SingleTrait, LocalWeatherMapper?>
typealias FiveDaysWeatherSequence = PrimitiveSequence<SingleTrait, FiveDaysWeatherMapper?>

class WeatherService {
    private let provider = MoyaProvider<NetworkManagerProvider>()
    
    func getLocalWeather(lon:Double, lat:Double) -> LocalWeatherSequence {
        return provider.rx.request(.getLocalWeather(lat: lat, lon: lon))
        .filterSuccessfulStatusCodes()
            .mapJSON()
            .map{Mapper<LocalWeatherMapper>().map(JSONObject: $0)}
    }
    
    func getCityWeather(city:String) -> LocalWeatherSequence {
        return provider.rx.request(.getCityWeather(city:city))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .map{Mapper<LocalWeatherMapper>().map(JSONObject: $0)}
    }
    
    func getFiveDaysWeather(lon:Double, lat:Double) -> FiveDaysWeatherSequence{
        return provider.rx.request(.getFiveDaysWeather(lat:lat, lon:lon))
        .filterSuccessfulStatusCodes()
        .mapJSON()
            .map{Mapper<FiveDaysWeatherMapper>().map(JSONObject: $0)}
    }
}
