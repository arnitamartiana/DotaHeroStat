//
//  Heroes.swift
//  DotaHeroStat
//
//  Created by Arnita Martiana on 24/09/20.
//  Copyright © 2020 Arnita Martiana. All rights reserved.
//

import Foundation

struct Heroes: Decodable, Encodable {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let img: String
    let icon: String
    let base_health: Int
    let base_attack_min : Int
    let base_attack_max: Int
    let move_speed: Int
    let base_armor: Double
    let base_mana: Int
    let roles: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case name = "name"
    case localized_name = "localized_name"
    case primary_attr = "primary_attr"
    case attack_type = "attack_type"
    case img = "img"
    case icon = "icon"
    case base_health
    case base_attack_min
    case base_attack_max
    case move_speed
    case base_armor
    case base_mana
    case roles
  }
}
