
import UIKit

extension FriendsViewController: UITableViewDelegate {

// Высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightTableViev
    }

// Отправка на новый контроллер данных
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toGallery,
           let friendsFotoArray = sender as? [String],
           let destinator = segue.destination as? PersonalPageVC {
            destinator.sourseArray = friendsFotoArray
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

// Nice segua
//        if let friendsFotoArray = sourseArray[indexPath.item].fotoArray{
//            performSegue(withIdentifier: toGallery, sender: friendsFotoArray)
//        }

        var friendsFotoArray: [String] = []
        friendsFotoArray.append(sourseArray[indexPath.item].avatar ?? "")
        friendsFotoArray.append(sourseArray[indexPath.item].name)
        friendsFotoArray.append(contentsOf: sourseArray[indexPath.item].fotoArray ?? [""])

        performSegue(withIdentifier: toGallery, sender: friendsFotoArray)
    }
}
