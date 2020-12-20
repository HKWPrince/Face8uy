//
//  Login.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/8.
//  Copyright © 2020 國維黃. All rights reserved.
//

import Foundation
struct Login: Codable
{
    var data: LoginData
}

struct LoginData: Codable
{
    var id: String?
    var token: String?
}

