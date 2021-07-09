//
//  DonutListViewController.swift
//  IterableUIKitSample
//
//  Created by Christina Schell on 7/7/21.
//

import UIKit

class DonutListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var donuts = [Donut]()
    let cellId = "donutCell"
    
    override func viewDidLoad() {
        donuts = DonutManager.donuts
        self.title = "Menu"
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = donuts[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        donuts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDonut = donuts[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DonutDetailViewController") as? DonutDetailViewController {
            viewController.donut = selectedDonut
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
