import Foundation

class Indexes {

    let request: Request
    
    init (config: Config) {
        request = Request(config: config)
    }

    func get(uid: String, _ completion: @escaping (Result<Index, Error>) -> Void) {
        var api: String = "/indexes/"
        api += uid
        self.request.get(api: api) { result in

            switch result {
            case .success(let data):

            do {
                let index = try JSONDecoder().decode(Index.self, from: data)
                completion(.success(index))
            } catch {
                completion(.failure(error))
            }

            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

    func getAll(_ completion: @escaping (Result<[Index], Error>) -> Void) {
        self.request.get(api: "/indexes") { result in

            switch result {
            case .success(let data):

            do {
                let indexes = try JSONDecoder().decode([Index].self, from: data)
                completion(.success(indexes))
            } catch {
                completion(.failure(error))
            }

            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

    func create(uid: String, _ completion: @escaping (Result<Void, Error>) -> Void) {

        let payload = CreateIndexPayload(uid: uid)
        let jsonData = try! JSONEncoder().encode(payload)

        self.request.post(api: "/indexes", body: jsonData) { result in

            switch result {
            case .success(let data):
                completion(.success(()))

            case .failure(let error):
                completion(.failure(error))
            }

        }
    }

    func update(uid: String, name: String, _ completion: @escaping (Result<(), Error>) -> Void) {

        var api: String = "/indexes/"
        api += uid

        let payload = UpdateIndexPayload(name: name)
        let jsonData = try! JSONEncoder().encode(payload)

        self.request.put(api: api, body: jsonData) { result in

            switch result {
            case .success(let data):
                completion(.success(()))

            case .failure(let error):
                completion(.failure(error))
            }

        }

    }

    func delete(uid: String, _ completion: @escaping (Result<Void, Error>) -> Void) {

        var api: String = "/indexes/"
        api += uid

        self.request.delete(api: api) { result in

            switch result {
            case .success(let data):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }

        }

    }

}

struct CreateIndexPayload: Codable {
    let uid: String
}

struct UpdateIndexPayload: Codable {
    let name: String
}