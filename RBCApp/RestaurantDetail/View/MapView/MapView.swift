//
//  MapView.swift
//  RBCApp
//
//  Created by Smitesh Patel on 2019-07-29.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import MapKit

final class MapView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    static func createMapView(lat: Double, long: Double, name:String) -> MapView {
        let mapView: MapView = MapView.loadFromNib()
        mapView.configureView(lat: lat, long: long, name: name)
        return mapView
    }

    private func configureView(lat: Double, long:Double,name:String) {
        let london = MKPointAnnotation()
        london.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(london)
        focusMapView(lat: lat, long: long, name: name)
    }
    func focusMapView(lat: Double, long:Double, name:String) {
        let mapCenter = CLLocationCoordinate2DMake(lat, long)
        let placemark = MKPlacemark(coordinate: mapCenter, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = name
      //  mapItem.openInMaps(launchOptions: options)
    }
   
   
}
