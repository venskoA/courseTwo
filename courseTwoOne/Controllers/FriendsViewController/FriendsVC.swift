import UIKit
import RealmSwift

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableFriends: UITableView!
    @IBOutlet weak var friendsSearBar: UISearchBar!

    var sourseArray = [FriendItemsForCell]()
    var friendsArray = [FriendItemsForCell]()
    var friendsService = FriendsServiceManager()

    let customCellReuseIndetificator = "CustomCellReuseIndetificator"
    let allTableViewCell = "AllTableViewCell"
    let heightTableViev: CGFloat = 50
    let toGallery = "toGallery"

// MARK: Closure finish animation SearchBar
    func searchBarAnimateClosure () -> () -> Void {
        return {
            guard
                let scopeView = self.friendsSearBar.searchTextField.leftView,
                let placeholderLabel = self.friendsSearBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            else {
                return
            }

            UIView.animate(withDuration: 0.3,
                           animations: {
                scopeView.frame = CGRect(x: self.friendsSearBar.frame.width / 2 - 15,
                                         y: scopeView.frame.origin.y,
                                         width: scopeView.frame.width,
                                         height: scopeView.frame.height)
                placeholderLabel.frame.origin.x -= 20
                self.friendsSearBar.layoutSubviews()
            })
        }
    }

//MARK: Add friends
    func featchFriends() {
        friendsService.loadFriends { [weak self] friends in
            guard let self = self else { return }
            self.friendsArray = self.simpleFactory(friends)
            DispatchQueue.main.async {
                self.sourseArray = self.friendsArray
                self.tableFriends.reloadData()
            }
        }
    }

    func simpleFactory(_ inputData: [FriendItems]) -> [FriendItemsForCell] {
        var friendItems = [FriendItemsForCell]()
        inputData.forEach { value in
            var friend = FriendItemsForCell()
            friend.id = value.id
            friend.name = "\(value.firstName) \(value.lastName)"
            friend.photo200orig = value.photo200orig

            if value.id % 2 == 0 {
                friend.color = .systemTeal
            }

            friendsService.loadImage(url: value.photo200orig) { image in
                friend.avatar = image
                friendItems.append(friend)
            }
        }
        return friendItems
    }

//    func fillSoursArray(_ friends: [FriendItems]) {
//        do {
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: config)
//            realm.beginWrite()
//            realm.add(friends)
//            print(realm.configuration.fileURL?.path)
//            try realm.commitWrite()
//        }
//        catch {
//            fatalError("fatal error")
//        }
//    }

// MARK: Basic func
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFriends.dataSource = self
        tableFriends.delegate = self
        tableFriends.register(UINib(nibName: allTableViewCell, bundle: nil), forCellReuseIdentifier: customCellReuseIndetificator)
//        fillSoursArray(sourseArray)
        friendsSearBar.delegate = self
        featchFriends()
    }
}
