
import UIKit

// MARK: Extension for AllGRoup
extension AllGroupViewController: UITableViewDataSource{

// MARK: Weight table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

// MARK: Nambers line
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourseArrayAllGroup.count
    }

// MARK: Add in tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: registerTableViewAllGroup, for: indexPath) as? AllTableViewCell else {return UITableViewCell()}

        cell.backgroundColor = self.view.backgroundColor
        cell.viewImage.layer.backgroundColor = UIColor.systemIndigo.cgColor

        cell.config(group: sourseArrayAllGroup[indexPath.row])
        return cell
    }

}
