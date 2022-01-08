import UIKit

extension AllGroupViewController: UITableViewDelegate {

// MARK: Height table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTableViev
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
// MARK: Create allert for add Group
        let alertController = UIAlertController(title: "Add Group", message: nil, preferredStyle: .actionSheet)
        let alertYes = UIAlertAction(title: "yes", style: .default, handler: {[weak self]_ in
            guard let self = self else{return}
            NotificationCenter.default.post(name: NSNotification.Name("groupSelectedNotification"), object: self.sourseArrayAllGroup[indexPath.row])
        })
        let alertNo = UIAlertAction(title: "no", style: .cancel, handler: nil)

        alertController.addAction(alertYes)
        alertController.addAction(alertNo)

        self.present(alertController, animated: true, completion: nil)
    }
}
