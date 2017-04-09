//
//  MapViewController.swift
//  Yelp
//
//  Created by Jessica Thrasher on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    var businesses: [Business]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set the region to display, this also sets a correct zoom level
        
        // set starting center location in San Francisco
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        
        addBusinesses()
    }

    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func addBusinesses() {
        
        if let businesses = businesses {
            
            for business in businesses {
                
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(business.address!) { (placemarks, error) in
                    if let placemarks = placemarks {
                        if placemarks.count != 0 {
                            let coordinate = placemarks.first!.location!
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate.coordinate
                            annotation.title = business.name
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
