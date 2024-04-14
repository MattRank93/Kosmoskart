//
//  LoginView.swift
//  Kosmoskart
//
//  Created by Matt R on 4/11/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                // Call login API
                LoginManager.login(username: username, password: password) { success in
                    if success {
                        isLoggedIn = true
                    } else {
                        // Handle login failure
                        print("Login failed")
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false)) // Use a binding with an initial value
    }
}
