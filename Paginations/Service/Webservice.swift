//
//  Webservice.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 12.02.2021.
//

import Foundation


class Webservice {
    
    func fetchData (path: String,solQuery:Int,camera:String?,pageQuery:Int, completion : @escaping (NasaPhotosApi?) -> ()){
        let apiKey = "mDWaPv6l7Vow7EiNZgNZ4dTxRAuA2rtqVBfyjjmN&"
        var url = URL(string: "")
        if camera != nil {
            url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(path)/photos?sol=\(solQuery)&camera=\(camera ?? "")&api_key=\(apiKey)&page=\(pageQuery)")!
        }else{
            url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(path)/photos?sol=\(solQuery)&api_key=\(apiKey)&page=\(pageQuery)")!
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
             if let data = data {
                do {
                    let dataList = try JSONDecoder().decode(NasaPhotosApi.self, from: data)
                    completion(dataList)
//                    print(dataList)
//                    print(pageQuery)
                }catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
}
