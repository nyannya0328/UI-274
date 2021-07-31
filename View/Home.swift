//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/07/31.
//

import SwiftUI

struct Home: View {
    @StateObject var model = StoryViewModel()
    var body: some View {
        NavigationView{
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack{
                        
                        
                        Button {
                            
                        } label: {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .overlay(
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(width: 30, height: 30)
                                        .background(.blue,in: Circle())
                                        .padding(2)
                                        .background(.black,in:Circle())
                                
                                    ,alignment: .bottomTrailing
                                )
                            
                        }
                        .padding(.trailing,10)
                        
                        ForEach($model.stories){$story in
                            
                            
                            ProfileView(story: $story)
                                .environmentObject(model)
                            
                            
                            
                            
                        }

                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom,10)
                    
                    
                }
            }
            .navigationTitle("Insta")
        }
        .overlay(
        
        StoryView()
            .environmentObject(model)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
struct ProfileView : View{
    
    @Binding var story : StoryBundle
    @EnvironmentObject var model : StoryViewModel
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        
        Image(story.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(2)
            .background(scheme == .dark ? .black : .white,in: Circle())
            .padding(3)
            .background(
            
            LinearGradient(colors: [
                
                .red,
                .orange,
                .red,
                .orange
            
            
            
            ], startPoint: .top, endPoint: .bottom)
            
                .clipShape(Circle())
                .opacity(story.isSeen ? 0 : 1)
            )
            .onTapGesture {
                
                
                withAnimation{
                    
                    story.isSeen = true
                    
                    model.currentStory = story.id
                    
                    model.showStory = true
                }
            }
        
        
        
    }
}
