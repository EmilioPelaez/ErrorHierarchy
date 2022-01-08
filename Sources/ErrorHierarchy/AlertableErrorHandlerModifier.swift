//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI

public extension View {
	/**
	 Registers an `Error` handler that will handle all `Errors` of the type
	 `AlertableError` by displaying an alert with a single button.
	 
	 __Note:__ If the error is triggered by a View contained in a sheet, this
	 modifier needs to be called inside the body of the sheet, or it will fail to
	 display the alert. This also applies to popovers and other similar modifiers.
	 
	 Example:
	 ```swift
	 struct ContentView: View {
		@State var showSheet = true
		var body: some View {
			Color.primary
				.handleAlertErrors() // This will NOT work
				.sheet(isPresented: $showSheet) {
				} content: {
					ErrorGeneratingView()
						.handleAlertErrors() // This will work
				}
			}
	 }
	 ```
	 */
	func handleAlertErrors() -> some View {
		modifier(AlertableErrorHandlerModifier())
	}
}

struct AlertableErrorHandlerModifier: ViewModifier {
	
	@State var alertError: AnyAlertableError?
	var showAlert: Binding<Bool> {
		.init(get: { alertError != nil }, set: { _ in alertError = nil })
	}
	
	func body(content: Content) -> some View {
		if #available(iOS 15.0, *) {
			receiver(content: content)
				.alert(alertError?.title ?? "Error", isPresented: showAlert, presenting: alertError) { _ in
					Button(action: dismissAlert) {
						Text("Okay")
					}
				} message: {
					Text($0.message)
				}
		} else {
			receiver(content: content)
				.alert(isPresented: showAlert) {
					Alert(title: Text(alertError?.title ?? "Error"),
					      message: Text(alertError?.message ?? ""),
					      dismissButton: .default(Text("Okay")))
				}
		}
	}
	
	func receiver(content: Content) -> some View {
		content
			.receiveError {
				guard let error = $0 as? AlertableError else {
					return .notHandled
				}
				alertError = error.typeErased()
				return .handled
			}
	}
	
	func dismissAlert() {
		alertError = nil
	}
	
}
