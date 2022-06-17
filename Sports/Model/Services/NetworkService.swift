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
            
            // Create url of the input string
            guard let url = URL(string: urlStr) else { return }
            
            // Create request and session
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // Create data task
            let task = session.dataTask(with: request) { (data, response, error) in
                
                guard let data = data else {
                    return
                }
                
                // JSON Decoding
                do {
                    // Set the result to the decoded JSON response
                    let result = try JSONDecoder().decode(T.self, from: data)
                    // Callback with the result
                    callBack(result)
                
                // DebugPrint Error and return nil in case of exception
                }catch{
                    debugPrint(error)
                    callBack(nil)
                }
            }
            // Start/Resume the suspended data task
            task.resume()
        }
}
