//
//  Analysis.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/8.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Foundation

class Analysis: Codable
{
    var faces: [Facefeature]?

}

struct Facefeature: Codable
{
    var attributes: AnalysisAttributes
    
}

struct AnalysisAttributes: Codable
{
    var age: Int?
    var gender: String?
    var mask: Int?
}
