//
//  ViewController.swift
//  shoppingList
//
//  Created by Ahmed Adel on 4/27/19.
//  Copyright © 2019 Ahmed Adel. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items : [String] = []
    var prices : [Int] = []
    var price = 0
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Total is \(price)$"
    }
    
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "new Item", message: "add your item", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Item name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Item price"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let itemName = alert!.textFields![0] // Force unwrapping because we know it exists.
            let itemPrice = alert!.textFields![1] // Force unwrapping because we know it exists.
            //print(itemPrice.text!)
            self.items.append(itemName.text!)
            self.prices.append(Int(itemPrice.text!)!)
            //print(self.items)
            //print(self.prices)
            self.price += Int(itemPrice.text!)!
            self.navigationItem.title = "Total price is \(self.price)$"
            //self.total.text = "Total price is \(self.price)"
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    
    @IBAction func deleteTapped(_ sender: UIBarButtonItem)
    {
        items.removeAll()
        prices.removeAll()
        price = 0
        navigationItem.title = "Total is \(price)$"
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item",for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = "$\(String(prices[indexPath.row]))"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            price -= prices[indexPath.row]
            print(price)
            self.items.remove(at: indexPath.row)
            self.prices.remove(at: indexPath.row)
            print(prices)
            
            navigationItem.title = "Total is \(price)$"
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

}

