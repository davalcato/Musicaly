//
//  ContentView.swift
//  Musicaly
//
//  Created by Daval Cato on 8/28/20.
//

import SwiftUI
import AVKit


struct ContentView: View {
    var body: some View {
        
        NavigationView{
            
            MusicPlayer().navigationTitle("Music Player")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MusicPlayer : View {
    
    @State var data : Data = .init(count: 0)
    @State var title = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    
    
    var body: some View{
        
        VStack(spacing: 20){
            
            Image(uiImage: self.data.count == 0 ? UIImage(named: "Drake")! :
                    UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            
            Text(self.title).font(.title).padding(.top)
            
            ZStack(alignment: .leading) {
                
                // here we fill in the capsule inicator
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                
                Capsule().fill(Color.red).frame(width: 200, height: 8)
            }
            
            .padding(.top)
            // add the forward and backwards button here
            
            // and place distance between the button icons
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30){
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "backward.fill").font(.title)
                }
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "gobackward.15").font(.title)
                }
                // here we toggle between play and pause
                Button(action: {
                    
                    if self.player.isPlaying{
                        
                        self.player.pause()
                        self.playing = false
                    }
                    else{
                        
                        self.player.play()
                        self.playing = true
                        
                    }
                    
                }) {
                    
                    Image(systemName: self.playing ? "pause.fill" :
                            "play.fill").font(.title)
                }
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "goforward.15").font(.title)
                }
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "forward.fill").font(.title)
                }
                
            }.padding(.top,25)
            
            // icon buttons here...
            .foregroundColor(.black)
            
        }.padding()
        .onAppear {
            
            let url = Bundle.main.path(forResource: "Elevate", ofType: "mp3")
            
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            
            // prepare the player to player here...
            self.player.prepareToPlay()
            self.getData()
            
        }
    }
    
    func getData(){
        
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artwork"{
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title"{
                
                let title = i.value as! String
                self.title = title
            }
        }
    }
}











