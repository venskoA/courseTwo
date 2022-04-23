import Foundation

class ImageLoader {
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    func loadImage(url: URL, comletion: @escaping(Result<Data, Error>) -> Void) {
        let comletionOnMain: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                comletion(result)
            }
        }
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let responseData = data, error == nil else {
                if let error = error {
                    comletionOnMain(.failure(error))
                }
                return
            }
            comletionOnMain(.success(responseData))
        }).resume()
    }
}
