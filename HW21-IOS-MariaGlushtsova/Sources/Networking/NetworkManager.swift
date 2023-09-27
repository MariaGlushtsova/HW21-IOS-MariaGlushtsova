//
//  NetworkManager.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let urlCharacterComics = "https://gateway.marvel.com/v1/public/characters/1009378/comics?ts=1&apikey=17f5b878ef1fe2f49a005a90a9967aa9&hash=fa3a74f0e4fcd5aecc20f1516bc66ed4"
    
    func fetchSeries(url: String, completion: @escaping (Result<MarvelData, Error>) -> Void) {
        let request = AF.request(url)
        request.responseDecodable(of: MarvelData.self) { data in
            switch data.result {
            case .success(let results):
                completion(.success(results))
            case .failure(let error):
                print("Failed to parse JSON:", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func fetchImageForCell(urlImage: URL, completion: @escaping (Data) -> Void) {
        let request = AF.request(urlImage)
        request.responseData { data in
            guard let imageData = data.value else { return }
            completion(imageData)
        }
    }
}
