//
//  File.swift
//  
//
//  Created by Nikolay Eckert on 23.09.2020.
//

import Foundation

struct UserInteraction {
	static func userInput() -> String {
		let keyboard = FileHandle.standardInput
		let inputData = keyboard.availableData
		
		let result = NSString(data: inputData,
							  encoding: String.Encoding.utf8.rawValue)! as String
		
		return result
	}
}

