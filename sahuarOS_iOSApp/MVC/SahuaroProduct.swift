//
//  SahuaroProduct.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import Foundation

struct ShoppingCart {
    
    static var shared = ShoppingCart()
    
    var sahuaroProducts: [SahuaroProduct] =  []
    
    func addProductToShoppingCart(product: SahuaroProduct) {
        ShoppingCart.shared.sahuaroProducts.append(product)
    }
    
    
}

class SahuaroOrder: Codable {
    let customerID: Int
    let products: [ProcesedOrderProduct]
    
    init (customerID: Int, products: [ProcesedOrderProduct]) {
        self.customerID = customerID
        self.products = products
    }
    
    enum CodingKeys: String, CodingKey {
        case customerID = "CustomerId"
        case products = "Products"
    }
    
}

class ProcesedOrderProduct: Codable {
    let productID:Int
    let amount:Int
    
    init (productID: Int, amount: Int) {
        self.productID = productID
        self.amount = amount
    }
    
    enum CodingKeys: String, CodingKey {
        case productID = "ProductId"
        case amount = "Amount"
    }
    
    
}

class SahuaroOrderHistory: Codable {
    let id: Int
    let lastModified: String
    let status: String
    
    init(id: Int, modified: String, status: String){
        self.id = id
        self.lastModified = modified
        self.status = status
    }
}


class SahuaroP: Codable {
    let id: Int
    let SKU: String
    let name: String
    let description: String
    let status: String
    
    
    init(id: Int, SKU: String, name: String, description: String,status: String){
        self.id = id
        self.SKU = SKU
        self.name = name
        self.description = description
        self.status = status
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case SKU = "sku"
        case name
        case description = "descripciton"
        case status
    }
    
    
}


class SahuaroOrderDetailHistory: Codable {
    let products: [SahuaroP]
    let id: Int
    let status: String
    let creatAt: String
  
    init(products:[SahuaroP], id: Int, status: String, creatAt: String ){
        self.products = products
        self.id = id
        self.status = status
        self.creatAt = creatAt
    }
    
    
}




class SahuaroProduct: Codable {
    let id: Int
    let SKU: String
    let name: String
    let description: String
   
    
    init(id: Int, SKU: String, name: String, description: String){
        self.id = id
        self.SKU = SKU
        self.name = name
        self.description = description
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case SKU = "sku"
        case name
        case description = "descripciton"
    }
    
    
}
