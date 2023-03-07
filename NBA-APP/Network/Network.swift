//
//  Network.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI
import Foundation

class Network: ObservableObject {
    let API_URL = "https://api-nba-v1.p.rapidapi.com"
    let API_URL_SPORTSIO = "https://api.sportsdata.io/v3/nba/scores/json"
    
    func getUrlRequestObject(_ pathname: String, sportsIoApi: Bool = false) -> URLRequest {
        guard let url = URL(string: sportsIoApi ? API_URL_SPORTSIO + "\(pathname)" : API_URL + "\(pathname)") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        if (sportsIoApi) {
            if let apiKey = ProcessInfo.processInfo.environment["SPORTS_API_KEY"] {
                urlRequest.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            }
        } else {
            if let apiKey = ProcessInfo.processInfo.environment["RAPID_API_KEY"] {
                urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            }
        }

        return urlRequest
    }
    
    func callApi(urlRequest: URLRequest, sportsIoApi: Bool = false) async throws -> Data {
        let (_data, _response) = try await URLSession.shared.data(for: urlRequest)
        let response = _response as? HTTPURLResponse
        
        if response?.statusCode != 200 { fatalError("An error has ocurred while fetching API. Error: \(String(describing: response))") }
        
        if (!sportsIoApi) {
            let decodedData = try JSONDecoder().decode(ApiBaseResponse.self, from: _data)
            
            guard !sportsIoApi && decodedData.errors.count == 0 else {
                fatalError("An error has ocurred while decoding API response: \(decodedData.errors)")
            }
            
            let serializedResponse = try JSONEncoder().encode(decodedData.response)
            
            return serializedResponse
        }
        
        return _data
    }

    func getGames(date: String, live: Bool = false) async -> [LiveGame] {
        var games: [LiveGame] = []
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
            
            games = decodedApiResponse
            
        } catch {
            print("Error", error)
        }
        
        return games
    }
    
    func getGamePerId(gameId: Int) async -> [LiveGame] {
        var game: [LiveGame] = []
        var urlRequest = getUrlRequestObject("/games")
        var urlQueryItems: [URLQueryItem] = []
            urlQueryItems.append(URLQueryItem(name: "id", value: "\(gameId)"))
        
        urlRequest.url?.append(queryItems: urlQueryItems)
        
        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest)
            
            guard let apiResponse = apiResponse else {
                return []
            }
            
            let decodedApiResponse = try JSONDecoder().decode([LiveGame].self, from: apiResponse)
            game = decodedApiResponse
            
        } catch {
            print("Error: ", error)
        }
        
        return game
    }
    
    func getLastWeekHistoryGames() async -> [LiveGame] {
        var games: [LiveGame] = []
        let dates = Date().getDates(forLastNDays: 2)

        await withTaskGroup(of: [LiveGame].self) { group in
            for date in dates {
                group.addTask {
                    let gamesPerDate = await self.getGames(date: date)
                    return gamesPerDate
                }
            }
            for await gamesPerDate in group {
                for game in gamesPerDate { games.append(game) }
            }
        }

        return games
    }
    
    func getGameStats(gameId: Int) async -> [GameStats] {
        var gameStats: [GameStats] = []
        var urlRequest = getUrlRequestObject("/games/statistics")
            urlRequest.url?.append(queryItems: [URLQueryItem(name: "id", value: "\(gameId)")])
        
        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest)
            
            guard let apiResponse = apiResponse else {
                return []
            }
            
            let decodedApiResponse = try JSONDecoder().decode([GameStats].self, from: apiResponse)
            
            gameStats = decodedApiResponse
        } catch {
            print("Error", error)
        }
        
        return gameStats
    }
    
    func getPlayersStatsPerGame(gameId: Int) async -> [String : [PlayerData]] {
        var groupByTeam: [String : [PlayerData]] = [:]
        var urlRequest = getUrlRequestObject("/players/statistics")
            urlRequest.url?.append(queryItems: [URLQueryItem(name: "game", value: "\(gameId)")])
        
        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest)
            
            guard let apiResponse = apiResponse else {
                return [:]
            }
            
            let decodedApiResponse = try JSONDecoder().decode([PlayerData].self, from: apiResponse)
            
            let gp = Dictionary(grouping: decodedApiResponse) { (player) -> String in
                return player.team.nickname ?? "-"
            }
            
            groupByTeam = gp
            
        } catch {
            print("Error", error)
        }
        
        return groupByTeam
        
    }
    
    
    func getNews(playerId: Int = 0) async -> [News] {
        var news: [News] = []
        let path = playerId != 0 ? "/NewsByPlayerID/\(playerId)" : "/News"
        
        let urlRequest = getUrlRequestObject(path, sportsIoApi: true)

        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest, sportsIoApi: true)
    
            guard let apiResponse = apiResponse else {
                return []
            }
            let decodedApiResponse = try JSONDecoder().decode([News].self, from: apiResponse)

            news = decodedApiResponse
            
        } catch {
            print("Error: ", error)
        }
        
        return news
    }
    
    
    
    func getActivePlayers() async -> [PlayerSportsIo] {
        var players: [PlayerSportsIo] = []
        let urlRequest = getUrlRequestObject("/Players", sportsIoApi: true)
        
        do {
            let apiResponse = try? await callApi(urlRequest: urlRequest, sportsIoApi: true)

            guard let apiResponse = apiResponse else {
                return []
            }
            
            let decodedApiResponse = try JSONDecoder().decode([PlayerSportsIo].self, from: apiResponse)
            
            players = decodedApiResponse
        } catch {
            print("Error: ", error)
        }
        
        return players
    }
    
}

// DEPRECATED
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
