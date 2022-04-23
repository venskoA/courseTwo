import Foundation

enum AllError: Error {
    case parseError
    case requestError(Error)
}

enum TypeMetod: String {
    case friendGet = "/method/friends.get"
    case groupGet = "/method/groups.get"
    case photosGetAll = "/method/photos.getAll"
    case groupsSearch = "/method/groups.search"
    case groupsJoin = "/method/groups.join"
    case groupsLeave = "/method/groups.leave"
    case newsFeed = "/method/newsfeed.get"
}

enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

final class FriendsApiService {
    private let config = ConfigureUrl()

//    private let realmCacheService = RealmCacheService.
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        return session
    }()

    func loadFriends(completion: @escaping ((Result<FriendsVK, AllError>) -> ())) {
        guard let token = Session.shared.token else {return}
        let param: [String: String] = ["fields": "photo_200_orig",
                                       "order": "name"]

        let url = config.configure(token: token,
                                   method: .friendGet,
                                   httpMetod: .get,
                                   param: param)
        print("Friends url = \(url)")
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(FriendsVK.self, from: data)
                return completion(.success(result))
            } catch {
                return completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}
