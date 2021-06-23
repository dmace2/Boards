//
//  ImageContent.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import Foundation

class ImageContent: ContentItem {
    var url: String = ""
    
    init(id: String, title: String, url: String) {
        super.init()
        self.id = id
        self.title = title
        self.url = url
        self.type = "image"
    }
}
