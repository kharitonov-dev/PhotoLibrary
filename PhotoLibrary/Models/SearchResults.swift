//
//  SearchResults.swift
//  PhotoLibrary
//
//  Created by Timofey Kharitonov on 02.02.2022.
//

import Foundation

// Без протокола Decodable компилятор не сможет переконвертировать из JSON в наш формат
// Здесь описываю первый уровень JSON
struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

// Здесь второй уровень, где сами фото
struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
