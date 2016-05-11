//
//  SwinjectStoryboard+Setup.swift
//  SwinjectSimpleExample
//
//  Created by Yoichi Tagaya on 11/20/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Swinject
import RealmSwift

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.registerForStoryboard(WeatherTableViewController.self) { r, c in
            c.weatherFetcher = r.resolve(WeatherFetcher.self)
        }
        defaultContainer.register(Networking.self) { _ in Network() }
        defaultContainer.register(WeatherFetcher.self) { r in
            WeatherFetcher(networking: r.resolve(Networking.self)!,
                           realm: r.resolve(Realm.self)!)
        }
        defaultContainer.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
        }
        defaultContainer.register(Realm.self) { r in
            try! Realm(configuration: r.resolve(Realm.Configuration.self)!)
        }
    }
}
