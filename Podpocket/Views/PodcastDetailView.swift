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
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UITableView.appearance().backgroundColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UISegmentedControl.appearance().backgroundColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor().hexStringToUIColor(hex: Color.podpocketGreenColor)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    var body: some View {
        
        ZStack {
            Color.init(hex: Color.podpocketPurpleColor)

            List {
                
                if let url = String.toEncodedURL(link: self.viewModel.getImageURL()) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .listRowInsets(EdgeInsets())
                }
                
                
                Section(header:
                            VStack(spacing: 0) {
                                HStack {
                                    Text(self.viewModel.getTitle())
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding()
                                    
                                    Spacer()
                                }.background(Color.init(hex: Color.podpocketGreenColor)).listRowInsets(EdgeInsets())
                                
                                
                                Picker("", selection: self.$selectedSegment) {
                                    Text("EPISODES")
                                        .tag(0)
                                    Text("DETAILS")
                                        .tag(1)
                                    
                                }.shadow(radius: 10)
                                
                                
                                .frame(height: 60)
                                .pickerStyle(SegmentedPickerStyle())
                                
                                .background(Color.init(hex: "2C2838"))
                                
                                if self.selectedSegment == 0 {
                                    HStack {
                                        Spacer()
                                        Text("\(self.viewModel.podcast?.totalEpisodes ?? 0) episodes")
                                            .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                        Spacer()
                                        
                                    }.frame(height: 50).background(Color.init(hex: Color.podpocketPurpleColor))
                                }
                                
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                )
                {
                    
                    switch self.selectedSegment {
                    case 0:
                        
                        if let podcast = self.viewModel.podcast {
                            
                            EpisodesListView(podcast: podcast)
                                .listRowInsets(EdgeInsets())
                        }
                        else {
                            
                        }
                        
                        
                    case 1:
                        if let podcast = self.viewModel.podcast {
                            AboutPodcastView(rootPodcast: podcast)
                                .environmentObject(self.aboutViewModel)
                                .listRowInsets(EdgeInsets())
                        }
                        else {
                            
                        }
                    default:
                        Text("default")
                    }
                    
                }
                
            }

            if self.viewModel.loading || self.aboutViewModel.loading {
                CustomProgressView()

            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onAppear {
            self.viewModel.setId(id: self.id)

        }
    }
    
    
}

@available(iOS 14.0, *)
struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(id: "9392aab5fe0c4998ac9dcf35316ee760")
    }
}
