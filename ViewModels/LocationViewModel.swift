//
//  LocationViewModel.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/21/25.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {

    
    //All loaded locations
    @Published var locations : [LocationModel]
    
    //Current location on the map
    @Published var currentMapLocation: LocationModel {
        didSet{
            updateMapRegion(location: currentMapLocation) // pass in current map location - func will set mapRegion to location's coordinates
        }
    }
    
    // Current region on Map - needed to bind to map component
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    //Show list of Locations in Menu header
    @Published var showLocationsMenu: Bool = false
    
    //show ocation detail via sheet
    @Published var sheetLocation: LocationModel? = nil
    
    
    
    init () {
        //get data and set to locations array
        let locations = LocationsDataService.locations
        self.locations = locations
        //setting the currentMapLocation to first upon init
        self.currentMapLocation = locations.first! // .first returns a single instance of type LocationModel in locations array
        //calling function where - setting up the value for the mapRegion (needed for Map call in View)
        self.updateMapRegion(location: locations.first!)
    }
    
    
    private func updateMapRegion(location: LocationModel) {
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, //remeber these are CLLocationCoordinate2D data type
                span: mapSpan)
        }
    }
    
    //for the location menu expanding
    func toggleLocationsMenu() {
        withAnimation(.easeInOut){
            showLocationsMenu.toggle()
        }
    }
    
    
    func showClickedLocation(location: LocationModel) { //he called this showNextLocation func
        withAnimation(.easeInOut){
            currentMapLocation = location
            // QUESTION: this refrences the location beng passed in - how does it now we passed in the location we clicked on tho?!
            // Answer: Because in the MenuView - we have forEach controlling the view for each row - the foreach references each Row as a "location in" when looping - we can use that "location" and pass it in as the location to run this function!
            showLocationsMenu = false
        }
    }
    
    
    func nextButtonPressed() {
        //current location is map location - so get index of that then + 1
        //unwrapping with guard since using .first
        guard let currentIndex = locations.firstIndex(where: { $0.id == currentMapLocation.id }) else {
            print("can't find current index in locations array - location non existant")
            return // return out of guards
        }
        
        // check if next index is valid item (when we go to next is there a value there)
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            //next index is not valid - restart from 0 or first location
            let firstLocation = locations.first!
            showClickedLocation(location: firstLocation)
            return
        }
        
        //Next index is valid - so
        
        let nextLocation = locations[nextIndex]
        showClickedLocation(location: nextLocation)
        
    }
    
}
