/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Media : Codable {
    var type : String?
    var subtype : String?
    var caption : String?
    var copyright : String?
    var approved_for_syndication : Int?
	let mediaMetadata : [MediaMetadata]?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case subtype = "subtype"
		case caption = "caption"
		case copyright = "copyright"
		case approved_for_syndication = "approved_for_syndication"
		case mediaMetadata = "media-metadata"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            type = try values.decodeIfPresent(String.self, forKey: .type)
            subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
            caption = try values.decodeIfPresent(String.self, forKey: .caption)
            copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
            approved_for_syndication = try values.decodeIfPresent(Int.self, forKey: .approved_for_syndication)
            mediaMetadata = try values.decodeIfPresent([MediaMetadata].self, forKey: .mediaMetadata)
        } catch (let err) {
            print(err.localizedDescription)
            type = nil
            subtype = nil
            caption = nil
            copyright = nil
            approved_for_syndication = nil
            mediaMetadata = nil
        }
		
	}

}