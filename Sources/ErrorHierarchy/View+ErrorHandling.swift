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
	
	func receiveError<Received: Error>(_: Received.Type, closure: @escaping (Received) -> ReceiveErrorResult) -> some View {
		let handlerModifier = ErrorHandlerViewModifier {
			guard let received = $0 as? Received else {
				return $0
			}
			switch closure(received) {
			case .handled: return nil
			case .notHandled: return received
			}
		}
		return modifier(handlerModifier)
	}
	
	func receiveError<Received: Error>(_ type: Received.Type, closure: @escaping () -> ReceiveErrorResult) -> some View {
		receiveError(type) { _ in closure() }
	}
	
	func handleError(_ handler: @escaping (Error) -> Void) -> some View {
		receiveError {
			handler($0)
			return .handled
		}
	}
	
	func handleError<Handled: Error>(_: Handled.Type, handler: @escaping (Handled) -> Void) -> some View {
		receiveError {
			if let error = $0 as? Handled {
				handler(error)
				return .handled
			} else {
				return .notHandled
			}
		}
	}
	
	func handleError<Handled: Error>(_ type: Handled.Type, handler: @escaping () -> Void) -> some View {
		handleError(type) { _ in handler() }
	}
	
	func transformError(_ transform: @escaping (Error) -> Error) -> some View {
		modifier(ErrorHandlerViewModifier(handler: transform))
	}
	
	func transformError<Transformable: Error>(_: Transformable.Type, transform: @escaping (Transformable) -> Error) -> some View {
		let transformModifier = ErrorHandlerViewModifier {
			guard let transformable = $0 as? Transformable else {
				return $0
			}
			return transform(transformable)
		}
		return modifier(transformModifier)
	}
	
	func transformError<Transformable: Error>(_ type: Transformable.Type, transform: @escaping () -> Error) -> some View {
		transformError(type) { _ in transform() }
	}
		
}
