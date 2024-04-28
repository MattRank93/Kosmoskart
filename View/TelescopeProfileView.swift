import SwiftUI

struct TelescopeListView: View {
    @ObservedObject var viewModel = TelescopeListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.telescopes) { telescope in
                    NavigationLink(destination: TelescopeDetailView(telescope: telescope)) {
                        Text(telescope.nameModel)
                    }
                }
                .navigationTitle("Telescopes")
                .onAppear {
                    // Call the method to retrieve info and log it out
                    viewModel.fetchTelescopeData(bearerToken: KeychainService.retrieveToken() ?? "")
                }

                Spacer()
                
                NavigationLink(destination: AddTelescopeProfileView()) {
                    Text("Add Telescope Profile")
                }
            }
        }
    }
}

struct TelescopeDetailView: View {
    let telescope: TelescopeProfile

    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(telescope.nameModel)")
            Text("Manufacturer: \(telescope.manufacturer ?? "Unknown")")
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

class TelescopeListViewModel: ObservableObject {
    @Published var telescopes: [TelescopeProfile] = []
    var api = API() // Assuming you have an API class for network requests

    func fetchTelescopeData(bearerToken: String) {
        api.getUserTelescopes(bearerToken: bearerToken) { result in
            switch result {
            case .success(let telescopes):
                DispatchQueue.main.async {
                    self.telescopes = telescopes
                }
            case .failure(let error):
                print("Error fetching telescopes: \(error)")
            }
        }
    }
}

struct TelescopeListView_Previews: PreviewProvider {
    static var previews: some View {
        TelescopeListView()
    }
}
