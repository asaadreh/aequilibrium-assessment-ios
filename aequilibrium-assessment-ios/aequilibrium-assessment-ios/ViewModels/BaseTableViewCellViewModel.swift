//
//  BaseTableViewCell.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 05/02/2021.
//

import Foundation

/// Base class for prototype tableView cell View Model
class BaseTableViewCellViewModel {
    var rowType : RowType
    
    init(rowType: RowType) {
        self.rowType = rowType
    }
}

/// RowTypes for protype cells
enum RowType: String {
    case setName, setAttribute, setTeam, header, submit
}
