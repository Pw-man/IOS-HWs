//
//  Services.swift
//  Navigation
//
//  Created by Роман on 22.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
 
struct NetworkService {
    
    func executeURLSessionDataTask(configuration: AppConfiguration) {
        guard let url = URL(string: configuration.getValue()) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let mySession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask = mySession.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
                }
                print("""
   ====================================================
                      \(response.allHeaderFields)
   ====================================================
                      \(response.statusCode)
""")
            }
        })
        dataTask?.resume()
    }
}

enum AppConfiguration: CaseIterable {
    static var allCases: [AppConfiguration] {
        return [.people("https://swapi.dev/api/people/8"),
                .starships("https://swapi.dev/api/starships/3"), .planets("https://swapi.dev/api/planets/5")]
    }
    
    case people(String)
    case starships(String)
    case planets(String)
    
    func getValue() -> String {
        switch self {
        case .people(let str):
            return str
        case .starships(let str):
            return str
        case .planets(let str):
            return str
        }
    }
}

