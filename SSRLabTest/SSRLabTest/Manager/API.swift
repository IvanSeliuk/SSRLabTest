//
//  API.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 15.07.22.
//

import Foundation

enum API: String {
//    case APIKey = "9872cf2db2b7f253bfd07c00eb5c255d"
//    case host = "https://api.openweathermap.org/"
//    case city = "data/2.5/weather?q=%@&appid=%@"
//    case icon = "https://openweathermap.org/img/wn/%@@2x.png"
    case map = "https://fish-pits.krokam.by/api/rest/points/"
    
    var url: URL? {
        return URL(string: API.map.rawValue)
    }
}
