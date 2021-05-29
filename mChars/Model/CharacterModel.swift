//
//  CharacterModel.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//

import Foundation

struct MCharacterWrapper: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MCWrapperData?
}

struct MComicsWrapper: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MComicsWrapperData?
}

struct MCWrapperData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MCharacter]?
}


struct MComicsWrapperData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MComics]?
}
struct MCharacter: Codable {
    
        var id: Int?
        var name: String?
        var description: String?
        var modified: String?
        var resourceURI: String?
        var urls: [ MCURL ]?
        var thumbnail: MCThumbnail?
        var comics: MComics?
}

struct MComics: Codable {
    var id: Int?
    var digitalId: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var description: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [TextObject]?
    var resourceURI: String?
    var urls: [MCURL]?
    var series: MCSeries?
    var variants: [MCVariant]?
    var dates: [MCDates]?
    var prices: [MCPrice]?
    var thumbnail: MCThumbnail?
    var creators: MCCreators?
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [MItem]?
    var characters: MCoChar?
   
}

struct MCoChar: Codable {
    var avaliable: Int?
    var collectionURI: String?
    var items: [MItem]?
    var returned: Int?
}

struct MCVariant: Codable {
    var resourceURI: String?
    var name: String?
}

struct MCSeries: Codable {
    var resourceURI: String?
    var name: String?
}

struct MCURL: Codable {
    var type: String?
    var url: String?
}

struct TextObject: Codable {
    var text: String?
    var type: String?
    var language: String?
    
}

struct MCDates: Codable {
    var type: String?
    var date: String?
}

struct MCPrice: Codable {
    var type: String?
    var price: Float?
}

struct MCThumbnail: Codable {
    var path: String?
    var `extension`: String?
}

struct MCCreators: Codable {
      var available: Int?
      var collectionURI: String?
      var items: [MItem]?
      var returned: Int?
}

struct MItem: Codable {
    
    var resourceURI: String?
    var name: String?
    var role: String?
    var type: String?
}
