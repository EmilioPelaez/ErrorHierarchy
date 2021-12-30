//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

struct ErrorHandlerViewModifier: ViewModifier {
	@Environment(\.errorClosure) var errorClosure
	
	let handler: (Error) -> Error?
	
	func body(content: Content) -> some View {
		content.environment(\.errorClosure) {
			if let result = handler($0) {
				_ = errorClosure(result)
			}
			return nil
		}
	}
}
