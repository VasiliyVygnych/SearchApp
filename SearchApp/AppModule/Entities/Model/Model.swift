//
//  Model.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import Foundation

struct listDrugsModel: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name, description: String
    let documentation: String?
    let fields: [Field]
}
// MARK: - Categories
struct Categories: Codable {
    let id: Int
    let icon, image, name: String
}
// MARK: - Field
struct Field: Codable {
    let typesID: Int
    let name, value: String
    let flags: Flags
    let show, group: Int

    enum CodingKeys: String, CodingKey {
        case typesID = "types_id"
        case name, value, flags, show, group
    }
}
// MARK: - Flags
struct Flags: Codable {
    let html, noValue, noName, noImage: Int
    let noWrap, noWrapName, system: Int

    enum CodingKeys: String, CodingKey {
        case html
        case noValue = "no_value"
        case noName = "no_name"
        case noImage = "no_image"
        case noWrap = "no_wrap"
        case noWrapName = "no_wrap_name"
        case system
    }
}
