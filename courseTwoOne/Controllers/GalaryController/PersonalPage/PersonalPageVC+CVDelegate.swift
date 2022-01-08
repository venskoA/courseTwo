import UIKit

extension PersonalPageVC: UICollectionViewDelegate {

//MARK: Отправляем на контроллер с одним фото
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == oneFoto,
        let fotoFriends = sender as? String,
           let distinator = segue.destination as? OneFotoFromGalleryVC {
            distinator.imageFotoInController = fotoFriends
        }

        if segue.identifier == "toCastomGallery",
           let newSourseArray = sender as? [String],
            let destinator = segue.destination as? CastomGalleryVC {
            destinator.allImage = newSourseArray
        }

        if segue.identifier == twoCastomGallerySegue,
           let newSourse = sender as? [String],
            let destinator = segue.destination as? SecondaryGalleryVC {
            destinator.photoImage = newSourse
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fotoFriends = String(sourseArray[indexPath.item])
        performSegue(withIdentifier: oneFoto, sender: fotoFriends)
    }

//    MARK: Config view
//    func setImageOne() {
//        imageFullScreen = oneImage
//        view.addSubview(imageFullScreen)
//
//        imageFullScreen.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            imageFullScreen.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            imageFullScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            imageFullScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            imageFullScreen.heightAnchor.constraint(equalTo: imageFullScreen.widthAnchor, multiplier: 1)
//        ])
//
//        let scale = CGAffineTransform(scaleX: 0, y: 0)
//        imageFullScreen.transform = scale
//    }

// MARK: Tap on foto
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let image = UIImage(named: String(sourseArray[indexPath.item]))
//        oneImage.image = image

//        setImageOne()
//        UIView.animate(withDuration: 1) {
//            self.view.backgroundColor = UIColor.black
//            self.imageFullScreen.transform = .identity
//        }

//    }
}
