import SwiftUI

// Define an enum to represent navigation destinations
enum NavigationDestination: Hashable {
    case newView
    case registerView
}

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedDestination: NavigationDestination?

    var body: some View {
        if let destination = selectedDestination {
            switch destination {
            case .newView:
                NewView()
            case .registerView:
                RegisterView()
            }
        } else {
            loginView
        }
    }

    var loginView: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("KosmosKart!")

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    self.selectedDestination = .newView
                }
                .buttonStyle(DarkRedButtonStyle())

                Button("Register") {
                    self.selectedDestination = .registerView
                }
                .buttonStyle(DarkRedButtonStyle())
            }
            .padding()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

