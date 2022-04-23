import UIKit

protocol AllTableViewCellDelegate: AnyObject {
    func cellPresed(friend: Friends)
}

// MARK: TableView class. Creation default viewTable
class AllTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabe: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var avatarButton: UIButton!

    let friendService = FriendsServiceManager()

//    Вызод анимации 2 вида
    var closure: (() -> Void)?
//    weak var delegate: AllTableViewCellDelegate?

    override func prepareForReuse() {
        super.prepareForReuse()
// MARK: Removed data in default view
        avatarImage.image = nil
        nameLabe.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()

// MARK: Add perfect layer
        avatarImage.layer.cornerRadius = 20
        viewImage.layer.cornerRadius = 20
        nameLabe.layer.cornerRadius = 5
        viewImage.layer.shadowColor = UIColor.castomColorVK.cgColor
        viewImage.layer.shadowRadius = 3
        viewImage.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewImage.layer.shadowOpacity = 0.75
        // Initialization code
    }

// 2. Добавить анимацию нажатия на аватарку пользователя/группы в соответствующих таблицах. По нажатию фотография должна немного сжиматься, а после — возвращаться в исходное положение с эффектом пружины. Нужно подобрать оптимальное время анимации, чтобы получить максимально реалистичный эффект.
// MARK: Animation press to avatar
    @IBAction func avatarActionButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {[weak self] in
            guard let self = self else {return}
            
            let scaleAction = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.viewImage.transform = scaleAction
        },
                       completion: { isSuccess in
            if isSuccess {
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 0.1,
                               initialSpringVelocity: 1,
                               options: .curveEaseOut,
                               animations: { [weak self] in
                    guard let self = self else {return}
                    let scaleActionMin = CGAffineTransform(scaleX: 1, y: 1)
                    self.viewImage.transform = scaleActionMin
                },
                               completion: { isSuccess in
                    if isSuccess {
                        self.closure?()
                    }
                })
            }
        }
        )
    }

// MARK: Func for add view
    func config(image: UIImage?, text: String?) {
        avatarImage.image = image
        nameLabe.text = text
    }

    // MARK: simple factory
    func config(friend: FriendItemsForCell,  closure: @escaping (() -> Void)) {
        nameLabe.text = friend.name
        avatarImage.image = friend.avatar

        // MARK: Call animation
        self.closure = closure
    }

    func config(group: GroupItems) {
        let photo = group.photo50
        friendService.loadImage(url: photo) { [weak self] image in
            guard let self = self else { return }
            self.avatarImage.image = image
        }
        nameLabe.text = group.name
    }
}
