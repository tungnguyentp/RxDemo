//
//  BabyInfo.swift
//
//  Created by IMAC on 10/26/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class BabyInfo: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let nickname = "nickname"
    static let gender = "gender"
    static let year = "year"
    static let month = "month"
    static let id = "id"
  }

  // MARK: Properties
  public var nickname: String?
  public var gender: Int?
  public var year: Int?
  public var month: Int?
  public var id: Int?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    nickname <- map[SerializationKeys.nickname]
    gender <- map[SerializationKeys.gender]
    year <- map[SerializationKeys.year]
    month <- map[SerializationKeys.month]
    id <- map[SerializationKeys.id]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = nickname { dictionary[SerializationKeys.nickname] = value }
    if let value = gender { dictionary[SerializationKeys.gender] = value }
    if let value = year { dictionary[SerializationKeys.year] = value }
    if let value = month { dictionary[SerializationKeys.month] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.nickname = aDecoder.decodeObject(forKey: SerializationKeys.nickname) as? String
    self.gender = aDecoder.decodeObject(forKey: SerializationKeys.gender) as? Int
    self.year = aDecoder.decodeObject(forKey: SerializationKeys.year) as? Int
    self.month = aDecoder.decodeObject(forKey: SerializationKeys.month) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(nickname, forKey: SerializationKeys.nickname)
    aCoder.encode(gender, forKey: SerializationKeys.gender)
    aCoder.encode(year, forKey: SerializationKeys.year)
    aCoder.encode(month, forKey: SerializationKeys.month)
    aCoder.encode(id, forKey: SerializationKeys.id)
  }

}
