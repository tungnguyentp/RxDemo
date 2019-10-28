//
//  BaseClass.swift
//
//  Created by IMAC on 10/28/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class BaseClass: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let token = "token"
    static let user = "user"
  }

  // MARK: Properties
  public var token: String?
  public var user: User?

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
    token <- map[SerializationKeys.token]
    user <- map[SerializationKeys.user]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = token { dictionary[SerializationKeys.token] = value }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(token, forKey: SerializationKeys.token)
    aCoder.encode(user, forKey: SerializationKeys.user)
  }

}
