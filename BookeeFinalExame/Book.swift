//
//  Book.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import Foundation

class Book {
    var name: String?
    var shopAddress: String?
    var shopPhoneNum: Int?
    var shopWebSite: String?
    var introduction: String?
    var imageName: String?
    
    init(name: String, shopAddress: String, shopPhoneNum: Int, shopWebSite: String, introduction: String, imageName: String) {
        self.name = name
        self.shopAddress = shopAddress
        self.shopPhoneNum = shopPhoneNum
        self.shopWebSite = shopWebSite
        self.introduction = introduction
        self.imageName = imageName
    }
}
