//
//  Created by Emilio Peláez on 30/12/21.
//

public protocol AlertableError: Error {
	var title: String? { get }
	var message: String { get }
}

public extension AlertableError {
	var title: String? { nil }
}

extension AlertableError {
	func typeErased() -> AnyAlertableError {
		AnyAlertableError(title: title, message: message)
	}
}

struct AnyAlertableError: AlertableError {
	var title: String?
	var message: String
}
