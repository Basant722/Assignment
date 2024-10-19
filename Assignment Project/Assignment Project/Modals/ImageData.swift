//
//  ImageData.swift
//  Assignment Project
//
//  Created by Basant Kumar on 18/10/24.
//

import Foundation


struct ImageData: Codable {
    let id: String
    let urls: ImageUrls
}

struct ImageUrls: Codable {
    let regular: String
}





struct ImageResponse: Codable {
    let results: [ImageData]
}
