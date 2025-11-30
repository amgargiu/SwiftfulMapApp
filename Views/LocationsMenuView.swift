//
//  LocationsMenuView.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/22/25.
//

import SwiftUI



struct LocationsMenuView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in //locations is the array of them all - each location is of type LocationModel
                    listRowView(location: location)
                        .onTapGesture {
                            vm.showClickedLocation(location: location)
                        }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
        .listRowSpacing(-5)
    }
}

#Preview {
    LocationsMenuView()
        .environmentObject(LocationsViewModel())
}



extension LocationsMenuView {
    
    // like an extracted subview - but made it a func because it required use of the viewmodel? I am not sure...
    //Technically we made this it's own seperate view and file in To-DO app
    private func listRowView(location: LocationModel) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                //IF we can get that image name - place it on screen
                //remember .first creates optional
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack (alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .onTapGesture {
//            vm.showClickedLocation(location: location)
//        }
        
        
    }
}
