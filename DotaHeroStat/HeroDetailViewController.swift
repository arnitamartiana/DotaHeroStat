//
//  HeroDetailViewController.swift
//  DotaHeroStat
//
//  Created by Arnita Martiana on 25/09/20.
//  Copyright © 2020 Arnita Martiana. All rights reserved.
//

import UIKit
import SDWebImage

class HeroDetailViewController: UIViewController {
    
    var selectedIndex = 0
    var heroName : String = ""
    var heroImg : String = ""
    var heroImg1 : String = ""
    var heroImg2 : String = ""
    var heroImg3 : String = ""
    var speed : Int = 0
    var armor : Double = 0.0
    var health : Int = 0
    var mana : Int = 0
    var attackMin : Int = 0
    var attackMax : Int = 0
    var attribute : String = ""
    var roles = [String]()
    var filteredHeroes = [Heroes]()

    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!
    @IBOutlet weak var lblHeroRole: UILabel!
    @IBOutlet weak var lblBaseHealth: UILabel!
    @IBOutlet weak var lblAttribute: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblAttack: UILabel!
    @IBOutlet weak var lblArmor: UILabel!
    @IBOutlet weak var lblMana: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        
        lblHeroName.text = heroName
        let completeURL = "https://api.opendota.com" + heroImg
        let baseURL = "https://api.opendota.com"
        imageHero.sd_setImage(with: URL(string: completeURL), completed: nil)
        img1.sd_setImage(with: URL(string: baseURL+heroImg1), completed: nil)
        img2.sd_setImage(with: URL(string: baseURL+heroImg2), completed: nil)
        img3.sd_setImage(with: URL(string: baseURL+heroImg3), completed: nil)
        lblMana.text = String(mana)
        lblArmor.text = String(armor)
        lblSpeed.text = String(speed)
        lblAttack.text = String(attackMin) + "-" + String(attackMax)
        lblAttribute.text = attribute
        lblBaseHealth.text = String(health)
        let string = roles.joined(separator: ",")
        let rolesString = "Role : \(string)"
        lblHeroRole.text = rolesString
    }
}
