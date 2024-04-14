import SwiftUI

struct BottomBar: View {
    @Binding var selectedIndex: Int?
    let mockTelescopes: [TelescopeModel] = [
        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 1", manufacturer: "Manufacturer A", type: "Type A", aperture: 80, focalLength: 900, focalRatio: 5.6, mountType: "Alt-Azimuth", maximumUsefulMagnification: 200, limitingStellarMagnitude: 11.2),
        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 2", manufacturer: "Manufacturer B", type: "Type B", aperture: 114, focalLength: 1000, focalRatio: 8.8, mountType: "Equatorial", maximumUsefulMagnification: 250, limitingStellarMagnitude: 12.5),
        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 3", manufacturer: "Manufacturer C", type: "Type C", aperture: 150, focalLength: 1200, focalRatio: 8, mountType: "Dobsonian", maximumUsefulMagnification: 300, limitingStellarMagnitude: 13.5)
    ]
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: NewView(),
                tag: 0,
                selection: $selectedIndex
            ) {
                Image(systemName: "house")
            }
            .foregroundColor(selectedIndex == 0 ? .blue : .gray)
            .onTapGesture {
                print("NavigationLink to NewView tapped")
            }
            
            Spacer()
            
            NavigationLink(
                destination: TelescopeListView(telescopes: mockTelescopes),
                tag: 1,
                selection: $selectedIndex
            ) {
                Image(systemName: "heart")
            }
            .foregroundColor(selectedIndex == 1 ? .blue : .gray)
            .onTapGesture {
                print("NavigationLink to TelescopeListView tapped")
            }
            
            Spacer()
            
            let user = UserModel(id: 1, username: "example", firstname: "John", lastname: "Doe", email: "john.doe@example.com", password: "password")

            NavigationLink(
                destination: UserProfileView(user: user, selectedIndex: $selectedIndex),
                tag: 2,
                selection: $selectedIndex
            ) {
                Image(systemName: "person")
            }
            .foregroundColor(selectedIndex == 2 ? .blue : .gray)
            .onTapGesture {
                print("NavigationLink to UserProfileView tapped")
            }
        }
        .padding()
        .background(Color.white)
        .shadow(color: .gray, radius: 2, x: 0, y: -1)
    }
}
