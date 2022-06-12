//
//  NetworkService.swift
//  Sports
//
//  Created by Abdollah Bakr on 06/06/2022.
//

import Foundation

class NetworkService {
    
    // Fetch decadable generic entity from the API
    static func fetchDecodableFromAPI<T: Decodable>(
        genericType: T.Type,
        urlStr: String ,
        callBack: @escaping (T?) -> Void) {
            
            guard let url = URL(string: urlStr) else { return }
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {
                    return
                }
                print("data has arrived successfully")
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    callBack(result)
                    
                }catch{
                    print(error)
                    callBack(nil)
                }
            }
            task.resume()
        }
}
