import UIKit

class MyGroupViewController: UIViewController {

    @IBOutlet weak var tableViewMyGroup: UITableView!
    let toAllGroup = "toAllGroup"

    var sourseArrayMyGroup = [Group]()

    let registerTableViewMyGroup = "RegisterTableViewMyGroup"
    let allTableViewCell = "AllTableViewCell"
    let heightTableViev: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMyGroup.dataSource = self
        tableViewMyGroup.delegate = self
        tableViewMyGroup.register(UINib(nibName: allTableViewCell, bundle: nil), forCellReuseIdentifier: registerTableViewMyGroup)
        NotificationCenter.default.addObserver(self, selector: #selector(addGroup(_ :)), name: NSNotification.Name("groupSelectedNotification"), object: nil)
    }

    @objc func addGroup(_ notification: Notification) {
        guard let groupObject = notification.object as? Group else {return}

        if sourseArrayMyGroup.contains(where: { sourseGroup in
            sourseGroup.name == groupObject.name
        }) {

        } else {
            sourseArrayMyGroup.append(groupObject)
            tableViewMyGroup.reloadData()
        }
    }

    @IBAction func addGroupActionButton(_ sender: Any) {
        loadingView(letView: tableViewMyGroup)

// MARK: Pause
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {[weak self] in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.toAllGroup, sender: nil)
        })
    }

// MARK: Animation download new controllers. Apple Indicator
    func loadingView(letView: UIView) {
        let loading = UIActivityIndicatorView(style: .large)
        loading.center = CGPoint(x: letView.frame.width / 2, y: letView.frame.height / 2 + 10)
        loading.transform = CGAffineTransform(scaleX: 2, y: 2)
        letView.addSubview(loading)
        loading.startAnimating()

// MARK: Time delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            loading.removeFromSuperview()
            letView.backgroundColor = UIColor.white.withAlphaComponent(0)
        })
    }

// MARK: Remove Notification
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
