//
//  User.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 08.02.2021.
//

import Foundation

struct User: Equatable, Comparable {
    var name: String
    var surname: String
    var avatar: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.surname < rhs.surname
    }
}
