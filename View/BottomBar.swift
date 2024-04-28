import SwiftUI

struct BottomBar: View {
    @Binding var selectedIndex: Int?
//    let mockTelescopes: [TelescopeModel] = [
//        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 1", manufacturer: "Manufacturer A", type: "Type A", aperture: 80, focalLength: 900, focalRatio: 5.6, mountType: "Alt-Azimuth", maximumUsefulMagnification: 200, limitingStellarMagnitude: 11.2),
//        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 2", manufacturer: "Manufacturer B", type: "Type B", aperture: 114, focalLength: 1000, focalRatio: 8.8, mountType: "Equatorial", maximumUsefulMagnification: 250, limitingStellarMagnitude: 12.5),
//        TelescopeModel(id: UUID(), userId: 1, nameModel: "Telescope 3", manufacturer: "Manufacturer C", type: "Type C", aperture: 150, focalLength: 1200, focalRatio: 8, mountType: "Dobsonian", maximumUsefulMagnification: 300, limitingStellarMagnitude: 13.5)
//    ]
    
    let user = UserModel(id: 1,
                         username: "example_user",
                         firstname: "John",
                         lastname: "Doe",
                         email: "john.doe@example.com",
                         password: "password123")
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                BottomBarButton(imageName: "house", index: 0, selectedIndex: $selectedIndex) {
                    CommunityView()
                }
                Spacer()
                BottomBarButton(imageName: "heart", index: 1, selectedIndex: $selectedIndex) {
                    TelescopeListView()
                }
                Spacer()
                BottomBarButton(imageName: "person", index: 2, selectedIndex: $selectedIndex) {
                    UserProfileView(user: user)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(color: .gray, radius: 2, x: 0, y: -1)
        }
    }
}

struct BottomBarButton<Destination: View>: View {
    let imageName: String
    let index: Int
    @Binding var selectedIndex: Int?
    let destination: Destination
    
    init(imageName: String, index: Int, selectedIndex: Binding<Int?>, @ViewBuilder destination: () -> Destination) {
        self.imageName = imageName
        self.index = index
        self._selectedIndex = selectedIndex
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination, tag: index, selection: $selectedIndex) {
            Button(action: {
                selectedIndex = index
                print("Button tapped, selectedIndex: \(selectedIndex ?? -1)")
            }) {
                Image(systemName: imageName)
                    .foregroundColor(selectedIndex == index ? .blue : .gray)
            }
        }
    }
}
