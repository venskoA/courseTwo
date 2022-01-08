import UIKit

class GalleryGoodHorisotalScrol: UIView {

    private var view: UIImageView?

    private var interactiveAnimator: UIViewPropertyAnimator!

// MARK: Variable in code
    private var image = [String]()
    private var firstImageView = UIImageView()
    private var secondImageView = UIImageView()
    private var isLeftSwipe = false
    private var isRightSwipe = false
    private var chooseFlag = false
    private var currentIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

// MARK: Subscrape on CastomView (GalleryGoodHorisontalSkrol)
    private func loadFromNib() -> UIImageView {
        let bundler = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GalleryGoodHorisontalSkrol", bundle: bundler)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIImageView
        else {return UIImageView()}

        return view
    }

// MARK: Basic translation setup
    private func setup() {

        view = loadFromNib()
        guard let view = view else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        let recognaser = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognaser)

        firstImageView.backgroundColor = UIColor.systemRed
        firstImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.bounds.height)
        firstImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 2.5))
        addSubview(firstImageView)

        secondImageView.backgroundColor = UIColor.systemGray
        secondImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.bounds.height)
        secondImageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 2.5))
        secondImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        addSubview(secondImageView)
    }

// MARK: Moving view
    private func onChange(isRight: Bool) {
        if isRight {
            self.secondImageView.image = UIImage(named: image[currentIndex - 1])
            self.secondImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }
        else {
            self.secondImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            self.secondImageView.image = UIImage(named: image[currentIndex + 1])
        }
    }

// MARK: Change index in array
    private func onChangeImage(isRight: Bool) {
        if isRight {
            currentIndex -= 1
        }
        else {
            currentIndex += 1
        }
        self.firstImageView.image = UIImage(named: image[currentIndex])
        self.bringSubviewToFront(firstImageView)
    }

// MARK: Tap finder on screen (add animation)
    @objc func onPan(_ recognaser: UIPanGestureRecognizer) {

        if let animation = interactiveAnimator,
           animation.isRunning {
            return
        }

        switch recognaser.state {
        case .began:
            self.firstImageView.transform = .identity
            self.firstImageView.image = UIImage(named: image[currentIndex])
            self.secondImageView.transform = .identity
            self.bringSubviewToFront(self.firstImageView)

            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         curve: .easeInOut,
                                                         animations: {[weak self] in
                self?.secondImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                                                         })
            interactiveAnimator.pauseAnimation()

            isLeftSwipe = false
            isRightSwipe = false
            chooseFlag = false

        case .changed:
            var translation = recognaser.translation(in: self.view)

            if translation.x < 0 {
                if currentIndex == (image.count - 1) {
                    interactiveAnimator.stopAnimation(true)
                    return
                }

                chooseFlag = true
                onChange(isRight: false)

                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations {[weak self] in
                    guard let self = self else {return}
                    self.firstImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    self.secondImageView.transform = .identity

                }

                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeImage(isRight: false)
                })

                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()

                isLeftSwipe = true
            }

            if translation.x > 0 {
                if currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }

                chooseFlag = true
                onChange(isRight: true)

                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations {[weak self] in
                    guard let self = self else {return}
                    self.firstImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    self.secondImageView.transform = .identity

                }

                interactiveAnimator.addCompletion({[weak self] _ in
                    self?.onChangeImage(isRight: true)
                })

                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()

                isRightSwipe = true
            }

            if isRightSwipe, translation.x < 0 {return}
            if isLeftSwipe, translation.x > 0 {return}

            if translation.x < 0 {
                translation.x = -translation.x
            }

            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width * 10)

        case .ended:
            var translation = recognaser.translation(in: self.view)

            if translation.x < 0 {
                translation.x = -translation.x
            }

            if (translation.x / UIScreen.main.bounds.width) > 0.5 {
                interactiveAnimator.startAnimation()
            }
            else {
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.finishAnimation(at: .start)
                interactiveAnimator.addAnimations {[weak self] in
                    guard let self = self else {return}
                    self.firstImageView.transform = .identity

                    if self.isRightSwipe {
                        self.secondImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                    if self.isLeftSwipe {
                        self.secondImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                }
                self.interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }

    func setImage(image: [String]) { // MARK: Download image in this class
        self.image = image
        if self.image.count > 0 {
            let image = UIImage(named: self.image.first ?? "")
            self.firstImageView.image = image
        }
    }
}
