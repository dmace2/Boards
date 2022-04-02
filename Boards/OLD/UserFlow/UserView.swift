//
//  UserView.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/17/21.
//

import SwiftUI

struct UserView: View {
    private var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle").resizable().scaledToFit().frame(maxHeight: 30).padding()
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email)
            }
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
