//
//  ViewController.swift
//  DotaHeroStat
//
//  Created by Arnita Martiana on 24/09/20.
//  Copyright © 2020 Arnita Martiana. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var heroes = [Heroes]()
    var heroes2 = [Heroes]()
    var heroName : String = ""
    var img1 : String = ""
    var img2 : String = ""
    var img3 : String = ""
    var rolesArray = [String]()
    let button = UIButton(type: .system)
    var btnArray : [String] = []
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var heroCollectionVoiew: UICollectionView!
    @IBOutlet weak var buttonsStack: UIStackView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "All"
        heroCollectionVoiew.dataSource = self
        heroCollectionVoiew.delegate = self
        
        heroCollectionVoiew.register(UINib.init(nibName: "HeroesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeroesCollectionViewCell")
        
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("testttt")
    }
    
    func getData(){
        let service = Service(baseUrl: "https://api.opendota.com")
        service.getHeroStat(endPoint: "/api/herostats")
        service.completionHandler{ [weak self] (heroes, status, message ) in
            if status{
                guard let self = self else {return}
                guard let _heroes = heroes else {return}
                self.heroes = _heroes
                self.heroes2 = _heroes
                
                self.heroCollectionVoiew.reloadData()
                
                self.getRoles()
                
            }
        }
    }
    
    func getRoles() {
        self.rolesArray.removeAll()
        self.rolesArray.append("All")
        for hero in self.heroes {
            let roles = hero.roles
            self.rolesArray.append(contentsOf: roles)
        }
        self.rolesArray = self.rolesArray.removeDuplicates()
        self.buildButtons()
        
    }
    
    func buildButtons(){
    
        var count = 0
        
        var buttonY: CGFloat = 20  // our Starting Offset, could be 0
        for role in rolesArray {
            count += 1
            
            let btn = UIButton(frame: CGRect(x: 5, y: buttonY, width: 90, height: 30))
            buttonY = buttonY + 50  // we are going to space these UIButtons 50px apart
            
            btn.tag = count
            btn.layer.cornerRadius = 10  // get some fancy pantsy rounding
            btn.backgroundColor = .black
            btn.setTitle(role, for: .normal) // We are going to use the item name as the Button Title here.
            btn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            
            self.filterView.addSubview(btn)  // myView in this case is the view you want these buttons added
            }
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        heroes = heroes2
        self.title = sender.titleLabel?.text
        if sender.titleLabel?.text == "All"{
            heroes = heroes2
            heroCollectionVoiew.reloadData()
        }else{
            var heroHasil = heroes.filter { $0.roles.contains((sender.titleLabel?.text)!) }
            heroes = heroHasil
            heroCollectionVoiew.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as! HeroesCollectionViewCell
        let hero = heroes [indexPath.row]
        cell.name?.text = hero.localized_name
        let imageURL = ("https://api.opendota.com\(hero.img)")
        cell.image.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "image-file"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.width/3) - 20, height: collectionView.frame.width/3)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HeroDetailViewController") as! HeroDetailViewController
        controller.selectedIndex = indexPath.row //pass selected cell index to next view.
        let hero = heroes [indexPath.row]
        controller.heroName = hero.localized_name
        controller.heroImg = hero.img
        controller.armor = hero.base_armor
        controller.attackMin = hero.base_attack_min
        controller.attackMax = hero.base_attack_max
        controller.attribute = hero.primary_attr
        controller.health = hero.base_health
        controller.mana = hero.base_mana
        controller.speed = hero.move_speed
        controller.roles = hero.roles
        
        if (hero.primary_attr == "agi"){
            var foo = heroes.filter {$0.primary_attr == "agi"}
            foo.sort { $0.move_speed > $1.move_speed }
            
            let filteredHero = foo.prefix(upTo: 3)
            img1 = filteredHero[0].img
            img2 = filteredHero[1].img
            img3 = filteredHero[2].img
        }else if (hero.primary_attr == "str"){
            var foo = heroes.filter {$0.primary_attr == "str"}
            foo.sort { $0.move_speed > $1.move_speed }
            
            let filteredHero = foo.prefix(upTo: 3)
            img1 = filteredHero[0].img
            img2 = filteredHero[1].img
            img3 = filteredHero[2].img
        }else{
            var foo = heroes.filter {$0.primary_attr == "int"}
            foo.sort { $0.move_speed > $1.move_speed }
            
            let filteredHero = foo.prefix(upTo: 3)
            img1 = filteredHero[0].img
            img2 = filteredHero[1].img
            img3 = filteredHero[2].img
        }
        controller.heroImg1 = img1
        controller.heroImg2 = img2
        controller.heroImg3 = img3
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    


}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
