import UIKit

// MARK: Animatioon with controllers
class Animation: NSObject, UIViewControllerAnimatedTransitioning {

    var boolVar: Bool

    init(boolVar: Bool){
        self.boolVar = boolVar
    }

// MARK: Time interval
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
// MARK: Animation body
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

// MARK: Broadcast contrallers variable
        guard let firstSourseController = transitionContext.viewController(forKey: .from),
              let secondDestinatorController = transitionContext.viewController(forKey: .to) else {return}

        transitionContext.containerView.addSubview(secondDestinatorController.view)
        secondDestinatorController.view.frame = firstSourseController.view.frame

        if boolVar {
            secondDestinatorController.view.transform = CGAffineTransform(translationX: firstSourseController.view.frame.width, y: 0)
        }
        else {
            secondDestinatorController.view.transform = CGAffineTransform(translationX: -firstSourseController.view.frame.width, y: 0)
        }

        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubicPaced,
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.3,
                               animations: {
                var translation = CGAffineTransform()

                if self.boolVar {
                    translation = CGAffineTransform(translationX: -200, y: 0)
                }
                else {
                    translation = CGAffineTransform(translationX: 200, y: 0)
                }
                
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                firstSourseController.view.transform = translation.concatenating(scale)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.3,
                               animations: {
                var translation = CGAffineTransform()

                if self.boolVar {
                    translation = CGAffineTransform(translationX: firstSourseController.view.frame.width / 2, y: 0)
                }
                else {
                    translation = CGAffineTransform(translationX: -firstSourseController.view.frame.width / 2, y: 0)
                }

                let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                secondDestinatorController.view.transform = translation.concatenating(scale)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.4,
                               animations: {
                secondDestinatorController.view.transform = .identity
            })
        },
                                completion: { isSucces in
            if isSucces && !transitionContext.transitionWasCancelled {
                firstSourseController.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        })
    }
}
