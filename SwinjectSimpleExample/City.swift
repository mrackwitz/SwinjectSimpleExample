//
//  City.swift
//  SwinjectSimpleExample
//
//  Created by Yoichi Tagaya on 8/10/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import RealmSwift

class City: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var weather: String = ""

    override static func primaryKey() -> String {
        return "id"
    }
}
