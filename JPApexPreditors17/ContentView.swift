//
//  ContentView.swift
//  JPApexPreditors17
//
//  Created by Алеся Афанасенкова on 21.08.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PreditorType.all
    
    let predetors = Predators()
   
    
    var filteredDinos: [ApexPreditor] {
        predetors.filter(by: currentSelection)
        predetors.sort(by: alphabetical)
       
        return predetors.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) {
                predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                    
                } label: {
                    HStack {
                        // dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5 )
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predetors")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { withAnimation {
                        alphabetical.toggle()
                    }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(PreditorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
               .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
