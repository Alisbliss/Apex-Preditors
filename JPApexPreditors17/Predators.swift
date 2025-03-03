//
//  Predators.swift
//  JPApexPreditors17
//
//  Created by Алеся Афанасенкова on 22.08.2024.
//

import Foundation

class Predators {
    
    var allApexPreditors: [ApexPreditor] = []
    var apexPreditors: [ApexPreditor] = []
    
    init() {
      decodeApexPreditorData()
    }
    
    func decodeApexPreditorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
             let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPreditors = try decoder.decode([ApexPreditor].self, from: data)
                apexPreditors = allApexPreditors
            } catch {
                print("Error deciding json data: \(error)")
            }
        }
        
    }
    func search(for searchTearm: String) -> [ApexPreditor] {
        if searchTearm.isEmpty {
            return apexPreditors
        } else {
            return apexPreditors.filter {
                preditor in preditor.name.localizedCaseInsensitiveContains(searchTearm)
                
            }
        }
    }
    func sort(by alphabetical: Bool) {
        apexPreditors.sort { preditor1, preditor2 in
            if alphabetical {
                preditor1.name < preditor2.name
            } else {
                preditor1.id < preditor2.id
            }
        }
    }
    func filter(by type: PreditorType) {
        if type == .all {
            apexPreditors = allApexPreditors
        } else {
            apexPreditors = allApexPreditors.filter { preditor in
                preditor.type == type
            }
        }
    }
}
