import Foundation

final class GroupApiService {
    private let schema = "http"
    private let host = "api.vk.com"
    private let versionApi = "5.81"

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        return session
    }()

    func loadGroup(completion: @escaping ((Result<GroupVK, AllError>) -> ())) {
        guard let token = Session.shared.token else {return}
        let param: [String: String] = ["extended": "1"]

        let url = configure(token: token,
                            method: .groupGet,
                            httpMetod: .get,
                            param: param)
        print("Group url = \(url)")

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.requestError(error)))
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(GroupVK.self, from: data)
                return completion(.success(result))
            } catch {
                print("---------- \(error)")
                return completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

private extension GroupApiService {
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
