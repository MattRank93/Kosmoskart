import SwiftUI

import SwiftUI

// Define an enum to represent navigation destinations
enum NavigationDestination: Hashable {
    case newView
    case registerView
    case loginView
}

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @State private var selectedDestination: NavigationDestination?
    @State private var selectedIndex: Int? = 0
    var body: some View {
        NavigationView {
            if isLoggedIn {

                NewView() // Show NewView when logged in
                    .navigationBarItems(trailing: Button("Logout") {
                        isLoggedIn = false

                    })
            } else {
                VStack {
                    NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn), tag: .loginView, selection: $selectedDestination) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: RegisterView(), tag: .registerView, selection: $selectedDestination) {
                        EmptyView()
                    }

                    Button("Login") {
                        selectedDestination = .loginView
                    }
                    .padding()
                    .buttonStyle(DarkRedButtonStyle())

                    Button("Register") {
                        selectedDestination = .registerView
                    }
                    .padding()
                    .buttonStyle(DarkRedButtonStyle())
                }
                .navigationTitle("Welcome") // Optional: add a title to the navigation bar
            }
            Spacer() // Add spacer to push BottomBar to the bottom
        }
        .onChange(of: isLoggedIn) { newValue in
            print("is logged in: \(newValue)")
        }
        .onChange(of: selectedDestination) { newValue in
            print("selectedDestination \(String(describing: newValue))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
