import UIKit

class PersonalPageVC: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
   
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var sourseArray: [String] = []
    var idPerson: Int?

    let twoCastomGallerySegue = "toTwoCastomGallerySegue"
    let castomIdCollection = "CastomIdentifierCollection"
    let oneFoto = "fotoSegueOneFoto"

    var imageFullScreen: UIImageView!
    var oneImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(idPerson)
        avatarAndNameLayer()
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: castomIdCollection)
        galleryCollectionView.delegate = self

        let recognaser = UILongPressGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        view.addGestureRecognizer(recognaser)
    }

    @objc func onSwipe(_ recogniser : UILongPressGestureRecognizer) {

        recogniser.minimumPressDuration = 2

        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = UIColor.tintColor
            self.imageFullScreen.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }

    func avatarAndNameLayer() {
        avatarView.layer.cornerRadius = 60
        avatarView.layer.backgroundColor = UIColor.systemTeal.cgColor
        avatarImage.layer.cornerRadius = 60
        avatarImage.layer.borderColor = UIColor.systemGray4.cgColor
        avatarImage.layer.borderWidth = 5
    }

//    func configTabView() {
//        avatarImage.image = UIImage(named: sourseArray[0])
//        nameLabel.text = sourseArray[1]
////        if nameLabel.text?.count ?? 5 > 3 {
//        sourseArray.remove(at: 0)
//        sourseArray.remove(at: 0)
////        }
//    }

// MARK: Button first gallery
    @IBAction func galleryActionButton(_ sender: Any) {
        let newSourseArray = sourseArray
        performSegue(withIdentifier: "toCastomGallery", sender: newSourseArray)
    }

// MARK: Button secondary gallery
    @IBAction func gallerySecondaryActionButton(_ sender: Any) {
        let newSourse = sourseArray
        performSegue(withIdentifier: twoCastomGallerySegue, sender: newSourse)
    }
}
