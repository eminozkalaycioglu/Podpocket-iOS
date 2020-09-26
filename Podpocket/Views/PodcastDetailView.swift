//
//  PodcastDetailView.swift
//  Podpocket
//
//  Created by Emin on 20.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

@available(iOS 14.0, *)
struct PodcastDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var viewModel = PodcastDetailViewModel()
    @EnvironmentObject var aboutViewModel: AboutPodcastViewModel
    
    
    @State private var selectedSegment = 0
    @State var loading = false
    
    var id: String = ""
    
    init(id: String) {
        self.id = id
        UINavigationBar.appearance().barTintColor = UIColor.podpocketPurpleColor
        UISegmentedControl.appearance().backgroundColor = UIColor.podpocketPurpleColor
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.podpocketGreenColor], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    var body: some View {
        
        ZStack {
            Color.podpocketPurpleColor
            
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    
                    if let url = String.toEncodedURL(link: self.viewModel.getImageURL()) {
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    
                    Section(header: self.sectionHeaderView()) {
                        
                        switch self.selectedSegment {
                        case 0:
                            
                            if let podcast = self.viewModel.podcast {
                                
                                EpisodesListView(podcast: podcast)
                            }
                            else {
                                
                            }
                            
                            
                        case 1:
                            if let podcast = self.viewModel.podcast {
                                AboutPodcastView(rootPodcast: podcast)
                                    .environmentObject(self.aboutViewModel)
                            }
                            else {
                                
                            }
                        default:
                            Text("default")
                        }
                        
                    }
                }
            }
            
            
            if self.viewModel.loading || self.aboutViewModel.loading {
                CustomProgressView()
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                HStack {
                    self.backButton()
                    Image("Logo")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(UIScreen.main.bounds.size.width/4+30)
                    
                })
        .onAppear {
            self.viewModel.setId(id: self.id)
            
        }
    }
    
    func sectionHeaderView() -> AnyView {
        return AnyView(
            VStack(spacing: 0) {
                HStack {
                    Text(self.viewModel.getTitle())
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                    
                    Spacer()
                }.background(Color.podpocketGreenColor)
                
                
                Picker("", selection: self.$selectedSegment) {
                    Text("EPISODES")
                        .tag(0)
                    Text("DETAILS")
                        .tag(1)
                    
                }.shadow(radius: 10)
                .frame(height: 60)
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.podpocketPurpleColor)
                
                if self.selectedSegment == 0 {
                    HStack {
                        Spacer()
                        Text("\(self.viewModel.podcast?.totalEpisodes ?? 0) EPISODES")
                            .foregroundColor(Color.podpocketGreenColor)
                        Spacer()
                        
                    }.frame(height: 50)
                    .background(Color.podpocketPurpleColor)
                }
                
            }
            
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
                    .foregroundColor(Color.podpocketGreenColor)
                    .frame(width: 25, height: 25, alignment: .center)
            })
        )
    }
    
}

@available(iOS 14.0, *)
struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(id: "9392aab5fe0c4998ac9dcf35316ee760")
    }
}
