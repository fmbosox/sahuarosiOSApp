//
//  ProductsTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var subCategory: String?
    var subCategoryID: Int?
    var sahuaroProducts: [SahuaroProduct] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = subCategoryID else { return }
        print("Get http: \(subCategory!) id: \(id)")
        let webService = WebService<SahuaroProduct>(resourcePath: "Category/\(id)")
        webService.getAll { [weak self] webServiceResponse in
            switch webServiceResponse {
            case .failure:
                print("There was an error getting the products")
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.sahuaroProducts = products
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sahuaroProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.productDescription.text = sahuaroProducts[indexPath.row].description
        cell.productName.text = sahuaroProducts[indexPath.row].SKU
        return cell
    }
 

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Product Detail Segue" {
            guard let vc = segue.destination as? ProductDetailTableViewController, let row = tableView.indexPathForSelectedRow?.row else { return }
            vc.sahuaroProduct = sahuaroProducts[row]
            
        }
    }

}
