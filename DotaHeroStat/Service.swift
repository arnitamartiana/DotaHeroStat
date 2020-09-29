//
//  Service.swift
//  DotaHeroStat
//
//  Created by Arnita Martiana on 24/09/20.
//  Copyright © 2020 Arnita Martiana. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    typealias heroesCallback = (_ heroes : [Heroes]?, _ status:Bool, _ message :String) -> Void
    var callback : heroesCallback?
    fileprivate var baseUrl = ""
    
    init(baseUrl:String) {
        self.baseUrl = baseUrl
    }
    
    func getHeroStat(endPoint:String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding:URLEncoding.default , headers: nil, interceptor: nil).response{
                (responseData) in
                print("We got Data response")
            guard let data = responseData.data else{return}
                do{
                    let heroes = try JSONDecoder().decode([Heroes].self, from: data)
                    self.callback?(heroes,true,"")
        
                }catch{
                    print("Error man \(error)")
                    self.callback?(nil,false,error.localizedDescription)
                }
            }
    }
    
    func completionHandler(callback: @escaping heroesCallback){
        self.callback = callback
    }
}
