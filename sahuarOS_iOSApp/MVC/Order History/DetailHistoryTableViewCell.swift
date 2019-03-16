//
//  DetailHistoryTableViewCell.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/16/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class DetailHistoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    var productId: Int! {
        didSet{
            let webService = WebService<Data>(resourcePath: "image/\(productId!)")
            webService.getData { [weak self] webServiceResponse in
                switch webServiceResponse {
                case .failure:
                    print("There was an error getting the Image Data")
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        guard let image = UIImage(data: data) else { return }
                        self.productImageView.image = image
                        print("you got an Image")
                    }
                }
            }
        }
    }
    
    
    
   

}
