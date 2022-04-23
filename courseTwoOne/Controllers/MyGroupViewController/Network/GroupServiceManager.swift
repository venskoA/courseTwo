import Foundation
import UIKit
import RealmSwift

class GroupServiceManager {
    private var service = GroupApiService()
    private var imageServise = ImageLoader()

        func loadGroup(comletion: @escaping([GroupItems]) -> Void) {
            service.loadGroup { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let group):
                let section = group.response.items
                self.saveFriendRealm(value: group.response.items)
                comletion(section)
            case .failure(_):
                return
            }
        }
    }

    func saveFriendRealm(value: [GroupItems]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(value)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func loadImage(url: String, comletion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        imageServise.loadImage(url: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                comletion(image)
            case .failure(let error):
                debugPrint("Error \(error.localizedDescription)")
            }
        }
    }
}
