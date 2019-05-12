//
//  Pin.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import Foundation

struct PinURL: Codable {
    var raw:String
    var full:String
    var regular:String
    var small:String

}

struct Pin: Codable {
    var color:String
    var urls: PinURL
}
