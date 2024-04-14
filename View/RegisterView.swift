import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the view
    @State private var username: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var validationMessage: String = "" // To display validation messages
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)

            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            if !validationMessage.isEmpty {
                Text(validationMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            Button("Register") {
                print("the user being registered: ")
                registerUser()
                
            }
            .buttonStyle(DarkRedButtonStyle())
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }
    

    private func registerUser() {
        // Basic validation
        if username.isEmpty || firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            validationMessage = "Please fill in all fields."
            return
        }

        if password != confirmPassword {
            validationMessage = "Passwords do not match."
            return
        }

        let user = UserModel(id: 0, username: username, firstname: firstName, lastname: lastName, email: email, password: password)
        
        // Call register function from LoginManager
        LoginManager.register(user: user) { success in
             if success {
                 // Registration successful
                 DispatchQueue.main.async {
                     self.presentationMode.wrappedValue.dismiss()
                 }             } else {
                 // Registration failed
                 validationMessage = "Registration failed. Please try again."
             }
         }
     }
 }


struct DarkRedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.red.opacity(configuration.isPressed ? 0.5 : 1))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
