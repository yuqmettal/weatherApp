//
//  LocalWeatherViewModel.swift
//  WeatherApp
//
//  Created by myuquilima on 3/14/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class WeatherViewModel{
    let weatherService = WeatherService()
    var cityName = PublishSubject<String>()
    var icon = PublishSubject<String>()
    var temp = PublishSubject<String>()
    var description = PublishSubject<String>()
    
    var list:PublishSubject<[WeatherInfo]> = PublishSubject<[WeatherInfo]>()
    
    let bag = DisposeBag()
    
    func downloadLocalWeather(lat:Double, lon:Double) {
        weatherService.getLocalWeather(lon: lon, lat: lat).subscribe{(event) in
            switch event{
            case .success(let weather):
                self.cityName.onNext(weather?.name ?? "No name")
                self.temp.onNext(String(format:"%.0f", weather?.main?.temp ?? "X"))
                self.icon.onNext(weather?.weather?[0].icon ?? "")
                self.description.onNext(weather?.weather?[0].description ?? "")
            case .error(let error):
                print("hubo un error.. trata de descifrar lo siguiente")
                print(error)
                break
            }
        }.disposed(by: bag)
    }
    
    func downloadCityWeather(city:String) {
        weatherService.getCityWeather(city: city).subscribe{(event) in
            switch event{
            case .success(let weather):
                self.cityName.onNext(weather?.name ?? "No name")
                self.temp.onNext(String(format:"%.0f", weather?.main?.temp ?? "X"))
                self.icon.onNext(weather?.weather?[0].icon ?? "")
                self.description.onNext(weather?.weather?[0].description ?? "")
            case .error(let error):
                print("hubo un error.. trata de descifrar lo siguiente")
                print(error)
                break
            }
            }.disposed(by: bag)
    }
    
    func downloadFiveDaysWeather(lat:Double, lon:Double) {
        weatherService.getFiveDaysWeather(lon:lon,lat:lat).subscribe{(event) in
            switch event{
            case .success(let weather):
                self.list.onNext(weather?.list ?? [])
                break
            case .error(let error):
                print(error)
                break
            }
        }.disposed(by: bag)
    }
}
