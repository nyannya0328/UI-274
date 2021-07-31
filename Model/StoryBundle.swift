//
//  StoryBundle.swift
//  StoryBundle
//
//  Created by nyannyan0328 on 2021/07/31.
//

import SwiftUI

struct StoryBundle: Identifiable,Hashable {
    var id = UUID().uuidString
    var profileName : String
    var profileImage : String
    var isSeen : Bool = false
    var stories : [Story]
}


struct Story : Identifiable,Hashable{
    
    
    var id = UUID().uuidString
    var imageURL : String
}


