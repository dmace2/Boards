//
//  TextContent.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI

struct TextContentView: View {
    var tc: TextContent
    
    init(_ textContent: TextContent) {
        tc = textContent
    }
    
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).cornerRadius(10)
            VStack(alignment: .leading) {
                Text(tc.title).font(.title).bold()
                Text(tc.text)
            }
            .padding()
        }
    }
}
