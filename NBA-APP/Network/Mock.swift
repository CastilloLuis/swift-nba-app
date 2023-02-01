//
//  Mock.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/1/23.
//

import Foundation

var mockGame = LiveGame(
    id: 11785,
    league: "standard",
    season: 2022, date: DateClass(start: "2023-01-28T00:00:00.000Z", end: JSONNull(), duration: JSONNull()),
    stage: 2,
    status: Status(clock: JSONNull(), halftime: false, short: 3, long: "Finished"),
    periods: Periods(current: 4, total: 4, endOfPeriod: false),
    arena: Arena(name: "TEST", city: "TEST", state: "TEST", country: "TEST"),
    teams: Teams(visitors: TeamsHome(id: 21, name: "BUCKS", nickname: "BUCKS", code: "MIL", logo: "https://upload.wikimedia.org/wikipedia/fr/3/34/Bucks2015.png"), home: TeamsHome(id: 21, name: "BUCKS", nickname: "BUCKS", code: "MIL", logo: "https://upload.wikimedia.org/wikipedia/fr/3/34/Bucks2015.png")),
    scores: Scores(visitors: ScoresHome(win: 0, loss: 0, series: Series(win: 0, loss: 0), linescore: ["45", "40"], points: 141), home: ScoresHome(win: 0, loss: 0, series: Series(win: 0, loss: 0), linescore: ["45", "40"], points: 141)),
    officials: [],
    timesTied: JSONNull(),
    leadChanges: JSONNull(),
    nugget: JSONNull()
)

private func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

private func parse(jsonData: Data) -> [LiveGame] {
    let decodedData = try? JSONDecoder().decode([LiveGame].self, from: jsonData)
    return decodedData ?? []
}

private func loadJson(fromURLString urlString: String,
                      completion: @escaping (Result<Data, Error>) -> Void) {
    if let url = URL(string: urlString) {
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        urlSession.resume()
    }
}
 
func getMockGames() -> [LiveGame] {
    if let localData = readLocalFile(forName: "MockData") {
        return parse(jsonData: localData)
    }
    return [mockGame]
}
