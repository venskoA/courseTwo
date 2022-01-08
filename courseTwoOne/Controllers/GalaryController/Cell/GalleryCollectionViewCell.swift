import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var defoultView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!

//    рандомное кол лайков
    var isHearButton = Bool.random()
    var likeLabelRandom = Int.random(in: 0...1000)

// инициализация контроллера
    override func awakeFromNib() {
        super.awakeFromNib()
//        likeLabel.transform = CGAffineTransform(translationX: -(1000), y: 0)
//        likeSpeed()

        galleryView.layer.cornerRadius = 20
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.layer.borderWidth = 3

        galleryView.layer.shadowColor = UIColor.black.cgColor
        galleryView.layer.shadowOffset = CGSize(width: 5, height: 5)
        galleryView.layer.shadowRadius = 4
        galleryView.layer.shadowOpacity = 0.75

        likeLabel.text = String(likeLabelRandom)
        if isHearButton, likeLabelRandom != 0 {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }

// Лайк появляется из стороны
//    func likeSpeed() {
//
//
//        UIView.animate(withDuration: 15, animations: {
//            self.likeLabel.transform = .identity
//        })
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

//    обработка image
    func configures(image: UIImage?, index: Int) {

        imageView.image = image

        if index % 2 == 0 {
            galleryView.backgroundColor = UIColor.systemIndigo
        } else {
            galleryView.backgroundColor = UIColor.systemTeal
        }
    }

// MARK: Like
    @IBAction func pressLikeLabel(_ sender: Any) {

//        3. Сделать анимацию изменения количества отметок «Мне нравится». Это может быть любая анимация: переворот из стороны в сторону, плавная смена или перелистывание.

        UIView.transition(with: likeLabel,
                          duration: 2,
                          options: .transitionCurlUp,
                          animations: {[weak self] in
            guard let self = self else {return}
            if self.isHearButton, self.likeLabelRandom != 0 {
                self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.likeLabelRandom += 1
                self.likeLabel.text = String(self.likeLabelRandom)
            } else {
                self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.likeLabelRandom -= 1
                self.likeLabel.text = String(self.likeLabelRandom)
            }
            self.isHearButton = !self.isHearButton
        },
                          completion: nil)
    }
}

