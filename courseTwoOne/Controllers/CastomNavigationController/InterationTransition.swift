//import UIKit
//
//class InterationTransition: UIPercentDrivenInteractiveTransition {
//
//    var shouldFinish = false
//    var isStartedAnimation = false
//// MARK: Start animation via Tap
//    var uiViewController: UIViewController? {
//        didSet{
//            let panRecognazer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_: )))
//            uiViewController?.view.addGestureRecognizer(panRecognazer)
//        }
//    }
//// MARK: func for animate yuor finder
//    @objc func onPan(_ recognazer: UIPanGestureRecognizer) {
//// MARK: UIGestureRecognizer have position in animate
//        switch recognazer.state {
//// MARK: Start animation
//        case .began:
//            isStartedAnimation = true
//            self.uiViewController?.navigationController?.popViewController(animated: true)
//            self.pause()
//// MARK: move animation
//        case .changed:
//            var translation = recognazer.translation(in: recognazer.view)
//            if translation.x < 0 {
//                translation.x = (-translation.x)
//            }
//
//            let relativeTranslation = translation.x / (recognazer.view?.frame.width ?? 1)
//            let progress = max(0, relativeTranslation)
//            if progress > 0.3 {
//                self.shouldFinish = true
//            }
//            self.update(progress)
//// MARK: End animation
//        case .ended:
//            if shouldFinish {
//                isStartedAnimation = false
//                self.finish()
//            } else {
//                self.cancel()
//            }
//// MARK: Cansel animation
//        case .cancelled:
//            isStartedAnimation = false
//            self.cancel()
//        default: return
//        }
//    }
//}
