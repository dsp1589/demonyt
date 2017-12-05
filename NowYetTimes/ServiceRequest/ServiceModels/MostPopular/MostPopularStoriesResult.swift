/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MostPopularStoriesResult : Codable {
	let url : String?
	let count_type : String?
	let column : String?
	let section : String?
	let byline : String?
	let title : String?
	let abstract : String?
	let published_date : String?
	let source : String?
	let des_facet : [String]?
	let org_facet : [String]?
	let per_facet : [String]?
	let geo_facet : [String]?
	let media : [Media]?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case count_type = "count_type"
		case column = "column"
		case section = "section"
		case byline = "byline"
		case title = "title"
		case abstract = "abstract"
		case published_date = "published_date"
		case source = "source"
		case des_facet = "des_facet"
		case org_facet = "org_facet"
		case per_facet = "per_facet"
		case geo_facet = "geo_facet"
		case media = "media"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		count_type = try values.decodeIfPresent(String.self, forKey: .count_type)
		column = try values.decodeIfPresent(String.self, forKey: .column)
		section = try values.decodeIfPresent(String.self, forKey: .section)
		byline = try values.decodeIfPresent(String.self, forKey: .byline)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
		published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
		source = try values.decodeIfPresent(String.self, forKey: .source)
        do{
            des_facet = try values.decodeIfPresent([String].self, forKey: .des_facet)
            
        }catch (_){
            do {
                if let decodedV = try values.decodeIfPresent(String.self, forKey: .des_facet), decodedV != ""{
                    des_facet = [decodedV]
                }else{
                    des_facet = []
                }
            } catch (_) {
                des_facet = []
            }
        }
        
        do{
            org_facet = try values.decodeIfPresent([String].self, forKey: .org_facet)
            
        }catch (_){
            do {
                if let decodedV = try values.decodeIfPresent(String.self, forKey: .org_facet), decodedV != ""{
                    org_facet = [decodedV]
                }else{
                    org_facet = []
                }
            } catch (_) {
                org_facet = []
            }
        }
        
//        org_facet = try values.decodeIfPresent([String].self, forKey: .org_facet)
        
        do{
            per_facet = try values.decodeIfPresent([String].self, forKey: .per_facet)
            
        }catch (_){
            do {
                if let decodedV = try values.decodeIfPresent(String.self, forKey: .per_facet), decodedV != ""{
                    per_facet = [decodedV]
                }else{
                    per_facet = []
                }
            } catch (_) {
                per_facet = []
            }
        }
        
//        per_facet = try values.decodeIfPresent([String].self, forKey: .per_facet)
        
        do{
            geo_facet = try values.decodeIfPresent([String].self, forKey: .geo_facet)
            
        }catch (_){
            do {
                if let decodedV = try values.decodeIfPresent(String.self, forKey: .geo_facet), decodedV != ""{
                    geo_facet = [decodedV]
                }else{
                    geo_facet = []
                }
            } catch (_) {
                geo_facet = []
            }
        }
//        geo_facet = try values.decodeIfPresent([String].self, forKey: .geo_facet)
        do {
        media = try values.decodeIfPresent([Media].self, forKey: .media)
        } catch (let err) {
            print(err.localizedDescription)
            media = nil
        }
		
        
	}

}
