//
//  CityName.swift
//
//  Created by IMAC on 10/26/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class CityName: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let locationNameVi = "location_name_vi"
    static let locationNameEn = "location_name_en"
    static let id = "id"
    static let locationCode = "location_code"
  }

  // MARK: Properties
  public var locationNameVi: String?
  public var locationNameEn: String?
  public var id: Int?
  public var locationCode: Int?

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
    locationNameVi <- map[SerializationKeys.locationNameVi]
    locationNameEn <- map[SerializationKeys.locationNameEn]
    id <- map[SerializationKeys.id]
    locationCode <- map[SerializationKeys.locationCode]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = locationNameVi { dictionary[SerializationKeys.locationNameVi] = value }
    if let value = locationNameEn { dictionary[SerializationKeys.locationNameEn] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = locationCode { dictionary[SerializationKeys.locationCode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.locationNameVi = aDecoder.decodeObject(forKey: SerializationKeys.locationNameVi) as? String
    self.locationNameEn = aDecoder.decodeObject(forKey: SerializationKeys.locationNameEn) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.locationCode = aDecoder.decodeObject(forKey: SerializationKeys.locationCode) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(locationNameVi, forKey: SerializationKeys.locationNameVi)
    aCoder.encode(locationNameEn, forKey: SerializationKeys.locationNameEn)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(locationCode, forKey: SerializationKeys.locationCode)
  }

}
