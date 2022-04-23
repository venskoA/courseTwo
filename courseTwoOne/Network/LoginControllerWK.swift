import UIKit
import WebKit

class LoginControllerWK: UIViewController {
    @IBOutlet weak var loginWebView: WKWebView! {
        didSet {
            loginWebView.navigationDelegate = self
        }
    }
    var session = Session.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAuth()
    }
}

private extension LoginControllerWK {
    func loadAuth() {
        var urlComponent = URLComponents()

        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: "8047832"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        let request = URLRequest(url: urlComponent.url!)
        loginWebView.load(request)
    }
}

extension LoginControllerWK: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let param = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        if let token = param["access_token"], let userId = param["user_id"] {
            session.token = token
            session.userId = Int(userId)!
            print("token = ", token)
            print("userId = ", userId)
            decisionHandler(.cancel)
            performSegue(withIdentifier: "fromLoginToRasswordWK", sender: self)
        }
    }
}
