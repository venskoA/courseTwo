import UIKit

extension PersonalPageVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.height - 15

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
