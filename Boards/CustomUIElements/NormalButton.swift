//
//  NormalButton.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import Foundation
import SwiftUI

struct NormalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color(.systemBackground))
            .frame(width: 200, height: 50)
            .background(Color(.systemBlue))
            .cornerRadius(5)
    }
}
