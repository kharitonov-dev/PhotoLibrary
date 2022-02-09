//
//  NetworkDataFetcher.swift
//  PhotoLibrary
//
//  Created by Timofey Kharitonov on 02.02.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            // Проверка на ошибки при поступлении данных
            if let error = error {
                print("Error data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    // Делаю через джинерики <T>, чтобы на вход принимала любую модель данных (универсальность)
    // Объект типа T.Type помогает принимать любой тип данных, главное, чтобы func была подписана под протокол Decodable
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
