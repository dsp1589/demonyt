/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Books : Codable {
	let list_name : String?
	let display_name : String?
	let list_name_encoded : String?
	let oldest_published_date : String?
	let newest_published_date : String?
	let updated : String?

    var reponse : BooksOfTypeResponse?
    
	enum CodingKeys: String, CodingKey {

		case list_name = "list_name"
		case display_name = "display_name"
		case list_name_encoded = "list_name_encoded"
		case oldest_published_date = "oldest_published_date"
		case newest_published_date = "newest_published_date"
		case updated = "updated"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		list_name = try values.decodeIfPresent(String.self, forKey: .list_name)
		display_name = try values.decodeIfPresent(String.self, forKey: .display_name)
		list_name_encoded = try values.decodeIfPresent(String.self, forKey: .list_name_encoded)
		oldest_published_date = try values.decodeIfPresent(String.self, forKey: .oldest_published_date)
		newest_published_date = try values.decodeIfPresent(String.self, forKey: .newest_published_date)
		updated = try values.decodeIfPresent(String.self, forKey: .updated)
	}
}
