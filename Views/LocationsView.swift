//
//  LocationsView.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/21/25.
//

import SwiftUI
import MapKit



struct LocationsView: View {
    
    @EnvironmentObject private var vm : LocationsViewModel
    
    var body: some View {
        
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing:  0) {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
        // identfiable being "looped" or iterated is the optional location binded
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}


#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    
    
    private var header : some View { //type View
        
        VStack {
            Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showLocationsMenu ? 180 : 0))
                        
                }
            
            if vm.showLocationsMenu {
                LocationsMenuView()
            }
            
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 15)
        .onTapGesture {
            vm.toggleLocationsMenu()
        }
        
    }
    
    
    private var mapLayer: some View {
        
                
        
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations) { location in // "location in"
            MapAnnotation(coordinate: location.coordinates) {
                // sets / puts annotation for eacch item in collection
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7) //current location
                    .shadow(color: .black.opacity(0.5), radius: 10)
                // on tap we run func to set current location = location iterated (from annoatationItems)
                    .onTapGesture {
                        vm.showClickedLocation(location: location)
                        
                    }
            }
        }
    }
        
    
    
    private var locationPreviewStack: some View {
        
        ZStack {
            ForEach(vm.locations) { location in // for every location in the locations collection... now we can use that location (in white) in the code
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
                
            }
        }
    }
}
