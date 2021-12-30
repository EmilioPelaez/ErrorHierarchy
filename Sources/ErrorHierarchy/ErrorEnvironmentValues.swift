//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

public extension EnvironmentValues {
	var errorReporter: (Error) -> Void {
		{  _ = errorClosure($0) }
	}
}

struct ErrorClosureEnvironmentKey: EnvironmentKey {
	static var defaultValue: (Error) -> Error? = { error in
		assertionFailure("Unhandled Error \(error)")
		print("Unhandled Error", error)
		return error
	}
}

extension EnvironmentValues {
	var errorClosure: (Error) -> Error? {
		get { self[ErrorClosureEnvironmentKey.self] }
		set { self[ErrorClosureEnvironmentKey.self] = newValue }
	}
	
	
}
