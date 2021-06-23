//
//  TextContent.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI

struct TextContent: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Post").font(.title).bold()
            }
        }
    }
}

struct TextContent_Previews: PreviewProvider {
    static var previews: some View {
        TextContent()
    }
}
