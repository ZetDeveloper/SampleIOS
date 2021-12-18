//
//  ApiClient.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import Foundation
import Combine

class ApiClient {
    
    func getRequest() -> URLRequest {
        let url = URLRequest(url: URL(string: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
                                        .addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!)
        return url
    }
    
    func getChart() -> Future<RootChart, Never> {
        
        return Future { [self] promise in
            
            URLSession.shared.dataTask(with: getRequest(), completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(RootChart.self, from: data)
                        
                        promise(.success(response))
                    } catch {
                        promise(.success(RootChart(colors: [], questions: [])))
                    }
                } else {
                    promise(.success(RootChart(colors: [], questions: [])))
                }
            }).resume()
        }
    }
}
