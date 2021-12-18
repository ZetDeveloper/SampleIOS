//
//  Row.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import Foundation


public enum Row {
    case Data
    case Photo
    case Graph
}

class RowModel {
    var row: Row?
    var question: Question?
    var colors: [String]?
}
