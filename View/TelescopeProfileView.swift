import SwiftUI

struct TelescopeListView: View {
    let telescopes: [TelescopeModel]
    @State private var selectedIndex: Int? = 2
    var body: some View {
        NavigationView {
            VStack {
                List(telescopes) { telescope in
                    NavigationLink(destination: TelescopeDetailView(telescope: telescope)) {
                        Text(telescope.nameModel)
                    }
                }
                .navigationTitle("Telescopes")
                
                Spacer()
                
                Button(action: {
                    // Call the method to retrieve info and log it out
                    retrieveInfoAndLog(bearerToken: KeychainService.retrieveToken() ?? "")
                }) {
                    Text("Retrieve Info and Log")
                }
            }
        }
    }
    
    func retrieveInfoAndLog(bearerToken: String) {
        API.getUserTelescopes(bearerToken: bearerToken) { result in
            switch result {
            case .success(let telescopes):
                print("Telescopes retrieved successfully: \(telescopes)")
                // You can access the telescopes data here and perform any additional actions
            case .failure(let error):
                print("Error retrieving telescopes: \(error)")
            }
        }
    }
}

struct TelescopeDetailView: View {
    let telescope: TelescopeModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(telescope.nameModel)")
            Text("Manufacturer: \(telescope.manufacturer ?? "Unknown")") // Provide a default value for manufacturer
            Text("Type: \(telescope.type ?? "Unknown")")
            Text("Focal Length: \(telescope.focalLength ?? 0)")
            Text("Mount Type: \(telescope.mountType ?? "Unknown")")
            Text("Maximum Useful Magnification: \(telescope.maximumUsefulMagnification ?? 0)")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Telescope Details")
    }
}

struct TelescopeListView_Previews: PreviewProvider {
    static var previews: some View {
        TelescopeListView(telescopes: [])
    }
}
