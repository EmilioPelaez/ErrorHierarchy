//
//  ContentView.swift
//  ErrorHierarchyExample
//
//  Created by Emilio Peláez on 30/12/21.
//

import SwiftUI
import ErrorHierarchy

struct ContentView: View {
	var body: some View {
		ZStack {
			ZStack {
				ZStack {
					TriggerView()
				}
				.receiveError {
					print("Ignoring error", $0)
					return .notHandled
				}
			}
			.transformError { _ in SecondError.second }
		}
		.handleError {
			print("Handling error", $0)
		}
	}
}

enum FirstError: Error {
	case first
}

enum SecondError: Error {
	case second
}

struct TriggerView: View {
	@Environment(\.errorReporter) var errorReporter
	
	var body: some View {
		Button(action: buttonAction) {
			Text("Trigger Error")
		}
	}
	
	func buttonAction() {
		errorReporter(FirstError.first)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
