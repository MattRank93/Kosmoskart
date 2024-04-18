

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
