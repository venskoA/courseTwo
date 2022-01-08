
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCellReuseIndetificator, for: indexPath) as? AllTableViewCell else {return UITableViewCell()}

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.systemTeal
        } else {
            cell.backgroundColor = UIColor.systemMint
            cell.nameLabe.layer.cornerRadius = 7
            cell.nameLabe.layer.backgroundColor = UIColor.systemYellow.cgColor
        }
        cell.config(friend: sourseArray[indexPath.row], closure: {[weak self] in
            
// Вызов анимации из AllTableViewCell
            if let self = self,
                  var friendsFotoArray = self.sourseArray[indexPath.item].fotoArray {
                friendsFotoArray.removeAll()
                friendsFotoArray.append(self.sourseArray[indexPath.item].avatar ?? "")
                friendsFotoArray.append(self.sourseArray[indexPath.item].name)
                friendsFotoArray.append(contentsOf: self.sourseArray[indexPath.item].fotoArray ?? [""])

                self.performSegue(withIdentifier: self.toGallery, sender: friendsFotoArray)
            }
        })
        return cell
    }
}
