//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

public extension EnvironmentValues {
	/**
	 This closure can be used when an `Error` that can't be handled by the
	 current view is generated. The `Error` will be sent up the view hierarchy
	 until it is handled by another view.
	 
	 Views can register a closure to handle these `Errors` using the
	 `receiveError` and `handleError` view modifiers.
	 
	 If no view has registered an action that handles the `Error`, an
	 `assertionFailure` will be triggered.
	 */
	var reportError: (Error) -> Void {
		{ errorClosure($0) }
	}
}

struct ErrorClosureEnvironmentKey: EnvironmentKey {
	static var defaultValue: (Error) -> Void = { error in
		assertionFailure("Unhandled Error \(error)")
	}
}

extension EnvironmentValues {
	var errorClosure: (Error) -> Void {
		get { self[ErrorClosureEnvironmentKey.self] }
		set { self[ErrorClosureEnvironmentKey.self] = newValue }
	}
}
