//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

struct AlertableErrorHandlerModifier: ViewModifier {
	
	@State var alertError: AnyAlertableError?
	var showAlert: Binding<Bool> {
		.init(get: { alertError != nil }, set: { _ in alertError = nil })
	}
	
	func body(content: Content) -> some View {
		if #available(iOS 15.0, *) {
			content
				.receiveError {
					guard let error = $0 as? AlertableError else { return .notHandled }
					alertError = error.typeErased()
					return .handled
				}
				.alert(alertError?.title ?? "Error", isPresented: showAlert, presenting: alertError) { _ in
					Button(action: dismissAlert) {
						Text("Okay")
					}
				} message: {
					Text($0.message)
				}
		} else {
			content
				.receiveError {
					guard let error = $0 as? AlertableError else { return .notHandled }
					alertError = error.typeErased()
					return .handled
				}
				.alert(isPresented: showAlert) {
					Alert(title: Text(alertError?.title ?? "Error"),
								message: Text(alertError?.message ?? ""),
								dismissButton: .default(Text("Okay")))
				}
		}
	}
	
	func dismissAlert() {
		alertError = nil
	}
	
}

public extension View {
	func handleAlertErrors() -> some View {
		modifier(AlertableErrorHandlerModifier())
	}
}