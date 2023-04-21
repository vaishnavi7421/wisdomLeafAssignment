//
//  DataFile.swift
//  WisdomLeafAssignment
//
//  Created by Pranav Dhomne on 18/04/23.
//

import Foundation

struct HeroStats: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    let name: String
    let roles: [String]
}
