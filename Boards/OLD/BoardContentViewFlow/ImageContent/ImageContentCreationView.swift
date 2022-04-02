//
//  ImageContentCreationView.swift
//  Boards
//
//  Created by Dylan Mace on 6/23/21.
//

import SwiftUI

struct ImageContentCreationView: View {
    @EnvironmentObject private var viewModel: BoardContentViewModel
    
    var body: some View {
        Text("Hello, World!")
            .navigationTitle("New Image Post")
    }
}

struct ImageContentCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ImageContentCreationView()
    }
}
