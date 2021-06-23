//
//  User.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import Foundation
import SwiftUI

struct User: Identifiable, Hashable {
    var id: String
    var name: String
    var imageURL: String?
    var email: String
}
