import UIKit

class TestLoadDataVCr: UIViewController {
    let session = Session.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//MARK: Load friends list
    func loadListFriends() {
        let apiFriends = "http://api.vk.com/method/friends.get?user_id=111083982&order=name&count=10&fields=nickname&access_token=session.token&v=5.131"

//MARK: URL for friend
        var urlFriends = URLComponents()
        urlFriends.scheme = "https"
        urlFriends.host = "api.vk.com"
        urlFriends.path = "/method/friends.get"
        urlFriends.queryItems = [
//            URLQueryItem(name: "user_id", value: String(session.userId)),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        sessionFirstMetod(url: urlFriends)
        sessionSecondMetod(url: urlFriends)
    }

//MARK: Load Albom
    func loadListAlbom() {
        var urlAlbom = URLComponents()
        urlAlbom.scheme = "https"
        urlAlbom.host = "api.vk.com"
        urlAlbom.path = "/method/photos.getAll"
        urlAlbom.queryItems = [
//            URLQueryItem(name: "owner_id", value: ("-" + String(session.userId))),
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        sessionFirstMetod(url: urlAlbom)

    }

    //MARK: Load friends list
    func loadListGroup() {

        //MARK: URL for friend
        var urlGroup = URLComponents()
        urlGroup.scheme = "https"
        urlGroup.host = "api.vk.com"
        urlGroup.path = "/method/groups.get"
        urlGroup.queryItems = [
//            URLQueryItem(name: "user_id", value: String(session.userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        sessionFirstMetod(url: urlGroup)
    }

    //MARK: First metod session
    func sessionFirstMetod(url: URLComponents) {
        let sessionUrl = URLSession.shared
        sessionUrl.dataTask(with: url.url!) { data, response, error in
            if let response = response {
                print(response)
            }

            guard let data = data else {return}

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(json)
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    //MARK: Second metod session
    func sessionSecondMetod(url: URLComponents) {
        var urlFriendsRequest = URLRequest(url: url.url!)
        urlFriendsRequest.httpMethod = "GET"

        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: urlFriendsRequest) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }

    @IBAction func actionButton(_ sender: Any) {
        loadListAlbom()
    }
}

