//
//  sahuarOS_Data .swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/15/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import Foundation


struct PropertyKeys {
    
    
}


struct SahuarosAppData {
    
    static let categories = [
        Category(name: "Maquinaria", subCategories: [("Empacadora",1),("Cortadora",2),("Tractor",3)]),
        Category(name: "Riego", subCategories: [("Valvulas",1004),("Coples",1005)]),
    ]
    
    
    static let UserID = 1
    
    
    static let ordersHistory: [String] = ["A4832","A4632","A4442","A4421","A4334"]
    
    
}



struct Category {
    let name: String
    let subCategories: [(name: String,id: Int)]
}
