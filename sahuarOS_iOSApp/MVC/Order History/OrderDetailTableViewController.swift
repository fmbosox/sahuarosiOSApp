//
//  OrderDetailTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class OrderDetailTableViewController: UITableViewController {

    var orderDetail: [SahuaroOrderDetailHistory] = []
    var orderTogetDetailsID: Int!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Get http: user history")
          let detailedHistoryWebService = WebService<SahuaroOrderDetailHistory>(orderHistoryDetailID: orderTogetDetailsID)
        detailedHistoryWebService.getOne { [weak self] webServiceResponse in
            switch webServiceResponse {
            case .failure:
                print("There was an error getting the products")
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.orderDetail = products
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return orderDetail.first?.products.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.row {
        case 0:
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "Product Information Cell", for: indexPath) as? DetailHistoryTableViewCell,  let id = orderDetail.first?.products[indexPath.section].id else { return UITableViewCell() }
            imageCell.productImageView.image = nil
            imageCell.productDescriptionLabel.text = orderDetail.first?.products[indexPath.section].description ?? ""
            imageCell.productNameLabel.text = orderDetail.first?.products[indexPath.section].name
            imageCell.productId = id
            cell = imageCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Status Cell", for: indexPath)
            cell.textLabel?.text = "\(orderDetail.first?.products[indexPath.section].status ?? "N/A")"
            cell.detailTextLabel?.text = "\(orderDetail.first?.creatAt ?? "--")"
            
        default:
            cell = UITableViewCell()
        }
        return cell
        
    }
    
    
}
