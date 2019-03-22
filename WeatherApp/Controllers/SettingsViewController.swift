//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by myuquilima on 3/20/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var daysPickerView: UIPickerView!
    
    var days = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysTextField.delegate = self
        daysPickerView.delegate = self
        daysPickerView.dataSource = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        daysPickerView.isHidden = false
        daysTextField.text = days[daysPickerView.selectedRow(inComponent: 0)]
        return false
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        daysTextField.text = days[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        daysPickerView.isHidden = true
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if(cityTextField.text?.trimmingCharacters(in: .whitespaces) != "") {
            let city = CityRealm(name: cityTextField.text!, days: Int(daysTextField.text!) ?? 1)
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(city)
                    let tabBarController = parent as! UITabBarController
                    tabBarController.selectedIndex = 1
                }
            } catch {}
        }
    }
}
