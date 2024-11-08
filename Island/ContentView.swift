//
//  ContentView.swift
//  Island
//
//  Created by Jayant Sogikar on 30/10/24.
//

import SwiftUI

struct ContentView: View {
//    Dynamic Island width and height
    @State private var textoffset = 30
    
    let text = "This is a test of scrolling text.  This is only a test."
    @State private var go = false
    @State private var isHovered = false
    @State private var rotationDegrees = 0.0
    @State private var isTapped = false
    @StateObject var nowPlaying = SpotifyNowPlaying()
    var body: some View {
        ZStack(alignment: .top) {
            if isTapped {
                VStack(){
                    Spacer()
                    HStack(alignment: .center){
                        AsyncImage(url: URL(string: nowPlaying.imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.4)
                        }
                        .frame(width: 50, height: 50)
//                        .alignmentGuide(.leading) { d in d[.trailing] }
                        .clipShape(.rect(cornerRadius: 6)).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))
                        VStack(alignment: .leading){
                            Text("\(nowPlaying.songTitle)").font(.system(size: 12, weight: .regular, design: .default)).minimumScaleFactor(0.4)
                                .foregroundColor(.white)
                            Text("\(nowPlaying.artist)").font(.system(size: 8, weight: .regular, design: .default)).minimumScaleFactor(0.4)
                                .foregroundColor(.white)
                            HStack{
                                Button {
                                    nowPlaying.goToPrevSong()
                                } label: {
                                    Image("prev-new").resizable()
                                        .frame(width: 22, height: 22)
                                }.buttonStyle(PlainButtonStyle())
                                Spacer()
                                Button {
                                    nowPlaying.playPause()
                                    nowPlaying.getCurrentSong()
                                } label: {
                                    Image("pause-button").resizable()
                                        .frame(width: 22, height: 22)
                                }.buttonStyle(PlainButtonStyle())
                                Spacer()
                                Button {
                                    nowPlaying.goToNextSong()
                                    nowPlaying.getCurrentSong()
                                } label: {
                                    Image("next-new").resizable()
                                        .frame(width: 22, height: 22)
                                }.buttonStyle(PlainButtonStyle())
                            }.frame(width: 100)
                        }
                        Spacer()
                        
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
                .onHover { hovering in
                    withAnimation(.interactiveSpring(duration: 0.5)) {
                        isTapped = hovering
                    }
                }
                .frame(width: 300, height: 100)
                    .background(Color.black)
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 30,bottomTrailingRadius: 30))
//                    .shadow(radius: 10)
                
            }
            else if isHovered{
                
                HStack(alignment: .center){
                    AsyncImage(url: URL(string: nowPlaying.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.4)
                    }
                    .frame(width: 40, height: 40)
                    //                        .alignmentGuide(.leading) { d in d[.trailing] }
                    .clipShape(.rect(cornerRadius: 6)).padding(10)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        Text(text).font(.headline).foregroundColor(.white).lineLimit(1)
                    }
                    
                    
//
                    Spacer()
                    
//                    Image("music").resizable()
//                        .frame(width: 14, height: 14).padding(10).scaleEffect(rotationDegrees).onAppear{
//                            withAnimation(Animation.linear(duration: 0.1).speed(0.1)
//                                .repeatForever()){
//                                    rotationDegrees = 1.5
//                                }
//                        }
                }
                .background(Color.black)
                .frame(width: 300,height: 60,alignment: .top)
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 30,bottomTrailingRadius: 30))
                .onHover { hovering in
                    isHovered = hovering
                    rotationDegrees = 0
                }
                .gesture(TapGesture(count: 1).onEnded{
                    print("TAT")
                    isTapped = true
                })
            }
            else{
                VStack(){
                    Rectangle()
                        .frame(width: 60, height: 20)
                        .foregroundColor(.clear)
                        .background(.clear )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onHover { hovering in
                            withAnimation(.interactiveSpring(duration: 0.5)){
                                isHovered = hovering
                                rotationDegrees = 0
                            }
                        }
                    Spacer()
                }.frame(width: 300, height: 60)
                
            }
        }.background(.clear)
//        .frame(alignment: Alignment.top)
        
        .ignoresSafeArea(.all, edges: .all)
    }
}
#Preview {
    ContentView()
}
