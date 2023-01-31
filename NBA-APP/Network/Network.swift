//
//  Network.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI
import Foundation

struct ApiResponse {
    var isSuccess : Bool = false
    var returnedData : Any = {}
}

class Network: ObservableObject {
    let API_URL = "https://api-nba-v1.p.rapidapi.com"
    
    func getUrlRequestObject(_ pathname: String) -> URLRequest {
        guard let url = URL(string: API_URL + "\(pathname)") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
            urlRequest.setValue("abbdf8f6aamsh109476df4d902a9p165517jsn1f70d6610950", forHTTPHeaderField: "X-RapidAPI-Key")

        return urlRequest
    }
    
    func callApi(urlRequest: URLRequest) async throws -> Data {
        let (_data, _response) = try await URLSession.shared.data(for: urlRequest)
        
        let response = _response as? HTTPURLResponse
        if response?.statusCode != 200 { fatalError("An error has ocurred while fetching API. Error: \(String(describing: response))") }
        
        let decodedData = try JSONDecoder().decode(ApiBaseResponse.self, from: _data)
        guard decodedData.errors.count == 0 else {
            fatalError("An error has ocurred while decoding API response: \(decodedData.errors)")
        }
        let serializedResponse = try JSONEncoder().encode(decodedData.response)

        return serializedResponse;
    }

    func getGames(date: String, live: Bool = false) async -> [LiveGame] {
        var finalResponse: [LiveGame] = []
        var urlRequest = getUrlRequestObject("/games")
        var urlQueryItems: [URLQueryItem] = []
        
        if (!date.isEmpty) { urlQueryItems.append(URLQueryItem(name: "date", value: date)) }
        if (live && date.isEmpty) { urlQueryItems.append(URLQueryItem(name: "live", value: String(live))) }
        
        urlRequest.url?.append(queryItems: urlQueryItems)
        
        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest)
            
            guard let apiResponse = apiResponse else {
                return []
            }
            
            let decodedApiResponse = try JSONDecoder().decode([LiveGame].self, from: apiResponse)
            
            finalResponse = decodedApiResponse
            
        } catch {
            print("Error", error)
        }
        
        return finalResponse
    }
}


//    func callApi(urlRequest: URLRequest, completion: @escaping (ApiResponse?) -> ()) {
//        var apiResponse = ApiResponse()
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            print(response.statusCode)
//
//            if response.statusCode == 200 {
//                guard let data = data else {
//                    completion(nil)
//                    return
//                }
//                print("*******")
//                DispatchQueue.main.async {
//                    do {
//                        let decodedData = try JSONDecoder().decode(ApiBaseResponse.self, from: data)
//                        guard decodedData.errors.count == 0 else {
//                            completion(nil)
//                            return
//                        }
//                        apiResponse.returnedData = decodedData.response
//                        apiResponse.isSuccess = true
//                        completion(apiResponse)
//                    } catch let error {
//                        print("Error decoding: ", error)
//                        completion(nil)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//    }
