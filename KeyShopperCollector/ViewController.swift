//
//  ViewController.swift
//  KeyShopperCollector
//
//  Created by Jay P. Hayes on 11/25/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [MasterItems] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try items = context.fetch(MasterItems.fetchRequest())
            tableView.reloadData()
            print(items)
        } catch  {
            print("ERROR")
        }
        
        
    }
    
    //MARK:  - Table Datasource and deletegage
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let item = items[indexPath.row]
        cell.textLabel?.text  = item.name
        cell.imageView?.image = UIImage(data: item.image as! Data)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
  }




















