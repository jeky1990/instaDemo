

import Foundation

struct InstagramData : Codable {
	let id : Int?
	let user : User?
	let images : [String]?
	let videos : [String]?
	let likes : Int?
	let comments : [String]?
	let descriptions : String?
	let hashtags : String?
	let date_time : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user = "user"
		case images = "images"
		case videos = "videos"
		case likes = "likes"
		case comments = "comments"
		case descriptions = "descriptions"
		case hashtags = "hashtags"
		case date_time = "date_time"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user = try values.decodeIfPresent(User.self, forKey: .user)
		images = try values.decodeIfPresent([String].self, forKey: .images)
		videos = try values.decodeIfPresent([String].self, forKey: .videos)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		comments = try values.decodeIfPresent([String].self, forKey: .comments)
		descriptions = try values.decodeIfPresent(String.self, forKey: .descriptions)
		hashtags = try values.decodeIfPresent(String.self, forKey: .hashtags)
		date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
	}

}
