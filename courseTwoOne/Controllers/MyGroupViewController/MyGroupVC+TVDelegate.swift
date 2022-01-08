import UIKit

extension MyGroupViewController: UITableViewDelegate {

// MARK: Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTableViev
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

// MARK: Add alert for remove group
        if editingStyle == .delete {
            let allertController = UIAlertController(title: "Delet cell", message: "What are you sure to delet?", preferredStyle: .alert)
            let astionYes = UIAlertAction(title: "yes", style: .default, handler: { [weak self] _ in
                self?.sourseArrayMyGroup.remove(at: indexPath.row)
                self?.tableViewMyGroup.deleteRows(at: [indexPath], with: .automatic)
            })
            let actionNo = UIAlertAction(title: "no", style: .cancel, handler: nil)

            allertController.addAction(astionYes)
            allertController.addAction(actionNo)
            self.present(allertController, animated: true, completion: nil)
        }
    }
}
