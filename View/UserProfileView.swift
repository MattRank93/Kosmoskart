//
//  UserProfileView.swift
//  Kosmoskart
//
//  Created by Matt R on 4/14/24.
//


import SwiftUI

struct UserProfileView: View {
    let user: UserModel
    @Binding var selectedIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("User Profile")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Username: \(user.username)")
            Text("First Name: \(user.firstname)")
            Text("Last Name: \(user.lastname)")
            Text("Email: \(user.email)")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}
