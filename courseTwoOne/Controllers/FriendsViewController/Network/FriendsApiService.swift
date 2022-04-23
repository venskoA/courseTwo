import Foundation

enum AllError: Error {
    case parseError
    case requestError(Error)
}

enum TypeMetod: String {
    case friendGet = "/method/friends.get"
    case groupGet = "/method/groups.get"
}

enum TypeRequests: String {
    case get = "GET"
    case post = "POST"
}

final class FriendsApiService {
    private let schema = "http"
    private let host = "api.vk.com"
    private let versionApi = "5.81"

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        return session
    }()

    func loadFriends(completion: @escaping ((Result<FriendsVK, AllError>) -> ())) {
        guard let token = Session.shared.token else {return}
        let param: [String: String] = ["fields": "photo_50",
                                       "order": "name"]

        let url = configure(token: token,
                            method: .friendGet,
                            httpMetod: .get,
                            param: param)

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

private extension FriendsApiService {
    func configure(token: String,
                   method: TypeMetod,
                   httpMetod: TypeRequests,
                   param: [String: String]) -> URL {
        var queryItem = [URLQueryItem]()
        queryItem.append(URLQueryItem(name: "access_token", value: token))
        queryItem.append(URLQueryItem(name: "v", value: versionApi))

        for (param, value) in param {
            queryItem.append(URLQueryItem(name: param, value: value))
        }

        var urlConponent = URLComponents()
        urlConponent.scheme = schema
        urlConponent.host = host
        urlConponent.path = method.rawValue
        urlConponent.queryItems = queryItem

        guard let url = urlConponent.url else {
            fatalError("URL is invaled")
        }
        return url
    }
}
