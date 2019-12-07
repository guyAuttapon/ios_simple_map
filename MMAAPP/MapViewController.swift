import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var contentView: GMSMapView!
    private var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var markers: [GMSMarker]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        contentView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86,
                                              longitude: 151.20,
                                              zoom: 6.0)
        contentView.camera = camera
    }
    @IBAction func touchBangkokButton(_ sender: Any) {
//        contentView.camera = GMSCameraPosition.camera(withLatitude: 13.799234,
//                                                      longitude: 100.550332,
//                                                      zoom: 14.0)
        
        self.pinPoint()
        
//        if let url = URL(string: "https://maps.google.com/?q=@13.799234,100.550332") {
//            UIApplication.shared.open(url, options: [:])
//        }
    }
    
    func pinPoint() {
        self.markers = [GMSMarker]()
        for location in SampleLocation.get() {
            self.createMarker(location.title,
                              coordinate: CLLocation(latitude: location.lat,
                                                     longitude: location.long))
        }
        
        if let firstLocaiton = markers?.first {
            let camera = GMSCameraPosition.camera(withLatitude:
                firstLocaiton.position.latitude, longitude:
                firstLocaiton.position.longitude, zoom: 12)
            self.contentView.animate(to: camera)
        }
    }
    
    func createMarker(_ title: String, coordinate: CLLocation) {
        let marker = GMSMarker(position: coordinate.coordinate)
        marker.title = title
        marker.icon = GMSMarker.markerImage(with: .green)
        marker.map = contentView
        markers?.append(marker)
    }
    
    @IBAction func touchTypeButton(_ sender: Any) {
        if contentView.mapType == .satellite {
            contentView.mapType = .normal
        } else {
            contentView.mapType = .satellite
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else {
            return
        }
        currentLocation = lastLocation
        let camera = GMSCameraPosition.camera(withLatitude:
            lastLocation.coordinate.latitude, longitude:
            lastLocation.coordinate.longitude,zoom: 14)
        self.contentView.animate(to: camera)
        self.pinCurrentLocation()
    }
    
    func pinCurrentLocation() {
        guard let currentCoordianate = currentLocation?.coordinate else {
            return
        }
        contentView.clear()
        let marker = GMSMarker(position: currentCoordianate)
        marker.title = "Current Location"
        marker.map = contentView
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            self.contentView.isMyLocationEnabled = true
        case .denied:
            self.locationManager.stopUpdatingLocation()
        default: break
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let infoView = InfoView.instanceFromNib() as? InfoView {
            infoView.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
            infoView.detail = marker.title ?? ""
            return infoView
        } else {
            return nil
        }
    }
}
