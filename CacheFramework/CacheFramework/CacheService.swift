//
//  CacheService.swift
//  CacheFramework
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit

public class CacheService{
    public static let shared = CacheService()
    public func fetchData<A: Codable>(forUrl url: String, completion: @escaping (A) -> Void, error: ((String) -> ())? ){
        CacheLibrary.shared.loadData(fromUrl: url, completion: { (data) in
            do{
                let objects = try JSONDecoder().decode(A.self, from: data)
                completion(objects)
            }catch let jsonErr{
                print("Failed to decode json:", jsonErr)
                error?("Failed to decode json: \(jsonErr)")
            }
        }) { (err) in
            error?(err)
        }
    }
}
