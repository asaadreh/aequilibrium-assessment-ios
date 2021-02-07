//
//  HeaderTableViewCellViewModel.swift
//  aequilibrium-assessment-ios
//
//  Created by Agha Saad Rehman on 07/02/2021.
//

import Foundation

class HeaderTableViewCellViewModel: BaseTableViewCellViewModel {
   
    var headerText : String
    
    init(rowType: RowType, headerText: String) {
        self.headerText = headerText
        super.init(rowType: rowType)
    }
    

}
