import SwiftUI

struct CommunityView: View {
    @State private var selectedIndex: Int? = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Community View Content")
                    .navigationTitle("Community")
                    EmptyView()
                }
            }
        }
    
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
