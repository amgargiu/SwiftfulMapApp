//
//  Location.swift
//  SwiftfulMapApp
//
//  Created by Antonio Gargiulo on 11/21/25.
//

import Foundation
import MapKit


struct LocationModel: Identifiable, Equatable {
    
    //properties (let constant easier)
    //let id = UUID().uuidString //issue here is that we could technically create two instances with SAME datat - Swift will give different IDs
    let name : String
    let cityName : String
    let coordinates : CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    //computed varibale for id for identifiable
    var id: String {
        //Key here - if we have two locations with same name and cityName - it should be recognized as same object
        name + cityName
        
    }
    
    
    // custom init to allow for 2 inits (one that we can ass in ID to update if needed)
    
    
    //update func
    
    
    //Equatable
    //if have 2 locations, If have one Location on left and one on right - what logic should we use to determine if 2 locations are the exact same location?
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.id == rhs.id // Here saying if the have the same ID (we defined as city + cityName) then they are the same location
    }
    
}

/*
 Location(
     name: "Colosseum",
     cityName: "Rome",
     coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
     description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
     imageNames: [
         "rome-colosseum-1",
         "rome-colosseum-2",
         "rome-colosseum-3",
     ],
     link: "https://en.wikipedia.org/wiki/Colosseum"),
 */
