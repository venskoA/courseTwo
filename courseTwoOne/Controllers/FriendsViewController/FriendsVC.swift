import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableFriends: UITableView!
    @IBOutlet weak var friendsSearBar: UISearchBar!

    var sourseArray = [Friends]()
    var friendsArray = [Friends]()

    let customCellReuseIndetificator = "CustomCellReuseIndetificator"
    let allTableViewCell = "AllTableViewCell"
    let heightTableViev: CGFloat = 50
    let toGallery = "toGallery"

// MARK: Add friends
    func fillSoursArray() {
        let friendsOne = Friends(name: "Saha", avatar: "40", fotoArray: ["40", "12", "13",
                                                                         "21", "22", "23"])
        let friendsTwo = Friends(name: "Tany", avatar: "41", fotoArray: ["41", "22", "23"])
        let friendsThree = Friends(name: "Kristina", avatar: "43", fotoArray: ["43", "21", "11"])
        let friendsFour = Friends(name: "Sergey", avatar: "42", fotoArray: ["42", "23", "22"])
        let friendsFive = Friends(name: "Egor", avatar: "51", fotoArray: ["24", "25", "26",
                                                                          "27", "28", "29", "32",
                                                                         "33", "34", "35"])
        let friendsSix = Friends(name: "Kiril", avatar: "61", fotoArray: ["26", "22"])
        let friendsSeven = Friends(name: "Julia", avatar: "71", fotoArray: ["41", "22", "23",
                                                                           "24", "25", "26",
                                                                           "27", "28", "29",
                                                                           "32", "26", "40"])
        friendsArray.append(friendsOne)
        friendsArray.append(friendsTwo)
        friendsArray.append(friendsThree)
        friendsArray.append(friendsFour)
        friendsArray.append(friendsFive)
        friendsArray.append(friendsSix)
        friendsArray.append(friendsSeven)
    }

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

// MARK: Basic func
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFriends.dataSource = self
        tableFriends.delegate = self
        tableFriends.register(UINib(nibName: allTableViewCell, bundle: nil), forCellReuseIdentifier: customCellReuseIndetificator)
        fillSoursArray()
        sourseArray = friendsArray
        friendsSearBar.delegate = self
    }
}
