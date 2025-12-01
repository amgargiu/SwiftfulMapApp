//
//  LocationDetailView.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/25/25.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    let location: LocationModel
    
    var body: some View {
        ScrollView {
            VStack{
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                
                VStack(alignment: .leading, spacing: 16){
                    
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer

                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
        

    }
}

#Preview {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
}



//---------------------------------------


extension LocationDetailView {
    
    
    private var imageSection: some View {
        
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width
                    )
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            // this url is optional - so unwrap - don't want to pass in option into destination for link
            if let url = URL(string: location.link) {
                Link("Read more on Wiki", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            
            
        }
    }
    
    
    private var mapLayer: some View {
        
        
        //region constant - doesnt need to change
        //remember we are passing in asingle location when we init this view
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            // we need a collection here - so give an array with just one item since that's all we want in detail view
            annotationItems: [location]) { location in
            // Below is the annotation contact param
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(color: .black.opacity(0.5), radius: 10)
            }
        }
            .frame(height: 300)
            .cornerRadius(16)
            .allowsHitTesting(false)
    }
    
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
    
    
}
