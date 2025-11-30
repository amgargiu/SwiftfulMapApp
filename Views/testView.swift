//
//  testView.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/26/25.
//
//

import SwiftUI
import MapKit

struct MapInScrollViewExample: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack {
                    Text("Here is a long paragraph of text explaining something about the location or anything else you want to display. The user can scroll down to see the map below.")
                        .font(.body)
                        .padding()
                    
                    Map(coordinateRegion: $region)
                        .frame(width: 300, height: 300)   // Square size
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    
                }
                
                // Square map
                
                Spacer()
            }
        }
    }
}



#Preview {
    MapInScrollViewExample()
}
