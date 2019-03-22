//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by myuquilima on 3/21/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import UIKit
import RealmSwift
import RxCocoa
import RxSwift
import RxDataSources
import Kingfisher


class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    
    var cities:[CityRealm] = []
    let weatherVM = WeatherViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
        cityTextField.delegate = self
        bindViewModel()
    }
    
    func bindViewModel() {
        goButton.rx.tap.bind {
            print(self.cityTextField.text!)
            self.weatherVM.downloadCityWeather(city: self.cityTextField.text!)
        }.disposed(by: bag)
        
        weatherVM.temp.bind(to: tempLabel.rx.text).disposed(by: bag)
        weatherVM.icon.bind { icon in
            self.iconImageView.kf.setImage(with: URL(string: "https://openweathermap.org/img/w/\(icon).png"))
            self.iconImageView.isHidden = false
            self.tempLabel.isHidden = false
            self.symbolLabel.isHidden = false
            }.disposed(by: bag)
        weatherVM.description.bind { main in
            self.saveHistory(main: main)
        }.disposed(by: bag)
    }
    
    func saveHistory (main:String){
        let record = HistoryRealm(city: cityTextField.text!, main: main)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(record)
            }
        } catch{}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.iconImageView.isHidden = true
        self.tempLabel.isHidden = true
        self.symbolLabel.isHidden = true
        let realm = try! Realm()
        cities = realm.objects(CityRealm.self).map{$0}
        cityPickerView.reloadAllComponents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cityPickerView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cityPickerView.isHidden = false
        cityTextField.text = cities[cityPickerView.selectedRow(inComponent: 0)].name
        return false
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.text = cities[row].name
    }
}
