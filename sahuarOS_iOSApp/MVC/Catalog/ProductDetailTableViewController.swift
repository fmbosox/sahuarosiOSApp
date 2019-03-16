//
//  ProductDetailTableViewController.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {
    
    var sahuaroProduct: SahuaroProduct!

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var orderProductButton: UIButton! {
        didSet{
            orderProductButton.layer.cornerRadius = 5.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = nil
        tableView.tableFooterView = UIView()
        navigationItem.title = sahuaroProduct.SKU
        productNameLabel.text = sahuaroProduct.name
        productDescriptionLabel.text = sahuaroProduct.description
        print("Get http: \(sahuaroProduct.name) id: \(sahuaroProduct.id)")
        let webService = WebService<Data>(resourcePath: "image/\(sahuaroProduct.id)")
        webService.getData { [weak self] webServiceResponse in
            switch webServiceResponse {
            case .failure:
                print("There was an error getting the Image Data")
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let image = UIImage(data: data) else { return }
                    self.productImage.image = image
                    print("you got an Image")
                }
            }
        }
        
    }

    
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        print("Sendind to the cart")
        ShoppingCart.shared.addProductToShoppingCart(product: sahuaroProduct)
        self.navigationController?.tabBarController?.tabBar.items?[2].badgeValue = "\(ShoppingCart.shared.sahuaroProducts.count)"
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 { //Contact developer: Open mail app with a default sender direction.
            if let url = URL(string: "mailto:info@sahuaros.com") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }

}
