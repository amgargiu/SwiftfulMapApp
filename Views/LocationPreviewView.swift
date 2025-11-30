//
//  LocationPreviewView.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/23/25.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: LocationModel
    
    var body: some View {
        
        
        HStack (alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8){
                learnMoreButton
                NextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
                .clipped() // clips image to frame (but removes corner radius)
        )
        .cornerRadius(10)

    }
}

#Preview {
    ZStack {
        
        //BG layer
        Color.blue.ignoresSafeArea()
        
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding() // added to preview to see how it will look like I guess?
            .environmentObject(LocationsViewModel())
    }
}





extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack{
            // if let is unwraping the .firt call
            //side not remeber we have multple image names for dingle location stored in an array
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
//                        .clipShape(Circle())
//                        .overlay(Capsule().stroke(Color.white, lineWidth: 5))
            }
        }
        .padding(5)
        .background(.white)
        .cornerRadius(10)
    }
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            //setting equal to location we passed into this view upon init
            vm.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    private var NextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.bordered)
        
    }
    
    
}
