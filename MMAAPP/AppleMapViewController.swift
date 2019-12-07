import UIKit
import MapKit

class AppleMapViewController: UIViewController {

    @IBOutlet weak var contentView: MKMapView!
    let locationManager = LocationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAccess()
        self.locationManager.startUpdate()
        self.locationManager.delegate = self
    }
}

extension AppleMapViewController: LocationManagerDelegate {
    
    func getCurrentLocation(currentLocation: CLLocation) {
        contentView.showsUserLocation = true
        contentView.setUserTrackingMode(.follow, animated: true)
    }
    
    func accessDenied() {
        contentView.showsUserLocation = false
    }
}
