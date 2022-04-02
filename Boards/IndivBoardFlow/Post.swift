//
//  Content.swift
//  Boards
//
//  Created by Dylan Mace on 4/1/22.
//

import Foundation

import Foundation
import SwiftUI

struct Post: Identifiable {
    var id: String
    var title: String
    var type: PostType
    var color: Color = Color.secondary
    var timestamp: Date
    var content: Any
}


enum PostType:String {
    case text
    case image
    case none
    
    var rawValue: String {
        switch self {
        case .text: return "text"
        case .image: return "image"
        case .none: return "none"
        }
    }
}
