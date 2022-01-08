import UIKit

class CastomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension CastomNavigationController: UINavigationControllerDelegate {
    
// MARK: Animation with controllers.
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return Animation(boolVar: true)
        } else {
            return Animation(boolVar: false)
        }
    }
}
