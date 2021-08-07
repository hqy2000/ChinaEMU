//
//  UserDefaults.swift
//  chinaemu
//
//  Created by Qingyang Hu on 11/15/20.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var favoriteTrains: DefaultsKey<[Favorite]> {.init("favoriteTrains", defaultValue: []) }
    var favoriteEMUs: DefaultsKey<[Favorite]> {.init("favoriteEMUs", defaultValue: []) }
    var lastDeparture: DefaultsKey<Station>{.init("lastDeparture", defaultValue: Station(name: "北京", code: "BJP", pinyin: "beijing", abbreviation: "bj")) }
    var lastArrival: DefaultsKey<Station>{.init("lastArrival", defaultValue: Station(name: "上海", code: "SHH", pinyin: "shanghai", abbreviation: "sh")) }
}

struct Favorite: Codable, Hashable, DefaultsSerializable {
    let name: String
    let isPushEnabled: Bool
    
    init(_ name: String) {
        self.name = name
        self.isPushEnabled = false
    }
}
