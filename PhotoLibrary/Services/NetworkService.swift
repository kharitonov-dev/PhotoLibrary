//
//  NetworkService.swift
//  PhotoLibrary
//
//  Created by Timofey Kharitonov on 02.02.2022.
//

import Foundation

class NetworkService {
     
    // Запрос данных по url
    func request(searchTerm: String, complition: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, complition: complition)
        task.resume()
    }
    
    // Добавляю Access Key из Unsplash
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID DO8akXyfl0zLxzZYrzWhRakijqkI7pt5syLT_nCsb0w"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1) // кол-во страниц
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https" // передаю тип какого запроса отправляю https, http
        components.host = "api.unsplash.com" // адрес сайта
        components.path = "/search/photos" // Путь до get-параметров
        
        // собираю get-пар-ры в соответствующий вид url-строки добавляя ?,& между пар-ми
        // через конструкцию .map
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
    // @escaping - помогает решить проблем, которая позволяет complition возвращать пар-ры
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Вызываем в main потоке
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
    
    
}
