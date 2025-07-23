//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Sheree Morrison on 16/7/2025.
//

import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    //All locations
    @Published var locations: [Location]
    
    //Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Initialise with blank region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list of locations
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    //Change from blank region to the current location of whatever the location is
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Couldn't find current index in locations array")
            return
        }
        
        //Check there is an item at the next index
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //If not, restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        //If there is, show next location
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
