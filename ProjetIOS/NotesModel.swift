//
//  NotesModel.swift
//  ProjetIOS
//
//  Created by user191414 on 3/4/21.
//

import Foundation

struct LocationModel:Codable {
    var latitude: Double
    var longitude: Double
}

struct NotesModel :Codable {
    var title: String;
    var content: String;
    var lastModificationDate: Date;
    var localisation: LocationModel;
}
