//
//  PlayerView.swift
//  Podpocket
//
//  Created by Emin on 19.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage


@available(iOS 14.0, *)
struct PlayerView: View {
    @State private var go = false
    @State var isPlaying: Bool = true
    @State var isFavorited: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var text = ""
    var episode: Episode
    var parentPodcastId: String
    
    init(episode: Episode, parentPodcastId: String) {
        self.episode = episode
        self.parentPodcastId = parentPodcastId
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
    }
    var body: some View {
        
        ZStack(alignment: .top){
            NavigationView {
                
                GeometryReader { geometry in

                    ZStack {
                        Color.init(hex: Color.podpocketPurpleColor)
                            .edgesIgnoringSafeArea(.all)
                        VStack(spacing: 0) {
                            
                            ZStack(alignment: .top) {
                                ZStack(alignment: .bottom) {
                                    
                                    if let url = String.toEncodedURL(link: self.episode.image ?? "") {
                                        KFImage(url)
                                            .resizable()

                                            .frame(height: geometry.size.height/2)


                                    }


                                    VStack {

                                        HStack {
                                            Text(self.isPlaying ? "NOW PLAYING" : "PAUSED")
                                                .font(.system(size: 12))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                                .padding(5)
                                                .padding(.leading, 20)
                                                .background(Color.gray).opacity(0.7)
                                                .cornerRadius(15)
                                                .offset(x: -15.0, y: 0.0)

                                            Spacer()

                                        }.padding(.vertical)
                                        HStack {
                                            Image("playingEpisode")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .padding(.leading)
                                            Spacer()



                                            MarqueeText(text: self.episode.title ?? "")

                                                .foregroundColor(.white)
                                                .frame(height: 30)
                                                .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))

                                            Spacer()
                                            Button(action: {

                                            }, label: {
                                                Image("showEpisodes").resizable().frame(width: 40, height: 40, alignment: .center)
                                            }).padding(.trailing)
                                        }
                                        HStack {
                                            Text("Podcast Name").foregroundColor(.gray)
                                            Spacer()
                                        }

                                    }
                                    .background(LinearGradient(gradient: Gradient(colors: [.clear,Color.init(hex: Color.podpocketPurpleColor).opacity(0.7), Color.init(hex: Color.podpocketPurpleColor)]), startPoint: .top, endPoint: .bottom))



                                }
                               

                            }
                            
                            HStack {
                                Button(action: {
                                    
                                }, label: {
                                    Image("previousEpisode")
                                    
                                }).padding(.trailing)
                                
                                Button(action: {
                                    withAnimation {
                                        self.isPlaying.toggle()

                                    }
                                }, label: {
                                    Image(self.isPlaying ? "pauseButton" : "playButton")
                                            .resizable()
                                            .frame(width: 60, height: 60, alignment: .center)
                                    
                                })
                                Button(action: {
                                    
                                }, label: {
                                    Image("nextEpisode")
                                            
                                    
                                }).padding(.leading)
                                
                            }.padding(.top, 40)
                            
                            Spacer()
                        }
                    }
                    
                }
                .navigationBarTitle("",displayMode: .inline)
                .navigationBarItems(leading: self.backButton(), trailing: self.favButton())
            }
            HStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 35, height: 35)
                    
                
            }
        }.navigationBarTitle("").navigationBarHidden(true)
    
        
    }
    
    func favButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.isFavorited.toggle()
            }, label: {
                Image(systemName: self.isFavorited ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                    
                    .frame(width: 22, height: 20, alignment: .center)

            })
        )
    }
    
    func backButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("back")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                    .frame(width: 25, height: 25, alignment: .center)
            })
        )
    }
}

@available(iOS 14.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(episode: Episode(image: "https://cdn-images-1.listennotes.com/podcasts/how-i-built-this/how-i-built-resilience-lognAd_7xj2-2BPVCen5Ip-.300x168.jpg"), parentPodcastId: "")
    }
    
    
}



struct MarqueeText : View {
    @State var text = ""
    @State private var animate = false
    private let animationOne = Animation.linear(duration: 8).delay(0.2).repeatForever(autoreverses: false)
    
    var body : some View {
        
        let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 20))
        return ZStack {
            GeometryReader { geometry in
                Text(self.text).lineLimit(1)
                    .font(.system(size: 20))
                    .offset(x: self.animate ? -stringWidth * 2 : 0)
                    .animation(self.animationOne)
                    .onAppear() {
                        if geometry.size.width < stringWidth {
                            self.animate = true
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                
                Text(self.text).lineLimit(1)
                    .font(.system(size: 20))
                    .offset(x: self.animate ? 0 : stringWidth * 2)
                    .animation(self.animationOne)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

