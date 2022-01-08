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

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod
        case orbitalPeriod
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater
        case population
        case residents
        case films
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        diameter = try container.decode(String.self, forKey: .diameter)
        climate = try container.decode(String.self, forKey: .climate)
        gravity = try container.decode(String.self, forKey: .gravity)
        terrain = try container.decode(String.self, forKey: .terrain)
        surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
        population = try container.decode(String.self, forKey: .population)
        residents = try container.decode([String].self, forKey: .residents)
        films = try container.decode([String].self, forKey: .films)
        created = try container.decode(String.self, forKey: .created)
        edited = try container.decode(String.self, forKey: .edited)
        url = try container.decode(String.self, forKey: .url)
    }
}

struct Resident: Decodable {
    var name: String
//    var height: String
//    var mass: String
//    var hairColor: String
//    var skinColor: String
//    var eyeColor: String
//    var birthYear:String
//    var gender: String
//    var homeworld: String
//    var films: [String]
//    var species: [String]
//    var vehicles: [String]
//    var starships: [String]
//    var created: String
//    var edited: String
//    var url: String
}





