//
//  LoginModel.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

struct OptionalMessageDTO<T:Codable>: Codable {
    typealias Model = Optional<T>
    let result: Bool?
    let message: String?
    let data: Model?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
}

struct UserModel: Codable {
    let id: Int?
    let email: String?
    let name: String?
    let phone: String?
    let address: String?
    let latitude: String?
    let longitude: String?
    let birthday: String?
    let gender: Int?
    let facebookID, googleID: String?
    let deviceToken: String?
    let cover: String?
    let type: Int?
    let receiveNotification: Bool?
    let accessToken: String?
    let avatarURL: String?
    let coverURL: String?
    let friendCount: Int?
    let followerCount: Int?
    let reviewCount: Int?
    let checkInCount: Int?
    let mediaCount: Int?
    let friendStatus: String?
    let followStatus: Int?
    let isInfluence: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, phone, address, latitude, longitude, birthday, gender
        case facebookID = "facebook_id"
        case googleID = "google_id"
        case deviceToken = "device_token"
        case cover, type
        case receiveNotification = "receive_notification"
        case accessToken = "access_token"
        case avatarURL = "avatar_url"
        case coverURL = "cover_url"
        case friendCount = "friend_count"
        case followerCount = "follower_count"
        case reviewCount = "review_count"
        case checkInCount = "check_in_count"
        case mediaCount = "media_count"
        case friendStatus = "friend_status"
        case followStatus = "follow_status"
        case isInfluence = "is_influence"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        facebookID = try values.decodeIfPresent(String.self, forKey: .facebookID)
        googleID = try values.decodeIfPresent(String.self, forKey: .googleID)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        cover = try values.decodeIfPresent(String.self, forKey: .cover)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        receiveNotification = try values.decodeIfPresent(Bool.self, forKey: .receiveNotification)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        avatarURL = try values.decodeIfPresent(String.self, forKey: .avatarURL)
        coverURL = try values.decodeIfPresent(String.self, forKey: .coverURL)
        friendCount = try values.decodeIfPresent(Int.self, forKey: .friendCount)
        followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
        reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
        checkInCount = try values.decodeIfPresent(Int.self, forKey: .checkInCount)
        mediaCount = try values.decodeIfPresent(Int.self, forKey: .mediaCount)
        friendStatus = try values.decodeIfPresent(String.self, forKey: .friendStatus)
        followStatus = try values.decodeIfPresent(Int.self, forKey: .followStatus)
        isInfluence = try values.decodeIfPresent(Bool.self, forKey: .isInfluence)
    }
}
