import UIKit
import GoogleMaps

class StreetViewController: UIViewController {

    @IBOutlet weak var contentView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
    }
}
