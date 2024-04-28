//
//  AddTelescopeProfileView.swift
//  Kosmoskart
//
//  Created by Matt R on 4/28/24.
//

import SwiftUI

struct AddTelescopeProfileView: View {
    @Environment(\.presentationMode) var presentationMode // Used to dismiss the view
    @State private var nameModel: String = ""
    @State private var manufacturer: String = ""
    @State private var type: String = ""
    @State private var aperture: String = ""
    @State private var focalLength: String = ""
    @State private var focalRatio: String = ""
    @State private var mountType: String = ""
    @State private var maxMagnification: String = "600"
    @State private var stellarMagnitude: String = "13.50"
    @State private var validationMessage: String = "" // To display validation messages

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Name Model", text: $nameModel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)

            TextField("Manufacturer", text: $manufacturer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Type", text: $type)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Aperture", text: $aperture)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Focal Length", text: $focalLength)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Focal Ratio", text: $focalRatio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)

            TextField("Mount Type", text: $mountType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)





            if !validationMessage.isEmpty {
                Text(validationMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }

            Button("Add Telescope Profile") {
                addTelescopeProfile()
            }
            .buttonStyle(DarkRedButtonStyle())
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }

    private func addTelescopeProfile() {
        // Basic validation
//        if nameModel.isEmpty || manufacturer.isEmpty || type.isEmpty || aperture.isEmpty || focalLength.isEmpty || focalRatio.isEmpty || mountType.isEmpty || maxMagnification.isEmpty || stellarMagnitude.isEmpty {
//            validationMessage = "Please fill in all fields."
//            return
//        }

//         Convert numeric inputs to appropriate types
        // Initialize to nil to check each one individually
        var apertureDecimal: Decimal?
        var focalLengthInt: Int?
        var focalRatioDecimal: Decimal?
        var maxMagnificationInt: Int?
        var stellarMagnitudeDecimal: Decimal?
        
        
        
        
        // Check each field and update the validation message if any field is incorrect
        if Decimal(string: aperture) == nil {
            validationMessage = "Invalid numeric value for Aperture."
        } else {
            apertureDecimal = Decimal(string: aperture)
        }

        if Int(focalLength) == nil {
            validationMessage = "Invalid numeric value for Focal Length."
        } else {
            focalLengthInt = Int(focalLength)
        }

        if Decimal(string: focalRatio) == nil {
            validationMessage = "Invalid numeric value for Focal Ratio."
        } else {
            focalRatioDecimal = Decimal(string: focalRatio)
        }

        if Int(maxMagnification) == nil {
            validationMessage = "Invalid numeric value for Maximum Magnification."
        } else {
            maxMagnificationInt = Int(maxMagnification)
        }

        if Decimal(string: stellarMagnitude) == nil {
            validationMessage = "Invalid numeric value for Limiting Stellar Magnitude."
        } else {
            stellarMagnitudeDecimal = Decimal(string: stellarMagnitude)
        }

        // Only proceed if all conversions are successful
        guard let aperture = apertureDecimal,
              let focalLength = focalLengthInt,
              let focalRatio = focalRatioDecimal,
              let maxMagnification = maxMagnificationInt,
              let stellarMagnitude = stellarMagnitudeDecimal else {
            return
        }

        // Create a TelescopeModel object
        let telescope = TelescopeRequest(userId: 1, nameModel: nameModel, manufacturer: manufacturer, type: type, aperture: aperture, focalLength: focalLength, focalRatio: focalRatio, mountType: mountType, maximumUsefulMagnification: maxMagnification, limitingStellarMagnitude: stellarMagnitude)
//
//        let telescope = TelescopeRequest( userId: 1, nameModel: "mattscustom", manufacturer: "matt", type: "dobsonian", aperture: 300.00, focalLength: 1500, focalRatio: 5.00, mountType: "german equitorial", maximumUsefulMagnification: 600, limitingStellarMagnitude: 13.50)
        
        // Perform further actions with the telescope data, such as sending it to the server

        API.setUserTelescopes(telescope: telescope, bearerToken: KeychainService.retrieveToken() ?? "") { result in
            switch result {
            case .success(let response):
                // Handle success, possibly updating UI or showing a success message
                DispatchQueue.main.async {
                    validationMessage = "Telescope profile added successfully."
                    presentationMode.wrappedValue.dismiss()
                }
            case .failure(let error):
                // Handle error, possibly updating UI to show error message
                DispatchQueue.main.async {
                    validationMessage = "Failed to add telescope profile: \(error.localizedDescription)"
                }
            }
        }
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddTelescopeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddTelescopeProfileView()
    }
}
