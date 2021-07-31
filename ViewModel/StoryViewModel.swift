//
//  StoryViewModel.swift
//  StoryViewModel
//
//  Created by nyannyan0328 on 2021/07/31.
//

import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var showStory : Bool = false
    
    @Published var currentStory : String = ""
    
    @Published var stories : [StoryBundle] = [
    
        
        StoryBundle(profileName: "Erica", profileImage: "pic1", stories: [
            
            
            Story(imageURL: "p1"),
            Story(imageURL: "p2"),
            Story(imageURL: "p3"),
        
        
        
        
        ]),
        
        
        StoryBundle(profileName: "Emma", profileImage: "pic2", stories: [
        
            Story(imageURL: "p4"),
            Story(imageURL: "p5"),
            Story(imageURL: "p6"),
        
        
        ]),
    
    
    ]
    
}

