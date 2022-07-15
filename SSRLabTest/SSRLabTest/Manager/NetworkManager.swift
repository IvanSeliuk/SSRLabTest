//
//  NetworkManager.swift
//  SSRLabTest
//
//  Created by Иван Селюк on 14.07.22.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func getData(onCompletion: @escaping (JsonModel) -> (),
                 onError: ((String?) -> ())?) {
        
        guard let url = API.map.url else { return }
        AF.request(url).responseDecodable(of: JsonModel.self) { response in
            switch response.result {
            case .success(let model):
                DispatchQueue.main.async {
                    onCompletion(model)
                }
            case .failure(let error):
                onError?(error.localizedDescription)
            }
        }
    }
}
