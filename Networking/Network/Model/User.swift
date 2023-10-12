//
//  User.swift
//  Networking
//
//  Created by Bairon Yeferson Imbacuan Yandun on 6/10/23.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int?
    let name : String?
    let email : String?
    let gender: String?
    let status: String?
}

