import UIKit

extension MyGroupViewController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourseArrayMyGroup.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: registerTableViewMyGroup, for: indexPath) as? AllTableViewCell else {return UITableViewCell()}
        cell.viewImage.layer.backgroundColor = UIColor.systemCyan.cgColor
        cell.nameLabe.layer.cornerRadius = 7
        cell.nameLabe.layer.backgroundColor = UIColor.systemGreen.cgColor
        cell.backgroundColor = self.view.backgroundColor

        cell.config(group: sourseArrayMyGroup[indexPath.row])
        return cell
    }

}
