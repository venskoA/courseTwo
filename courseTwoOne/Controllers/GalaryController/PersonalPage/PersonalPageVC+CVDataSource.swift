import UIKit

// MARK: Filleng CollectionView
extension PersonalPageVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourseArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castomIdCollection, for: indexPath) as? GalleryCollectionViewCell else {return UICollectionViewCell()}

        cell.configures(image: UIImage(named: sourseArray[indexPath.item]), index: indexPath.item)

        return cell
    }
}
