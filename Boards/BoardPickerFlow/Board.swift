//
//  Board.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import Foundation
import SwiftUI

struct Board: Identifiable, Hashable {
    var id: String
    var name: String
    var color: Color
    var users: [String]
    var lastEdited: Date
}
