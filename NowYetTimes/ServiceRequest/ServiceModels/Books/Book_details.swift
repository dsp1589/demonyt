/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Book_details : Codable {
	let title : String?
	let description : String?
	let contributor : String?
	let author : String?
	let contributor_note : String?
	let price : Int?
	let age_group : String?
	let publisher : String?
	let primary_isbn13 : String?
	let primary_isbn10 : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case description = "description"
		case contributor = "contributor"
		case author = "author"
		case contributor_note = "contributor_note"
		case price = "price"
		case age_group = "age_group"
		case publisher = "publisher"
		case primary_isbn13 = "primary_isbn13"
		case primary_isbn10 = "primary_isbn10"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		contributor = try values.decodeIfPresent(String.self, forKey: .contributor)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		contributor_note = try values.decodeIfPresent(String.self, forKey: .contributor_note)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		age_group = try values.decodeIfPresent(String.self, forKey: .age_group)
		publisher = try values.decodeIfPresent(String.self, forKey: .publisher)
		primary_isbn13 = try values.decodeIfPresent(String.self, forKey: .primary_isbn13)
		primary_isbn10 = try values.decodeIfPresent(String.self, forKey: .primary_isbn10)
	}

}