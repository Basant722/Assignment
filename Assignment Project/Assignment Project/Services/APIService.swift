//
//  APIService.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//
import Foundation

class APIService {
    func fetchImages(query: String, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=CNnZ3VbcQZ6BKlUMBGbxJG9uml5B8foZv1g_cP7KH0g"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ImageResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

