//
//  CategoriesTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let categories = SahuarosAppData.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard categories.count > section else { return 0 }
        return categories[section].subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category Cell", for: indexPath)
        guard categories.count > indexPath.section else { return cell }
        cell.textLabel?.text = categories[indexPath.section].subCategories[indexPath.row].name
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Get Products Segue" {
            guard let vc = segue.destination as? ProductsTableViewController, let section = tableView.indexPathForSelectedRow?.section, let row = tableView.indexPathForSelectedRow?.row else { return }
            vc.subCategory = categories[section].subCategories[row].name
            vc.subCategoryID = categories[section].subCategories[row].id
            vc.navigationItem.title = categories[section].subCategories[row].name
            
        }
    }

}
