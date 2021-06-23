//
//  TextContent.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import Foundation

class TextContent: ContentItem {
    var text: String = ""
    
    init(id: String, title: String, text: String) {
        super.init()
        self.id = id
        self.title = title
        self.text = text
        self.type = "text"
    }
}
