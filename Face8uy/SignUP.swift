//
//  SignUP.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/7.
//  Copyright © 2020 國維黃. All rights reserved.
//

import Foundation
struct  SignUP : Codable
{
    var data: SignUpData
}

struct  SignUpData: Codable
{
    var id: String?
    var password: String?
    var face_token:String?
    var name: String?
    var gender: String?
    var email: String?
    var shopping_cart:Array<String>?
}

