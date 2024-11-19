import Foundation

class NetworkService {
    static let shared = NetworkService()

    // Base URL de votre API
    private let baseURL = "http://172.20.10.3:3000/api"

    // Fonction pour effectuer un appel POST
    func postRequest(endpoint: String, body: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid Response", code: 500, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }

            completion(.success(data))
        }.resume()
    }

    // Fonction Login
    func login(email: String, password: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let body: [String: Any] = ["email": email, "password": password]
        postRequest(endpoint: "auth/login", body: body, completion: completion)
    }

    // Fonction Signup
    func signup(name: String, email: String, password: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let body: [String: Any] = ["name": name, "email": email, "password": password]
        postRequest(endpoint: "auth/signup", body: body, completion: completion)
    }

    // Fonction Forget Password
    func forgetPassword(email: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let body: [String: Any] = ["email": email]
        postRequest(endpoint: "auth/forget-password", body: body, completion: completion)
    }
}
