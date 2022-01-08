//
//  GalleryNewVC.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 27.11.21.
//

import UIKit

class FriendsGalleryVC: UIViewController {

   
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var sourseArray: [String] = []
    let castomIdCollection = "CastomIdentifierCollection"
    let oneFoto = "fotoSegueOneFoto"

    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: castomIdCollection)
        galleryCollectionView.delegate = self
    }

}

extension GalleryNewVC: UICollectionViewDataSource {

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

extension GalleryNewVC: UICollectionViewDelegate {
    
// Отправляем на контроллер с одним фото

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == oneFoto,
        let fotoFriends = sender as? String,
           let distinator = segue.destination as? OneFotoFromGalleryVC {
            distinator.imageFotoInController = fotoFriends
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fotoFriends = String(sourseArray[indexPath.item])
        performSegue(withIdentifier: oneFoto, sender: fotoFriends)
    }
}

extension GalleryNewVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = collectionView.bounds.width / 2 - 10

        return CGSize(width: cellWidth, height: cellWidth)
    }


}
