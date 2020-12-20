//
//  Bus.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/10/10.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Foundation

class Bus: Codable
{
    var BusInfo: [Info]?

}

struct Info: Codable
{
    var StopID: Int?
    var RouteID: Int?
    var EstimateTime: String?
    var GoBack: String?
}
