import UIKit

extension FriendsViewController: UITableViewDataSource{
// Кол. в ширину ячеек
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

// Кол. в высоту ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourseArray.count
    }

// Заполнение ячеек
    // MARK: simple factory
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellReuseIndetificator, for: indexPath) as? AllTableViewCell else {return UITableViewCell()}

        cell.backgroundColor = sourseArray[indexPath.row].color
        cell.nameLabe.layer.cornerRadius = 7
        cell.nameLabe.layer.backgroundColor = UIColor.colorInCaches(255.0, 214.0, 104.0, 1.0).cgColor
        cell.config(friend: sourseArray[indexPath.row], closure: {})
        return cell
    }
}
