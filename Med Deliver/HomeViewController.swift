//
//  HomeViewController.swift
//  Med Deliver
//
//  Created by Omar Elhamzawi on 17/10/2018.
//  Copyright © 2019 Omar Elhamzawi. All rights reserved.

/* References:
 
    The Swift Guy, YouTube.
    Ryan Noonan, YouTube.
 */
//


import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    
    //create IBOULET for MKMAPView here!
    
    @IBOutlet weak var myMapView: MKMapView!
    
        let manager = CLLocationManager()
    
    
    // create function every single time our user changes their location.
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
            
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let _:MKCoordinateRegion = MKCoordinateRegion.init(center: myLocation, span: span)
            
//        myMapView.setRegion(region, animated: true)
        
        self.myMapView.showsUserLocation = true
        
    }
    
    
    @IBAction func searchButton(_ sender: Any)
    {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion.init(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest           //desired accuracy is the best accuracy
        manager.requestWhenInUseAuthorization()                     // we only need the user's location when they are using MedDeliver
        manager.startUpdatingLocation()                             // call a function everytime the location is updated
        
        // Do any additional setup after loading the view, typically from a nib.
        
        createAnnotations(locations: annotationLocations)  // call annotation function
        
        // Do any additional setup after loading the view.
        
        // annotate location(s) to plot onto our map! + add titles and subtitles here.
        
        //title = name of the pharmacy
        //subtitle = opening times of the pharmacy
        
        
    }
    let annotationLocations = [
        
        ["title": "University Medical Centre", "subtitle": "Opening times: 07:00 - 18:30", "latitude": 51.296351, "longitude":1.062152],
        ["title": "Boots Pharmacy", "subtitle": "Opening times: 08:00 - 18:00", "latitude":  51.274631, "longitude":1.084672],
        ["title": "Superdrug Pharmacy", "subtitle": "Opening times: 08:00 - 18:30", "latitude":  51.278395, "longitude":1.082779],
        ["title": "Lloyds Pharmacy in Sainsburys", "subtitle": "Opening times: 08:00 - 21:00", "latitude":  51.284997, "longitude":1.085479],
        ["title": "Morrisons Pharmacy", "subtitle": "Opening times: 09:00 - 20:00", "latitude":  51.273057, "longitude":1.063127],
        ["title": "Asda Pharmacy", "subtitle": "Opening times: 07:00 - 12:00", "latitude":  51.291392, "longitude":1.096899]
    ]
    
    
    
    // create annotation
    
    
    
    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {                             //loop over our custom locations
            let annotations = MKPointAnnotation()                   // make annotations a variable
            annotations.title = location["title"] as? String        // create a title, use location from the loop. access the location fetch the title
            annotations.subtitle = location["subtitle"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees,
                                                            longitude: location["longitude"] as! CLLocationDegrees) //NOTE: you can also pass this as double
            
            myMapView.addAnnotation(annotations)
            
        }
    }
    
    
}






