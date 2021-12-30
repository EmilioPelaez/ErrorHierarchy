//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

public enum ReceiveErrorResult {
	case handled
	case notHandled
}

public extension View {
	
	func receiveError(_ closure: @escaping (Error) -> ReceiveErrorResult) -> some View {
		let handlerModifier = ErrorHandlerViewModifier {
			switch closure($0) {
			case .handled: return nil
			case .notHandled: return $0
			}
		}
		return modifier(handlerModifier)
	}
	
	func handleError(_ handler: @escaping (Error) -> Void) -> some View {
		receiveError {
			handler($0)
			return .handled
		}
	}
	
	func transformError(_ transform: @escaping (Error) -> Error) -> some View {
		modifier(ErrorHandlerViewModifier(handler: transform))
	}
	
}
