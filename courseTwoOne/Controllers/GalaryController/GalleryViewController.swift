
import UIKit

class GalleryViewController: UIViewController {

    var sourseArray = ["23", "22"]
    let castomIdCollection = "CastomIdentifierCollection"

    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: castomIdCollection)
    }

}

extension GalleryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourseArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castomIdCollection, for: indexPath) as? GalleryCollectionViewCell else {return UICollectionViewCell()}

        cell.configures(image: UIImage(named: String(sourseArray[indexPath.item])), index: indexPath.item)

        return cell
    }


}
