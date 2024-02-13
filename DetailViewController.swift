//
//  DetailViewController.swift
//  Consolidation6
//
//  Created by Venkata on 2/12/24.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController {
    
    var countryCapital = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCapital.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDetail", for: indexPath)
        cell.textLabel?.text = countryCapital[indexPath.row]
        return cell
    }
}
