/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BookReviews : Codable {
	let book_review_link : String?
	let first_chapter_link : String?
	let sunday_review_link : String?
	let article_chapter_link : String?

	enum CodingKeys: String, CodingKey {

		case book_review_link = "book_review_link"
		case first_chapter_link = "first_chapter_link"
		case sunday_review_link = "sunday_review_link"
		case article_chapter_link = "article_chapter_link"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		book_review_link = try values.decodeIfPresent(String.self, forKey: .book_review_link)
		first_chapter_link = try values.decodeIfPresent(String.self, forKey: .first_chapter_link)
		sunday_review_link = try values.decodeIfPresent(String.self, forKey: .sunday_review_link)
		article_chapter_link = try values.decodeIfPresent(String.self, forKey: .article_chapter_link)
	}

}
