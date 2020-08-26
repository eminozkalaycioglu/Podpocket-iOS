//
//  PodcastDetailView.swift
//  Podpocket
//
//  Created by Emin on 20.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PodcastDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = PodcastDetailViewModel()
    @State private var selectedSegment = 0
    
    var data = 0...10
    init(id: String) {
        self.viewModel.setId(id: id)
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UITableView.appearance().backgroundColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UISegmentedControl.appearance().backgroundColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
        UISegmentedControl.appearance().selectedSegmentTintColor = .clear
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor().hexStringToUIColor(hex: Color.podpocketGreenColor)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    var body: some View {
        
        if #available(iOS 14.0, *) {
            ZStack {
                List {
                    
                    if let encoded = (self.viewModel.getImageURL()).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
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
                                        
                                    }
                                    
                                    
                                    .frame(height: 60)
                                    .pickerStyle(SegmentedPickerStyle())
                                    
                                    .background(Color.init(hex: "2C2838"))
                                    
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    )
                    {
                        
                        switch self.selectedSegment {
                        case 0:
                            Text("Episodes")
                        case 1:
                            if let podcast = self.viewModel.podcast {
                                AboutPodcastView(rootPodcast: podcast)
                                    .listRowInsets(EdgeInsets())
                            }
                            else {
                                
                            }
                            
                            
                        default:
                            Text("default")
                        }
                        
                    }
                }
                
                
                if self.viewModel.loading {
                    CustomProgressView()
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
        }
    }
}

struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(id: "9392aab5fe0c4998ac9dcf35316ee760")
    }
}
