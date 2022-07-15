//
//  jsonModel.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 14.07.22.
//

import Foundation

typealias JsonModel = [Model]

// MARK: - JSON
struct Model: Codable {
    let id, langID: Int
    let point: Point
    let pointName: String
    let visible: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case langID = "lang_id"
        case point
        case pointName = "point_name"
        case visible
    }
}

// MARK: - Point
struct Point: Codable {
    let id, pointDistrictID, waterObjectID: Int
    let pointGeoType: PointGeoType
    let lat, lng: Double
    let lat2, lng2: Double?
    let visible: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case pointDistrictID = "point_district_id"
        case waterObjectID = "water_object_id"
        case pointGeoType = "point_geo_type"
        case lat, lng
        case lat2 = "lat_2"
        case lng2 = "lng_2"
        case visible
    }
}

enum PointGeoType: String, Codable {
    case line = "Line"
    case point = "Point"
}
