//
//  CategoryModel.swift
//
//  Created by IMAC on 10/28/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class CategoryModel: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let urlImage = "url_image"
    static let categoryId = "category_id"
    static let categoryName = "category_name"
    static let type = "type"
  }

  // MARK: Properties
  public var urlImage: String?
  public var categoryId: Int?
  public var categoryName: String?
  public var type: Int?

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
    urlImage <- map[SerializationKeys.urlImage]
    categoryId <- map[SerializationKeys.categoryId]
    categoryName <- map[SerializationKeys.categoryName]
    type <- map[SerializationKeys.type]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = urlImage { dictionary[SerializationKeys.urlImage] = value }
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    if let value = categoryName { dictionary[SerializationKeys.categoryName] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.urlImage = aDecoder.decodeObject(forKey: SerializationKeys.urlImage) as? String
    self.categoryId = aDecoder.decodeObject(forKey: SerializationKeys.categoryId) as? Int
    self.categoryName = aDecoder.decodeObject(forKey: SerializationKeys.categoryName) as? String
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(urlImage, forKey: SerializationKeys.urlImage)
    aCoder.encode(categoryId, forKey: SerializationKeys.categoryId)
    aCoder.encode(categoryName, forKey: SerializationKeys.categoryName)
    aCoder.encode(type, forKey: SerializationKeys.type)
  }

}
