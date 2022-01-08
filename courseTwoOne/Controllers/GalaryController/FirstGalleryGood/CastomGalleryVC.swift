import UIKit

class CastomGalleryVC: UIViewController {

    @IBOutlet weak var GalleryGoodHorisontalSvrol: GalleryGoodHorisotalScrol!
    var allImage: [String] = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        GalleryGoodHorisontalSvrol.setImage(image: allImage)
    }
}
