import SwiftUI

struct NewView: View {
    // Example data for celestial events. You might fetch this from an API in a real app.
    let celestialEvents = ["Meteor Shower Tonight", "Jupiter at Opposition", "Full Moon"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome to KosmosKart!")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    // Feature: Astronomy Picture of the Day
                    AstronomyPictureOfTheDay()

                    // Feature: Celestial Events
                    VStack(alignment: .leading) {
                        Text("Celestial Events")
                            .font(.title2)
                            .fontWeight(.semibold)
                        ForEach(celestialEvents, id: \.self) { event in
                            Text(event)
                                .padding(.vertical, 4)
                        }
                    }

                    // Feature: Navigation to other sections of the app
                    NavigationMenu()

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("KosmosKart Home")
        }
    }
}

// Example subview for displaying an astronomy picture of the day
struct AstronomyPictureOfTheDay: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Astronomy Picture of the Day")
                .font(.title2)
                .fontWeight(.semibold)
            // Placeholder image, replace with actual image fetching mechanism
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.vertical, 8)
        }
    }
}

// Example subview for navigation menu
struct NavigationMenu: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Explore")
                .font(.title2)
                .fontWeight(.semibold)
            // Example navigation links, replace with actual destinations
            Text("Star Maps")
            Text("Constellations")
            Text("Deep Sky Objects")
        }
    }
}

// Preview provider for SwiftUI Canvas
struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}
