import UIKit

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            sourseArray = friendsArray
        }
        else {
            sourseArray = friendsArray.filter({ friendsNew in
                friendsNew.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableFriends.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.friendsSearBar.showsCancelButton = true // показать кнопку кансл

        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton

        cancelButton.backgroundColor = .lightGray
        cancelButton.setTitleColor(.white, for: .normal)

        UIView.animate(withDuration: 0.3,
                       animations: {
// Двигаем кнопку кансл
            cancelButton.frame = CGRect(x: cancelButton.frame.origin.x - 50,
                                        y: cancelButton.frame.origin.y,
                                        width: cancelButton.frame.width,
                                        height: cancelButton.frame.height)

// Анимируем запуск поиска. -1 чтобы пошла анимация, тогда лупа плавно откатывается
            self.friendsSearBar.frame = CGRect(x: self.friendsSearBar.frame.origin.x,
                                               y: self.friendsSearBar.frame.origin.y,
                                               width: self.friendsSearBar.frame.size.width - 1,
                                               height: self.friendsSearBar.frame.size.height)
            self.friendsSearBar.layoutSubviews()
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
// Анимацию возвращения в исходное состояние после нажатия кансл
        UIView.animate(withDuration: 0.2,
                       animations: {[weak self] in
            guard let self = self else {return}

            searchBar.showsCancelButton = false // скрываем кнопку кансл
            searchBar.text = nil
            self.sourseArray = self.friendsArray
            self.tableFriends.reloadData()
            searchBar.resignFirstResponder() // скрываем клавиатуру
        }, completion: { [weak self] _ in
            guard let self = self else {return}

            let closure = self.searchBarAnimateClosure()
            closure()
        })
    }
}
