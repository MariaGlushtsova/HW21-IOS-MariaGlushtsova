//
//  SeriesModel.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import Foundation

struct MarvelData: Decodable {
    let data: Results
}

struct Results: Decodable {
    let results: [DataResults]
}

struct DataResults: Decodable {
    let title: String
    let description: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let path: String?
    let `extension`: String?
}
