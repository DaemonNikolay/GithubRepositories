//
//  File.swift
//  
//
//  Created by Nikolay Eckert on 23.09.2020.
//

import Foundation

struct Paths {
	static let baseUrl: String = "https://api.github.com"
	
	static func userRepos(nickname: String) -> String? {
		let clearNikname: String = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
		let urlWithNickname: String = "https://api.github.com/users/\(clearNikname)/repos"
		
		guard let url = urlWithNickname.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			return nil
		}
		
		return url
	}
}
