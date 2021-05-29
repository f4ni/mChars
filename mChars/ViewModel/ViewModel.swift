//
//  ViewModel.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//

import Foundation

struct CharacterViewModel {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [ MCURL ]?
    var thumbnail: String?
    var comics: MComics?
    
    init(model: MCharacter) {
        self.id = model.id
        self.name = model.name
        self.description = "\(model.description?.prefix(240) ?? "")"
        self.thumbnail = ((model.thumbnail?.path ?? "") + "." + (model.thumbnail?.extension ?? "") ).replacingOccurrences(of: "http://", with: "https://")
    }
}
