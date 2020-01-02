//
//  Networking.swift
//  Practica
//
//  Created by Juan Gerardo Cruz on 12/2/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//
// Uso de alerttas
// https://iosexample.com/advanced-usage-of-uialertcontroller-and-pickers/
import Foundation

struct Posts: Codable {
    var body: String
    var id: Int
    var title: String
    var userId: Int
}


class NetWorking {
    
    func URLSessionGet() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{ return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse,
                (200...209).contains(httpURLResponse.statusCode),
                let mimetype = response?.mimeType, mimetype == "application/json",
                let data = data, error == nil else { return }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                let posts = try JSONDecoder().decode([Posts].self, from: data)
                print(posts[0].title)
            } catch {
                print("Json Error \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func URLSessionPost () {
        let json: [String: Any] = ["title": "ABC",
                                   "dict": ["1":"First", "2":"Second"]]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "https://httpbin.org/post") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse,
                (200...209).contains(httpURLResponse.statusCode),
                let data = data, error == nil, let dataString = String(data: data, encoding: .utf8)  else { return }
            
             print(dataString)
        }.resume()
    }
    
    func URLSessionPostParameter() {
     //   let parameter = ["username":"kilo_loco", "tweet":"HelloWorld"]
        let parameter = ["userId":1]
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, (200...209).contains(response.statusCode)  else {
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }

            }
        }.resume()
    }
        
}
