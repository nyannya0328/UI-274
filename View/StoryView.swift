//
//  StoryView.swift
//  StoryView
//
//  Created by nyannyan0328 on 2021/07/31.
//

import SwiftUI

struct StoryView: View {
    @EnvironmentObject var model : StoryViewModel
    var body: some View {
        if model.showStory{
            
            TabView(selection:$model.currentStory){
                
                
                ForEach($model.stories){$story in
                    
                    
                    StoryCardView(Bundle: $story)
                        .environmentObject(model)
                }
                
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .transition(.move(edge: .bottom))
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StoryCardView : View{
    
    @Binding var Bundle : StoryBundle
    @EnvironmentObject var model : StoryViewModel
    
    @State var timer = Timer.publish(every:0.1, on: .main, in: .common).autoconnect()
    
    @State var timerProgress : CGFloat = 0
    
    var body: some View{
        
        
        GeometryReader{proxy in
            
            
            ZStack{
                
                
                let index = min(Int(timerProgress), Bundle.stories.count - 1)
                
                if let story = Bundle.stories[index]{
                
                
                Image(story.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                }
                    
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
            
                HStack{
                    
                    
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .onTapGesture {
                            
                            
                            if (timerProgress - 1) < 0 {
                                
                                
                                updateStory(forward: false)
                            }
                            
                            else{
                                
                                
                                timerProgress = CGFloat(Int(timerProgress - 1))
                                
                            }
                            
                            
                        }
                    
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .onTapGesture {
                            
                            if (timerProgress + 1) > CGFloat(Bundle.stories.count){
                                
                                
                                updateStory()
                            }
                            
                            else{
                                
                                
                                timerProgress = CGFloat(Int(timerProgress + 1))
                            }
                            
                            
                        }
                }
            
            )
            
            
            .overlay(
            
            
                HStack(spacing:15){
                    
                    
                    Image(Bundle.profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    
                    Text(Bundle.profileName)
                        .font(.title2.bold())
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    
                    
                    Button {
                        withAnimation{
                            
                            
                            model.showStory = false
                        }
                    } label: {
                        
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            
                           
                        
                    }
                    .padding()
                  

                    
                    
                }
                  .padding(.horizontal)
            
                ,alignment: .topTrailing
            )
            .overlay(
            
                
                HStack{
                    
                    ForEach(Bundle.stories.indices){index in
                        
                        GeometryReader{proxy in
                            
                            let width = proxy.size.width
                            
                            let progress = timerProgress - CGFloat(index)
                            
                            let perfectAngle = min(max(progress, 0), 1)
                            
                            Capsule()
                                .fill(.gray.opacity(0.5))
                                .overlay(
                                
                                Capsule()
                                    .fill(.white)
                                    .frame(width:width * perfectAngle)
                                
                                ,alignment: .leading
                                
                                )
                            
                        }
                        
                        
                    }
                }
                    .frame(height: 1.5)
                    .padding(.horizontal)
            
            
            
                ,alignment: .top
            )
            .rotation3DEffect(getAngel(proxy: proxy), axis: (x: 0, y: 1, z: 0), anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing, anchorZ: 1, perspective: 3)
            .onReceive(timer) { _ in
                
                
                if  model.currentStory == Bundle.id{
                    
                    if !Bundle.isSeen{
                        
                        Bundle.isSeen = true
                    }
                    
                    if timerProgress < CGFloat(Bundle.stories.count){
                        
                        if getAngel(proxy: proxy).degrees == 0{
                            
                            timerProgress += 0.03
                        }
                        
                        
                    }
                    
                    else{
                        
                        
                        updateStory()
                        
                        
                        
                    }
                    
        
                    
                    
                    
                    
                    
                    
                    
                }
                
            }
            
            
            
            
            
        }
        .onAppear {
            timerProgress = 0
        }
        
    }
    
    
    func updateStory(forward : Bool = true){
        
        
        let index = min(Int(timerProgress), Bundle.stories.count - 1)
        
        let story = Bundle.stories[index]
        
        
        
        if !forward{
            
            
            if let first = model.stories.first,first.id != story.id{
                
                let bundleIndex = model.stories.firstIndex { currentBandle in
                    
                    
                    return story.id == currentBandle.id
                    
                } ?? 0
                
                
                withAnimation{
                    
                    model.currentStory = model.stories[bundleIndex - 1].id
                    
                    
                }
                
                
                
                
            }
            
            else{
                
                
                timerProgress = 0
            }
            
            return
            
            
            
            
        }
        
        
        if let last = Bundle.stories.last,last.id == story.id{
            
            if let lastBundle = model.stories.last,lastBundle.id == Bundle.id{
                
                withAnimation{
                    
                    model.showStory = false
                }
                
                
                
            }
            
            else{
                
                
                let bundleIndex = model.stories.firstIndex { currentbundle in
                    
                    return story.id == currentbundle.id
                    
                
                } ?? 0
                
                
                withAnimation{
                    
                    
                    model.currentStory = model.stories[bundleIndex + 1].id
                }
                
            }
            
            
            
            
        }
      
      
        
        
       
        
      
        
    }
    
    func getAngel(proxy : GeometryProxy) -> Angle{
        
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        
        let rotationDegree : CGFloat = 45
        
        let degress =  progress * rotationDegree
        
        
        return Angle(degrees: Double(degress))
        
        
    }
    
}
