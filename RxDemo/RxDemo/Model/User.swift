//
//  User.swift
//
//  Created by IMAC on 10/26/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class User: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let fcmToken = "fcm_token"
    static let verifed = "verifed"
    static let displayName = "display_name"
    static let numberFollowing = "number_following"
    static let typeMom = "type_mom"
    static let cityName = "city_name"
    static let numberFollower = "number_follower"
    static let babyInfo = "baby_info"
    static let checkFollow = "check_follow"
    static let id = "id"
    static let phone = "phone"
    static let avatar = "avatar"
    static let numberFeed = "number_feed"
  }

  // MARK: Properties
  public var fcmToken: String?
  public var verifed: Int?
  public var displayName: String?
  public var numberFollowing: Int?
  public var typeMom: Int?
  public var cityName: CityName?
  public var numberFollower: Int?
  public var babyInfo: [BabyInfo]?
  public var checkFollow: Int?
  public var id: Int?
  public var phone: String?
  public var avatar: String?
  public var numberFeed: Int?

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
    fcmToken <- map[SerializationKeys.fcmToken]
    verifed <- map[SerializationKeys.verifed]
    displayName <- map[SerializationKeys.displayName]
    numberFollowing <- map[SerializationKeys.numberFollowing]
    typeMom <- map[SerializationKeys.typeMom]
    cityName <- map[SerializationKeys.cityName]
    numberFollower <- map[SerializationKeys.numberFollower]
    babyInfo <- map[SerializationKeys.babyInfo]
    checkFollow <- map[SerializationKeys.checkFollow]
    id <- map[SerializationKeys.id]
    phone <- map[SerializationKeys.phone]
    avatar <- map[SerializationKeys.avatar]
    numberFeed <- map[SerializationKeys.numberFeed]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = fcmToken { dictionary[SerializationKeys.fcmToken] = value }
    if let value = verifed { dictionary[SerializationKeys.verifed] = value }
    if let value = displayName { dictionary[SerializationKeys.displayName] = value }
    if let value = numberFollowing { dictionary[SerializationKeys.numberFollowing] = value }
    if let value = typeMom { dictionary[SerializationKeys.typeMom] = value }
    if let value = cityName { dictionary[SerializationKeys.cityName] = value.dictionaryRepresentation() }
    if let value = numberFollower { dictionary[SerializationKeys.numberFollower] = value }
    if let value = babyInfo { dictionary[SerializationKeys.babyInfo] = value.map { $0.dictionaryRepresentation() } }
    if let value = checkFollow { dictionary[SerializationKeys.checkFollow] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = avatar { dictionary[SerializationKeys.avatar] = value }
    if let value = numberFeed { dictionary[SerializationKeys.numberFeed] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.fcmToken = aDecoder.decodeObject(forKey: SerializationKeys.fcmToken) as? String
    self.verifed = aDecoder.decodeObject(forKey: SerializationKeys.verifed) as? Int
    self.displayName = aDecoder.decodeObject(forKey: SerializationKeys.displayName) as? String
    self.numberFollowing = aDecoder.decodeObject(forKey: SerializationKeys.numberFollowing) as? Int
    self.typeMom = aDecoder.decodeObject(forKey: SerializationKeys.typeMom) as? Int
    self.cityName = aDecoder.decodeObject(forKey: SerializationKeys.cityName) as? CityName
    self.numberFollower = aDecoder.decodeObject(forKey: SerializationKeys.numberFollower) as? Int
    self.babyInfo = aDecoder.decodeObject(forKey: SerializationKeys.babyInfo) as? [BabyInfo]
    self.checkFollow = aDecoder.decodeObject(forKey: SerializationKeys.checkFollow) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.avatar = aDecoder.decodeObject(forKey: SerializationKeys.avatar) as? String
    self.numberFeed = aDecoder.decodeObject(forKey: SerializationKeys.numberFeed) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(fcmToken, forKey: SerializationKeys.fcmToken)
    aCoder.encode(verifed, forKey: SerializationKeys.verifed)
    aCoder.encode(displayName, forKey: SerializationKeys.displayName)
    aCoder.encode(numberFollowing, forKey: SerializationKeys.numberFollowing)
    aCoder.encode(typeMom, forKey: SerializationKeys.typeMom)
    aCoder.encode(cityName, forKey: SerializationKeys.cityName)
    aCoder.encode(numberFollower, forKey: SerializationKeys.numberFollower)
    aCoder.encode(babyInfo, forKey: SerializationKeys.babyInfo)
    aCoder.encode(checkFollow, forKey: SerializationKeys.checkFollow)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(avatar, forKey: SerializationKeys.avatar)
    aCoder.encode(numberFeed, forKey: SerializationKeys.numberFeed)
  }

}
