//
//  API.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 14.07.22.
//

import Foundation

enum API: String {

    case map = "https://fish-pits.krokam.by/api/rest/points/"
    
    var url: URL? {
        return URL(string: API.map.rawValue)
    }
}
