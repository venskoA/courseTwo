import UIKit

class AllGroupViewController: UIViewController {

    @IBOutlet weak var tableViewAllGroup: UITableView!
    
    var sourseArrayAllGroup = [Group]()

    let registerTableViewAllGroup = "RegisterTableViewAllGroup"
    let allTableViewCell = "AllTableViewCell"
    let heightTableViev: CGFloat = 50

// MARK: Add new group
    func groupfillSoursArray() {
        let groupOne = Group(name: "Telega", avatar: "23")
        let groupTwo = Group(name: "Vk", avatar: "13")
        let groupThree = Group(name: "Viber", avatar: "22")
        sourseArrayAllGroup.append(groupOne)
        sourseArrayAllGroup.append(groupTwo)
        sourseArrayAllGroup.append(groupThree)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewAllGroup.dataSource = self
        tableViewAllGroup.delegate = self
// MARK: Register castom tableView
        tableViewAllGroup.register(UINib(nibName: allTableViewCell, bundle: nil), forCellReuseIdentifier: registerTableViewAllGroup)
        groupfillSoursArray()
    }
}
