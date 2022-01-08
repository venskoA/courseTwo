import UIKit

class FirstViewController: UIViewController {

    let toOrangeWindow = "fromLoginToRassword"

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrolViewFirstWindow: UIScrollView!

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var therdView: UIView!
    @IBOutlet weak var incorrectLabel: UILabel!

    @IBOutlet var defaulView: UIView!
    @IBOutlet weak var interactiveView: UIView!

    let timeInterval: Double = 1

    override func viewDidLoad() {
        super.viewDidLoad()

//MARK: Display red monitor in the ipad
        let defaultBackgroundView = UIView.appearance(for: UITraitCollection(userInterfaceIdiom: .pad))
        defaultBackgroundView.backgroundColor = UIColor.systemRed

        cloudAnimation()
        gradientLayer()

        firstView.alpha = 0
        secondView.alpha = 0
        therdView.alpha = 0
        incorrectLabel.alpha = 0

        NotificationCenter.default.addObserver(self, selector: #selector(keybordOpen(_ :)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordClose(_ :)), name: UIResponder.keyboardDidHideNotification, object: nil)

        let tapCloseKeybord = UITapGestureRecognizer.init(target: self, action: #selector(tapClose(_ :)))
        self.view.addGestureRecognizer(tapCloseKeybord)
    }

    @objc func tapClose(_ tapCloseKeybord: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @objc func keybordOpen(_ notification: Notification) {
        let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = keyBoardSize?.height else {return}
        let indentOpen = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 100, right: 0)

        scrolViewFirstWindow.contentInset = indentOpen
        scrolViewFirstWindow.scrollIndicatorInsets = indentOpen
    }

    @objc func keybordClose(_ notification: Notification) {
        let indentClose = UIEdgeInsets.zero

        scrolViewFirstWindow.contentInset = indentClose
        scrolViewFirstWindow.scrollIndicatorInsets = indentClose
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func passLoginBatton(_ sender: Any) {
        guard let login = loginTextField.text,
              let passw = passwordTextField.text
        else {return}
        loadingDataNewController()

        let netTimeInterval: Double = timeInterval * 3
        DispatchQueue.main.asyncAfter(deadline: .now() + netTimeInterval, execute: { [weak self] in
            guard let self = self else {return}
            if login == "admin" && passw == "12345" {
                self.performSegue(withIdentifier: self.toOrangeWindow, sender: nil)

            } else {
                self.incorrectEnterAnimation()
                return
            }
        })
    }

/// Interractive cloud animation. Filling by hand (code)
    func cloudAnimation() {
        let castomInterractiveView = UIView()

        view.addSubview(castomInterractiveView)

        castomInterractiveView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            castomInterractiveView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            castomInterractiveView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70)
        ])

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 5, y: 70))
        path.addQuadCurve(to: CGPoint(x: 20, y: 50), controlPoint: CGPoint(x: 15, y: 30))
        path.addQuadCurve(to: CGPoint(x: 50, y: 35), controlPoint: CGPoint(x: 35, y: 15))
        path.addQuadCurve(to: CGPoint(x: 80, y: 35), controlPoint: CGPoint(x: 65, y: 15))
        path.addQuadCurve(to: CGPoint(x: 110, y: 50), controlPoint: CGPoint(x: 95, y: 30))
        path.addQuadCurve(to: CGPoint(x: 140, y: 70), controlPoint: CGPoint(x: 125, y: 50))
        path.close()

        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.lineWidth = 5
        layerAnimation.strokeColor = UIColor.systemMint.cgColor
        layerAnimation.fillColor = UIColor.clear.cgColor

        castomInterractiveView.layer.addSublayer(layerAnimation)

        let animationStar = CABasicAnimation(keyPath: "strokeStart")
        animationStar.fromValue = 0
        animationStar.toValue = 0.4
        animationStar.beginTime = 0.5
        animationStar.duration = 3
        animationStar.isRemovedOnCompletion = false

        let animattionEnd = CABasicAnimation(keyPath: "strokeEnd")
        animattionEnd.fromValue = 0
        animattionEnd.toValue = 1
        animattionEnd.duration = 3
        animattionEnd.isRemovedOnCompletion = false


        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animattionEnd, animationStar]
        animationGroup.repeatCount = .infinity
        animationGroup.duration = 3
        animationGroup.fillMode = CAMediaTimingFillMode.backwards

        layerAnimation.add(animationGroup, forKey: nil)
    }

// MARK: Пружинная анимация неправильного логина или пароля
    func incorrectEnterAnimation() {
        UIView.animate(withDuration: 5,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
            self.loginTextField.backgroundColor = UIColor.red
            self.passwordTextField.backgroundColor = UIColor.red
            self.incorrectLabel.alpha = 1
        },
                       completion: nil)

        UIView.animate(withDuration: 5,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
            self.loginTextField.backgroundColor = UIColor.white
            self.passwordTextField.backgroundColor = UIColor.white
        },
                       completion: nil)
    }

    func gradientLayer() {
        let gradientLayerView = CAGradientLayer()

        gradientLayerView.colors = [UIColor.systemBlue.cgColor,
                                    UIColor.systemCyan.cgColor,
                                    UIColor.systemPink.cgColor]
        gradientLayerView.locations = [0, 0.5, 1]
        gradientLayerView.startPoint = CGPoint(x: 0, y: 0)
        gradientLayerView.endPoint = CGPoint(x: 0, y: 1)
        gradientLayerView.frame = defaulView.bounds

        defaulView.layer.insertSublayer(gradientLayerView, at: 0)
    }

// MARK: Loading circle
    func loadingDataNewController() {
        let animationTimeInterval: CGFloat = 2
        UIView.animateKeyframes(withDuration: animationTimeInterval,
                                delay: 0,
                                options: [.autoreverse],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.25) {[weak self] in
                guard let self = self else {return}
                self.firstView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25,
                               relativeDuration: 0.5) {[weak self] in
                guard let self = self else {return}
                self.secondView.alpha = 1
                self.firstView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.75) {[weak self] in
                guard let self = self else {return}
                self.therdView.alpha = 1
                self.secondView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75,
                               relativeDuration: 1) {[weak self] in
                guard let self = self else {return}
                self.therdView.alpha = 0
            }
        },
                                completion: nil)
    }
}
