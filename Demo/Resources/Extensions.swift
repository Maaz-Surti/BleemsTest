//
//  Extensions.swift
//  Demo
//
//  Created by RCD on 23/11/2022.
//

import Foundation
import UIKit

extension URLSession {
    
    enum CustomError: Error {
        
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable> (
        
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            guard let url = url else {
                completion(.failure(CustomError.invalidUrl))
                return
            }
            
            let task = dataTask(with: url) { data, _, error in
                
                guard let data = data else {
                    
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    
                    return
                }
                
                do {
                    
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
                    
                } catch {
                    
                    completion(.failure(error))
                    
                }
            }
            
            task.resume()
        }
    
    
}

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }

    public var height: CGFloat{
        return frame.size.height
    }

    public var top: CGFloat{
        return frame.origin.y
    }

    public var bottom: CGFloat{
        return frame.size.height + frame.origin.y
    }

    public var left: CGFloat{
        return frame.origin.x
    }

    public var right: CGFloat{
        return frame.size.width + frame.origin.x
    }

    
}

extension UIImageView{
    
    func downloadImage(_ url: String) {
        
        if let url = URL(string: url) {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
    
}

