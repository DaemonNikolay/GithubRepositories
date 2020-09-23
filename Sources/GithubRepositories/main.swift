import Foundation

fileprivate func main() {
	print(StaticContent.enterNickname)
	let inputNickname = UserInteraction.userInput()
	print()
	
	guard let url = Paths.userRepos(nickname: inputNickname) else {
		displayError(StaticContent.enteredNicknameError)
		return
	}
	
	let dispatchGroup = DispatchGroup()
	dispatchGroup.enter()
	
	APIManager.downloadRepositories(url: url,
									nickname: inputNickname,
									dispatchGroup: dispatchGroup) { (repositoryNames, error) in
		
		guard let names = repositoryNames else {
			displayError(error)
			return
		}
		
		displayRepositoryNames(names)
	}
	
	dispatchGroup.notify(queue: DispatchQueue.main) {
		print()
		exit(EXIT_SUCCESS)
	}

	dispatchMain()
}

fileprivate func displayRepositoryNames(_ names: [String]) {
	if names.isEmpty {
		print(StaticContent.noRepositories)
		return
	}
	
	print("Repository names:")
	print("---------–-------")
	names.forEach { name in
		print(name)
	}
	print("---------–-------")
}

fileprivate func displayError(_ content: String?) {
	guard let errorMessage = content?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
	
	print("=================")
	print(errorMessage)
	print("=================")
}


main()
