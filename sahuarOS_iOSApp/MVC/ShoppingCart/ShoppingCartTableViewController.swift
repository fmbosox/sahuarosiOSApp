//
//  ShoppingCartTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/16/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class ShoppingCartTableVievarntroller: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
          
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    @objc func shoppingCartButtonPressed () {
        print("Post Request")
        let webService = WebService<SahuaroOrder>(resourcePath: "", createOrder: true)
        
        var procesedProducts: [ProcesedOrderProduct] = []
        for sahuaroProduct in ShoppingCart.shared.sahuaroProducts  {
            let procesedProduct = ProcesedOrderProduct(productID: sahuaroProduct.id, amount: 1)
            procesedProducts.append(procesedProduct)
        }
        let order = SahuaroOrder(customerID: SahuarosAppData.UserID, products: procesedProducts)
        webService.sendOrder(order) { [weak self] webServiceResponse in
            switch webServiceResponse {
            case .failure:
                print("There was an error Posting")
            case .success:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let alert = UIAlertController(title: "Exito",
                                                  message: "Productos se estan procesando en la impresora 3D",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.reset()
                }
            }
        }
        
    }
    
    
    
    func reset() {
        ShoppingCart.shared.sahuaroProducts = []
        tableView.reloadData()
         self.navigationController?.tabBarController?.tabBar.items?[2].badgeValue = nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            if ShoppingCart.shared.sahuaroProducts.count < 1 {
                return 0
            } else {
                return 1
            } }
        return ShoppingCart.shared.sahuaroProducts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Product Order Cell", for: indexPath)
            cell.textLabel?.text = "SKU: " + ShoppingCart.shared.sahuaroProducts[indexPath.row].SKU
            cell.detailTextLabel?.text = "Cantidad: 1"
        } else {
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "Place Order Cell", for: indexPath) as! ButtonTableViewCell
            buttonCell.confirmButton.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5843137255, blue: 0.5215686275, alpha: 1)
            buttonCell.confirmButton.addTarget(self, action: #selector(shoppingCartButtonPressed), for: .touchUpInside)
            cell = buttonCell
        }
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == 0 else { return false }
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if ShoppingCart.shared.sahuaroProducts.count < 2 {
                reset()
                return
            }
            tableView.performBatchUpdates({
                ShoppingCart.shared.sahuaroProducts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: nil)
            
             self.navigationController?.tabBarController?.tabBar.items?[2].badgeValue = "\(ShoppingCart.shared.sahuaroProducts.count)"
            
            
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
