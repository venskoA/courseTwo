import UIKit

class SecondaryGalleryVC: UIViewController {
    var photoImage: [String] = [""]
    var photo: [UIImage] = []
    var photoView: [UIImageView] = []
    var selectedPhoto = 0

// MARK: Create three view for foto
    private var leftImageView: UIImageView!
    private var middleImageView: UIImageView!
    private var rightImageView: UIImageView!

    var right = false
    var left = false

// MARK: UIViewPropertyAnimator, задаём доступные нам жесты
    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!

// MARK: Add fotos in array
    func setImageFoto(image: [String]) {
        for index in image where image.count > 0 {
            photo.append(UIImage(named: index)!)
        }
    }

// MARK: Create array ImageView and add Foto
    func createPhotoViews(name: [UIImage]) {
        for photo in name {
            let view = UIImageView()
            view.image = photo
            view.contentMode = .scaleAspectFit

            photoView.append(view)
        }
    }

// MARK: Basic function
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageFoto(image: photoImage)
        createPhotoViews(name: photo)
    }

    override func viewDidAppear(_ animated: Bool) {
        let recognaser = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(recognaser)

        animation()
    }

// MARK: Config view
    func setImage(){
        var indexPhotoLeft = selectedPhoto - 1
        let indexPhotoMid = selectedPhoto
        var indexPhotoRight = selectedPhoto + 1

        //MARK: Infiniti scrolling
        if indexPhotoLeft < 0 {
            indexPhotoLeft = photoView.count - 1
        }
        if indexPhotoRight > photoView.count - 1 {
            indexPhotoRight = 0
        }

// MARK: Clear view
        view.subviews.forEach({ $0.removeFromSuperview()})

// MARK: Add foto on the view
        leftImageView = photoView[indexPhotoLeft]
        middleImageView = photoView[indexPhotoMid]
        rightImageView = photoView[indexPhotoRight]

        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)

// MARK: Clear consrain
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

// MARK: Add constrain
        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 1),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
        ])

        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)

        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.leftImageView.transform = scale

    }

    func animation() {
        setImage()
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [],
                       animations: { [unowned self] in
            self.middleImageView.transform = .identity
            self.leftImageView.transform = .identity
            self.rightImageView.transform = .identity
        })
    }

// MARK: Animation for press finger
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let left = swipeToLeft,
           left.isRunning {
            return
        }
        
        if let right = swipeToRight,
           right.isRunning {
            return
        }

        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(duration: 1,
                                                  curve: .easeInOut,
                                                  animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    if right == true {
                        self.selectedPhoto -= 1
                        if self.selectedPhoto < 0 {
                            self.selectedPhoto = self.photo.count - 1
                        }
                    }
                    self.animation()
                })
            })

            swipeToLeft = UIViewPropertyAnimator(duration: 1,
                                                 curve: .easeInOut,
                                                 animations: {
                UIView.animate(withDuration: 0.01,
                               delay: 0,
                               options: [],
                               animations: { [unowned self] in
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 40, y: 0)
                    let transform = scale.concatenating(translation)
                    middleImageView.transform = transform
                    leftImageView.transform = transform
                    rightImageView.transform = transform
                },
                               completion: { [unowned self] _ in
                    if left == true {
                        self.selectedPhoto += 1
                        if self.selectedPhoto > self.photo.count - 1 {
                            self.selectedPhoto = 0
                        }
                    }
                    self.animation()
                })
            })

        case .changed:
            left = false
            right = false

            var translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = translationX / (UIScreen.main.bounds.width)
                right = true
            } else {
                translationX = -translationX
                swipeToLeft.fractionComplete = translationX / (UIScreen.main.bounds.width)
                left = true
            }
        case .ended:
            var transitionX = recognizer.translation(in: self.view).x
            if transitionX < 0 {
                transitionX = -transitionX
            }

            if (transitionX / (UIScreen.main.bounds.width)) > 0.5 {
                swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            else {
                if left == true {
                    left = false
                    self.swipeToLeft.stopAnimation(true)
                    self.swipeToLeft.finishAnimation(at: .start)
                    swipeToLeft.addAnimations {[weak self] in
                        guard let self = self else {return}
                        self.swipeToLeft = nil
                        self.selectedPhoto -= 1
                        self.setImage()
                    }
                }

                if right == true {
                    right = false
                    self.swipeToRight.stopAnimation(true)
                    self.swipeToRight.finishAnimation(at: .start)
                    swipeToRight.addAnimations {[weak self] in
                        guard let self = self else {return}
                        self.swipeToRight = nil
                        self.selectedPhoto -= 1
                        self.setImage()
                    }
                }
            }
        default:
            return
        }
    }
}
