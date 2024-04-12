import SwiftUI

// Define an enum to represent navigation destinations
enum NavigationDestination: Hashable {
    case newView
    case registerView
    case loginView
}


struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    @State private var isNavigateToDestination: Bool = false
    @State private var selectedDestination: NavigationDestination?

    var body: some View {
        NavigationView {
            if isLoggedIn {
                NewView() // Show NewView when logged in
                    .navigationBarItems(trailing: Button("Logout") {
                        isLoggedIn = false
                    })
            }else {
                VStack {
                    NavigationLink(destination: destinationView, isActive: $isNavigateToDestination) { EmptyView() }
                    
                    Button("Login") {
                        selectedDestination = .loginView
                        isNavigateToDestination = true
                    }
                    .padding()
                    .buttonStyle(DarkRedButtonStyle())

                    Button("Register") {
                        selectedDestination = .registerView
                        isNavigateToDestination = true
                    }
                    .padding()
                    .buttonStyle(DarkRedButtonStyle())
                }
                .navigationTitle("Welcome") // Optional: add a title to the navigation bar
            }
        }
    }
    
    private var destinationView: some View {
        switch selectedDestination {
        case .loginView:
            return AnyView(LoginView(isLoggedIn: $isLoggedIn))
        case .registerView:
            return AnyView(RegisterView())
        default:
            return AnyView(EmptyView())
        }
    }
}

    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
