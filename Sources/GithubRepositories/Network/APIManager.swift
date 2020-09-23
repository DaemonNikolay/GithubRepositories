//
//  File.swift
//  
//
//  Created by Nikolay Eckert on 23.09.2020.
//

import Foundation
import Alamofire

struct APIManager {
	static func downloadRepositories(url: String,
							  nickname: String,
							  dispatchGroup: DispatchGroup,
							  completion: @escaping ([String]?, String?) -> Void) {
		
		let headers: HTTPHeaders = [
			"Accept" : "application/vnd.github.v3+json"
		]

		AF.request(url, headers: headers).responseJSON { response -> Void in
			
			switch response.result {
			case .success(let value):

				switch response.response?.statusCode {
				case 200:
					if let jsonArray = value as? [[String:Any]] {
						let names: [String] = jsonArray.map { json in
							return json["name"] as! String
						}
						
						completion(names, nil)
					} else {
						completion(nil, "Download repository names fail")
					}
					
				case 404:
					completion(nil, "Repositories not found for account: \(nickname)")
					
				default:
					let statusCode: String = response.response?.statusCode.description ?? "???"
					completion(nil, "Unexpected status code: \(statusCode)")
				}
				
			case .failure(let error):
				guard let errorDescription = error.errorDescription else {
					completion(nil, "Error")
					
					return
				}
				
				completion(nil, "ERROR: \(errorDescription)")
			}

			dispatchGroup.leave()
		}
	}
}

