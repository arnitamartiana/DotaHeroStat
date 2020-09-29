//
//  HeroStat.swift
//  DotaHeroStat
//
//  Created by Arnita Martiana on 24/09/20.
//  Copyright © 2020 Arnita Martiana. All rights reserved.
//

import Foundation

struct HeroStat : Decodable {
    var id : Int?
    var name : String?
    var localized_name: String?
    var primary_attr : String?
    var attack_type : String?
    var img :String?
    var icon: String?
    var base_health : Int?
    var base_attack_max :Int?
    var move_speed : Int?
    
    enum CodingKeys : String, CodingKey{
//        case id = "id"
        case name = "name"
        case localized_name = "localized_name"
        case primary_attr = "primary_attr"
        case attack_type = "attack_type"
        case img = "img"
        case icon = "icon"
    }
    
    
    
    
//    enum CodingKeys2 : Int, CodingKey{
//        case id = "id"
//    }
}

