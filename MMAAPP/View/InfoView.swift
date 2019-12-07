import UIKit

class InfoView: UIView {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "InfoView",
                     bundle: nil).instantiate(withOwner: nil,
                                              options: nil)[0] as! UIView
    }
    
    var detail: String = "" {
        didSet {
            reloadDetail()
        }
    }
    func reloadDetail() {
        self.detailLabel.text = detail
    }
}
