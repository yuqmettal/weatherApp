//
//  ViewController.swift
//  WeatherApp
//
//  Created by myuquilima on 3/13/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import UIKit
import CoreLocation
import RxCocoa
import RxSwift
import RxDataSources
import RxCoreLocation
import Kingfisher

class ViewController: UIViewController  {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconUIImageView: UIImageView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var locationManager:CLLocationManager?
    let weatherViewModel = WeatherViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager=CLLocationManager()
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager?.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager?.startUpdatingLocation()
        }
        
        bindLocalWeatherViewModel()
    }

    func bindLocalWeatherViewModel(){
            self.locationManager?.rx.location.subscribe(onNext: { location in
                self.weatherViewModel.downloadLocalWeather(lat: location?.coordinate.latitude ?? 0, lon: location?.coordinate.longitude ?? 0)
                self.weatherViewModel.downloadFiveDaysWeather(lat: location?.coordinate.latitude ?? 0, lon: location?.coordinate.longitude ?? 0)
            }).disposed(by: bag)
        
        weatherViewModel.cityName.asObservable().bind(to:
        cityLabel.rx.text
        ).disposed(by: bag)
        
        weatherViewModel.temp.asObservable().bind(to:
            tempLabel.rx.text
            ).disposed(by: bag)
        
        weatherViewModel.list.bind(to: weatherTableView.rx.items){ tableView, indexpath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTableViewCell
            cell.hourLabel.text = item.dt_txt?.components(separatedBy: " ")[1]
            cell.timeLabel.text = item.weather?[0].main
            print(item.weather?[0].icon)
            cell.weatherImageView.kf.setImage(with: URL(string: "https://openweathermap.org/img/w/\(item.weather?[0].icon ?? "").png"))
            return cell
        }.disposed(by: bag)
        
        weatherViewModel.icon.bind { icon in
            self.iconUIImageView.kf.setImage(with: URL(string: "https://openweathermap.org/img/w/\(icon).png"))
            }.disposed(by: bag)
        
    }
}

