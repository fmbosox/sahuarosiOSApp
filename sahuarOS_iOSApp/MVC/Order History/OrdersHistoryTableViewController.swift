//
//  OrdersHistoryTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class OrdersHistoryTableViewController: UITableViewController {
    
    var orders: [SahuaroOrderHistory] = []
    let historyWebService = WebService<SahuaroOrderHistory>(historyCustomerID: SahuarosAppData.UserID)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Get http: user history")
        historyWebService.getAll { [weak self] webServiceResponse in
            switch webServiceResponse {
            case .failure:
                print("There was an error getting the products")
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.orders = products
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
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order Cell", for: indexPath)
        cell.textLabel?.text = "Pedido #" + "\(orders[indexPath.row].id)"
        return cell
    }
 

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detailed History Segue", let vc = segue.destination as? OrderDetailTableViewController, let cell = sender as? UITableViewCell, let row = tableView.indexPath(for: cell)?.row{
            vc.orderTogetDetailsID = orders[row].id
            vc.navigationItem.title = "Pedido #" + "\(orders[row].id)"
            
            
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
