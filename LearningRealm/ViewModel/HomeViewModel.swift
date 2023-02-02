//
//  TestViewModel.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import Foundation

class HomeViewModel {
    var contactModel: ContactModel?
    let alphabet: [String] = (65...90).map({String(UnicodeScalar($0))})
    
}
