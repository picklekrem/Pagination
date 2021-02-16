//
//  NasaViewModel.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 12.02.2021.
//

import Foundation

class NasaViewModel {
    var nasaPhotosList : [Photos] = []
    func getNasaPhotos(path : String, solQuery: Int,camera:String?, pageQuery: Int, completion : @escaping (NasaPhotosApi?) -> ()){
        Webservice().fetchData(path: path, solQuery: solQuery, camera: camera, pageQuery: pageQuery) { (response) in
            if let response = response {
                if pageQuery == 1 {
                    self.nasaPhotosList.removeAll()
                }
                for photosItem in response.photos{
                    self.nasaPhotosList.append(photosItem)
                    completion(response)
                }
            }
        }
    }
}
