import CoreLocation

protocol LocationManagerDelegate {
    func getCurrentLocation(currentLocation: CLLocation)
    func accessDenied()
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    private var locationManager = CLLocationManager()
    var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.startUpdate()
    }
    
    func startUpdate() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdate() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func requestAccess() {
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        self.delegate?.getCurrentLocation(currentLocation: lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse: break
        case .denied:
            self.locationManager.stopUpdatingLocation()
            self.delegate?.accessDenied()
        default: break
        }
    }
}
