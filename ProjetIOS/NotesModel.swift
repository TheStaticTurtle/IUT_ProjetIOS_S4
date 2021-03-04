//
//  NotesModel.swift
//  ProjetIOS
//
//  Created by user191414 on 3/4/21.
//

import Foundation

struct Location {
    var latitude: Double
    var longitude: Double
}

struct NotesModel {
    var title: String;
    var content: String;
    var lastModificatinoDate: Date;
    var localisation: Location;
}
