//
//  TestModel.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//


import Foundation
import RealmSwift

class SpecimenModel: Object {
  @objc dynamic var name = ""
  @objc dynamic var specimenDescription = ""
  @objc dynamic var latitude = 0.0
  @objc dynamic var longitude = 0.0
  @objc dynamic var created = Date()
}

