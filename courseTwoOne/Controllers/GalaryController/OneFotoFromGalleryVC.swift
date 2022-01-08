import UIKit

class OneFotoFromGalleryVC: UIViewController {

    @IBOutlet weak var imageFoto: UIImageView!
    @IBOutlet weak var viewOneFoto: UIView!
    let gradientLayer = CAGradientLayer()

    var imageFotoInController: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        imageFoto.layer.shadowColor = UIColor.black.cgColor
        imageFoto.layer.shadowOpacity = 0.7
        imageFoto.layer.shadowRadius = 40

        viewControllerFull()
    }

    func viewControllerFull () {
        let arrayColor = [UIColor.systemMint,
                          UIColor.systemOrange,
                          UIColor.systemIndigo,
                          UIColor.systemCyan,
                          UIColor.systemFill]

        viewOneFoto.backgroundColor = arrayColor[Int.random(in: 0...4)]
        imageFoto.image = UIImage(named: imageFotoInController)
    }
}
