//
//  HistoryViewController.swift
//  WeatherApp
//
//  Created by myuquilima on 3/21/19.
//  Copyright © 2019 DEVSU. All rights reserved.
//

import UIKit
import RealmSwift

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var history:[HistoryRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        history = realm.objects(HistoryRealm.self).map{$0}
        historyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let city = history[indexPath.row].city
        let date = history[indexPath.row].date.toString(dateFormat: "E MMM dd HH:mm")
        let main = history[indexPath.row].main
        cell.textLabel?.text = "\(city) \(date) \(main)"
        return cell
    }
}
