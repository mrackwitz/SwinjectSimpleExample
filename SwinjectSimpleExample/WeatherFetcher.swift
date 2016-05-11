//
//  WeatherFetcher.swift
//  SwinjectSimpleExample
//
//  Created by Yoichi Tagaya on 8/10/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

struct WeatherFetcher {
    let networking: Networking
    let realm: Realm
    
    func fetch(response: [City]? -> ()) {
        networking.request { data in
            let cities = data.map { self.decode($0) }
            response(cities)
        }
    }
    
    private func decode(data: NSData) -> [City] {
        let json = JSON(data: data)
        var cities = [City]()
        try! realm.write {
            for (_, j) in json["list"] {
                if let city = createOrUpdateDecodedCity(j) {
                    realm.add(city, update: true)
                    cities.append(city)
                }
            }
        }
        return cities
    }

    private func createOrUpdateDecodedCity(json: JSON) -> City? {
        guard let id = json["id"].int else {
            return nil
        }
        let city: City
        if let existingCity = realm.objectForPrimaryKey(City.self, key: id) {
            city = existingCity
        } else {
            city = City(value: ["id": id])
        }
        city.name = json["name"].string ?? ""
        city.weather = json["weather"][0]["main"].string ?? ""
        return city
    }
}
