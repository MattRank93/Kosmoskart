import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the view
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var validationMessage: String = "" // To display validation messages

    var body: some View {
        VStack(alignment: .leading) {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)

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
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            validationMessage = "Please fill in all fields."
            return
        }

        if password != confirmPassword {
            validationMessage = "Passwords do not match."
            return
        }

        // Add more validation checks as needed (e.g., email format, password strength)

        // If all validations pass, simulate successful registration and dismiss view
        validationMessage = ""
        
        // Simulating successful registration process
        // In a real app, you would probably perform some asynchronous operation here
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Simulate async operation delay
            presentationMode.wrappedValue.dismiss() // Dismiss the view
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
