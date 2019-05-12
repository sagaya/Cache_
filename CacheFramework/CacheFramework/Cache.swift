//
//  Cache.swift
//  CacheFramework
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit

public class CacheLibrary {
    public typealias DidDataFinishLoad = ((Data) -> ())
    public typealias DataLoadFailed = ((String) -> ())
    public static let shared = CacheLibrary()
    var memorySize:Int?
    public func loadData(fromUrl url:String, completion: @escaping DidDataFinishLoad, error: DataLoadFailed?){
        guard let resourceUrl = URL(string: url) else {return}
//        let cacheSizeMegabytes = 30
        let cache  = URLCache.shared
        let request = URLRequest(url: resourceUrl)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }else{
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, err) in
                    if let err = err{
                        error?(err.localizedDescription)
                    }else{
                        if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300{
                            let cacheData = CachedURLResponse(response: response, data: data)
                            cache.storeCachedResponse(cacheData, for: request)
                            DispatchQueue.main.async {
                                completion(data)
                            }
                        }else{
                            error?("Unable to load resource \(url)")
                        }
                    }
                }).resume()
            }
        }
    }
}
