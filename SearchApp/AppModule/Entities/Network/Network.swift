//
//  Network.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych  on 12.01.2024.
//

import UIKit

class Network: NetworkProtocol {
    
//MARK: - request
    func request(urlString: URL,
                 completion: @escaping ( Result <Data, Error>) -> Void) {
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
        }.resume()
    }
//MARK: - search
    func search(searchText: String,
                completion: @escaping ([listDrugsModel]?) -> Void) {
        var components = URLComponents(string: "http://shans.d2.i-partner.ru/api/ppp/index")
//        components?.queryItems = [URLQueryItem(name: "",
//                                               value: "")]
        guard let url = components?.url else { return }
        request(urlString: url) { (result)  in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode([listDrugsModel].self,
                                                         from: data)
                    completion(model)
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
//MARK: - getDrugCard
    func getDrugCard(id: Int,
                completion: @escaping (listDrugsModel?) -> Void) {
        var components = URLComponents(string: "http://shans.d2.i-partner.ru/api/ppp/item/")
        components?.queryItems = [URLQueryItem(name: "id",
                                               value: String(id))]
        guard let url = components?.url else { return }
        request(urlString: url) { (result)  in
            switch result {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(listDrugsModel.self,
                                                         from: data)
                    completion(model)
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
