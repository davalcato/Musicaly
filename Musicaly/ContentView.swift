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
    
    
    var body: some View{
        
        VStack(spacing: 20){
            
            Image(uiImage: self.data.count == 0 ? UIImage(named: "Drake")! :
                    UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
            
            Text(self.title).font(.title).padding(.top)
            
        }.padding()
        .onAppear {
            self.getData()
            
        }
    }
    
    func getData(){
        
        let url = Bundle.main.path(forResource: "Can't", ofType: "mp3")
        let asset = AVAsset(url: URL(fileURLWithPath: url!))
        
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











