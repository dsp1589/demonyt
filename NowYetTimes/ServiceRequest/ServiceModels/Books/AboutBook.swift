/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AboutBook : Codable {
	let list_name : String?
	let display_name : String?
	let bestsellers_date : String?
	let published_date : String?
	let rank : Int?
	let rank_last_week : Int?
	let weeks_on_list : Int?
	let asterisk : Int?
	let dagger : Int?
	let amazon_product_url : String?
	let isbns : [Isbns]?
	let book_details : [Book_details]?
	let reviews : [BookReviews]?

	enum CodingKeys: String, CodingKey {

		case list_name = "list_name"
		case display_name = "display_name"
		case bestsellers_date = "bestsellers_date"
		case published_date = "published_date"
		case rank = "rank"
		case rank_last_week = "rank_last_week"
		case weeks_on_list = "weeks_on_list"
		case asterisk = "asterisk"
		case dagger = "dagger"
		case amazon_product_url = "amazon_product_url"
		case isbns = "isbns"
		case book_details = "book_details"
		case reviews = "reviews"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		list_name = try values.decodeIfPresent(String.self, forKey: .list_name)
		display_name = try values.decodeIfPresent(String.self, forKey: .display_name)
		bestsellers_date = try values.decodeIfPresent(String.self, forKey: .bestsellers_date)
		published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
		rank_last_week = try values.decodeIfPresent(Int.self, forKey: .rank_last_week)
		weeks_on_list = try values.decodeIfPresent(Int.self, forKey: .weeks_on_list)
		asterisk = try values.decodeIfPresent(Int.self, forKey: .asterisk)
		dagger = try values.decodeIfPresent(Int.self, forKey: .dagger)
		amazon_product_url = try values.decodeIfPresent(String.self, forKey: .amazon_product_url)
		isbns = try values.decodeIfPresent([Isbns].self, forKey: .isbns)
		book_details = try values.decodeIfPresent([Book_details].self, forKey: .book_details)
		reviews = try values.decodeIfPresent([BookReviews].self, forKey: .reviews)
	}

}
