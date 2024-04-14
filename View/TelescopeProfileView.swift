import SwiftUI

// Mock data for telescopes
let mockTelescopes: [TelescopeModel] = [
    TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 1", manufacturer: "Manufacturer A", type: "Type A", aperture: 80, focalLength: 900, focalRatio: 5.6, mountType: "Alt-Azimuth", maximumUsefulMagnification: 200, limitingStellarMagnitude: 11.2),
    TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 2", manufacturer: "Manufacturer B", type: "Type B", aperture: 114, focalLength: 1000, focalRatio: 8.8, mountType: "Equatorial", maximumUsefulMagnification: 250, limitingStellarMagnitude: 12.5),
    TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 3", manufacturer: "Manufacturer C", type: "Type C", aperture: 150, focalLength: 1200, focalRatio: 8, mountType: "Dobsonian", maximumUsefulMagnification: 300, limitingStellarMagnitude: 13.5)
]

import SwiftUI

struct TelescopeListView: View {
    let telescopes: [TelescopeModel]
    
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
