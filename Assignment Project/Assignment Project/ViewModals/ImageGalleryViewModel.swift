//
//  ViewModal.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//
import Foundation

// MARK: - ImageGalleryViewModel


import Foundation

class ImageGalleryViewModel {
    
    var images: [ImageData] = []
    
    var onUpdate: (() -> Void)?
    
    // Function to fetch images based on the search query
    func fetchImages(query: String = "food") async {
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=CNnZ3VbcQZ6BKlUMBGbxJG9uml5B8foZv1g_cP7KH0g"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(ImageResponse.self, from: data)
            var uniqueImageIDs = Set<String>()
            var uniqueImages = [ImageData]()
            
            for image in result.results {
                if !uniqueImageIDs.contains(image.id) {
                    uniqueImageIDs.insert(image.id)
                    uniqueImages.append(image)
                }
            }
            
            self.images = uniqueImages
            DispatchQueue.main.async {
                self.onUpdate?()
            }
        } catch {
            print("Error fetching or decoding data: \(error)")
        }
    }
}
