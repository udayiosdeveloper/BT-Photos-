//
//  Photo.swift
//  BT-Photos
//
//  Created by Mac on 07/03/24.
//

import Foundation
struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
