//
//  WebService.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/16/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import Foundation


enum SahuaroGETRequest<T> {
    case success([T])
    case failure
}

enum ImageDataGETRequest {
    case success(Data)
    case failure
}

enum OrderPostedResult {
    case success
    case failure
}

struct WebService<T> where T: Codable {
    
    let baseURL = "http://192.168.1.214:5000/Product"
    let basePostURL = "http://192.168.1.214:5000/order/create"
    let resourceURL: URL
    
    init(resourcePath: String, createOrder: Bool? = nil) {
        var basePath: String!
        if let createOrder = createOrder, createOrder == true {
                basePath = basePostURL
        }else {
            basePath = baseURL
        }
        
        guard let resourceURL = URL(string: basePath) else {
            fatalError()
        }
        self.resourceURL = basePath ==  baseURL ? resourceURL.appendingPathComponent(resourcePath) : resourceURL
    }
    
    init(historyCustomerID: Int){
        let basePath = "http://192.168.1.214:5000/customer/history"
        guard let resourceURL = URL(string: basePath) else {
            fatalError()
        }
        self.resourceURL = resourceURL.appendingPathComponent("\(historyCustomerID)")
    }
    
    init(orderHistoryDetailID: Int){
        let basePath = "http://192.168.1.214:5000/order/details"
        guard let resourceURL = URL(string: basePath) else {
            fatalError()
        }
        self.resourceURL = resourceURL.appendingPathComponent("\(orderHistoryDetailID)")
    }
    
    func getOne(completion: @escaping (SahuaroGETRequest<T>) -> Void) {
        print(resourceURL)
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure)
                return
            }
            do {
                let decoder = JSONDecoder()
                let resources = try decoder.decode(T.self, from: jsonData)
                completion(.success([resources]))
            } catch {
                completion(.failure)
            }
        }
        dataTask.resume()
    }
    
    
    func getAll(completion: @escaping (SahuaroGETRequest<T>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure)
                return
            }
            do {
                let decoder = JSONDecoder()
                let resources = try decoder.decode([T].self, from: jsonData)
                completion(.success(resources))
            } catch {
                completion(.failure)
            }
        }
        dataTask.resume()
    }
    
    func getData(completion: @escaping (ImageDataGETRequest)-> Void ){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let unwrappedData = data else {
                completion(.failure)
                return
            }
                completion(.success(unwrappedData))
            }
        dataTask.resume()
    }
    
    
    
    func sendOrder(_ resourceToSave: T, completion: @escaping (OrderPostedResult) -> Void) {
        do {
            
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(resourceToSave)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure)
                    return
                }
                guard httpResponse.statusCode == 200 else {
                    if httpResponse.statusCode == 401 {
                    }
                    completion(.failure)
                    return
                }
                    completion(.success)

            }
            dataTask.resume()
        } catch {
            completion(.failure)
        }
    }
}
    
    

