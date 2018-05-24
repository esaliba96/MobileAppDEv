//
//  ViewController.swift
//  lab7
//
//  Created by Elie Saliba on 5/10/18.
//  Copyright © 2018 Elie Saliba. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import GeoFire

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let apiSchools = "https://code.org/schools.json"
    var schools : SchoolsService?
    var schoolRef : DatabaseReference?
    var geoFire : GeoFire?
    var regionQuery : GFRegionQuery?
    let locationManager = CLLocationManager()
    let cscBuilding = CLLocationCoordinate2D(latitude: 35.2828, longitude: -120.66)
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Database.database().isPersistenceEnabled = true

        schoolRef = Database.database().reference(withPath: "schools436")
        geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))

        let span = MKCoordinateSpan(latitudeDelta: 0.52, longitudeDelta: 0.52)
        let newRegion = MKCoordinateRegion(center: cscBuilding, span: span)
        map.setRegion(newRegion, animated: true)

        
        // synchronize data locally
        schoolRef?.keepSynced(true)
        
        //oneTimeInit()
    }
    
    func oneTimeInit() {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: apiSchools)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let schoolsTemp = try decoder.decode(SchoolsService.self, from: data)
                    
                    self.schools = schoolsTemp
                    
                    DispatchQueue.main.async {
                        self.removeUnecessary();
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        super.viewDidLoad()
    }

    func removeUnecessary() {
        var newName : String
        for (_, school) in (schools?.schools)!.enumerated().reversed() {
            if let temp = school.zip {
                if (temp.hasPrefix("93")) {
                    if (school.name?.contains("."))! {
                        newName = (school.name?.replacingOccurrences(of: ".", with: " "))!
                    } else {
                        newName = school.name!
                    }
                    let newSchool = School(school: school)
                    let newRef = schoolRef?.child(newName)
                    newRef?.setValue(newSchool.toAnyObject())
                    self.geoFire?.setLocation(CLLocation(latitude:school.latitude!,longitude:school.longitude!), forKey: newName)
                }
            }
        }
    }
    
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        
        updateRegionQuery()
    }
    
    func updateRegionQuery() {
        if let oldQuery = regionQuery {
            oldQuery.removeAllObservers()
        }
        
        regionQuery = geoFire?.query(with: map.region)
        
        regionQuery?.observe(.keyEntered, with: { (key, location) in
            self.schoolRef?.queryOrderedByKey().queryEqual(toValue: key).observe(.value, with: { snapshot in
                
                let newSchool = School(key:key,snapshot:snapshot)
                self.addSchool(newSchool)
            })
        })
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setRegion(MKCoordinateRegionMake((mapView.userLocation.location?.coordinate)!, MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        
    }
    
    func addSchool(_ school : School) {
        DispatchQueue.main.async {
            self.map.addAnnotation(school)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is School {
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = .red
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            
            return annotationView
        
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "detail", sender: view.annotation!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // add conditional
        if segue.identifier == "detail" {
            if let selectedLocale = sender as? School {
                let destVC = segue.destination as! DetailedView
                destVC.school = selectedLocale
              }
        }
    }
}

