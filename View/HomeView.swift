// NewView.swift

import SwiftUI

struct NewView: View {
    
    
    @State private var selectedIndex: Int? = nil // Declare selectedIndex as an optional State variable

    // Example data for celestial events. You might fetch this from an API in a real app.
    let celestialEvents = ["Meteor Shower Tonight", "Jupiter at Opposition", "Full Moon"]

    var body: some View {
        NavigationView {
            VStack {
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

                BottomBar(selectedIndex: $selectedIndex) // Pass selectedIndex to BottomBar
            }
        }
    }
}



struct AstronomyPictureOfTheDay: View {
    @State private var dailyPhoto: DailyPhotoResponse?
    @State private var isLoading = false
    @State private var shouldFetchPhoto = true // Add a flag
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Astronomy Picture of the Day")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 4)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.vertical, 8)
            } else if let dailyPhoto = dailyPhoto {
                if let imageUrlString = dailyPhoto.url, let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.vertical, 8)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.vertical, 8)
                    }
                }
            } else {
                Text("Failed to load image")
                    .foregroundColor(.red)
                    .padding(.vertical, 8)
            }
        }
        .onAppear {
            if shouldFetchPhoto { // Check the flag before fetching
                print("Fetching daily photo...")
                fetchDailyPhoto(bearerToken: KeychainService.retrieveToken() ?? "")
                shouldFetchPhoto = false // Set the flag to false after fetching
            }
        }
    }
    
    private func fetchDailyPhoto(bearerToken: String) {
        isLoading = true
        API.getDailyPhoto(bearerToken: bearerToken) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dailyPhoto):
                    print("Success fetching daily photo")
                    self.dailyPhoto = dailyPhoto
                case .failure(let error):
                    print("Error fetching daily photo: \(error)")
                }
                isLoading = false
            }
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
