//
//  NasaPhotosApi.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 12.02.2021.
//

import Foundation

struct NasaPhotosApi : Decodable{
    var photos : [Photos]
}
struct Photos : Decodable {
    var id : Int?
    var sol : Int?
    var camera : Camera?
    var img_src : String?
    var earth_date : String?
    var rover : Rover?
    

}
struct Camera : Decodable {
    var id: Int
    var name: String
    var rover_id : Int
    var full_name : String
}
struct Rover : Decodable {
    var id : Int
    var name : String
    var landing_date : String
    var launch_date : String
    var status : String
}
