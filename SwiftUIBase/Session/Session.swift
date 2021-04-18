//
//  Session.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 21.03.2021.
//

import Foundation

class Session {
    static let instance = Session()
    
    var token: String
    var userId: Int
    
    private init (){
        token = ""
        userId = 0
    }
}
