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
				.receiveError(FirstError.self) {
					print("Ignoring error", $0)
					return .notHandled
				}
			}
			.transformError(FirstError.self) {
				print("Transforming error from", $0, "to", SecondError.second)
				return SecondError.second
			}
		}
		.handleError(SecondError.self) {
			print("Handling error", $0)
		}
		.handleAlertErrors()
	}
}

enum FirstError: Error {
	case first
}

enum SecondError: Error {
	case second
}

struct UserError: AlertableError {
	var message: String { "Error Triggered" }
}

enum UnhandledError: Error {
	case unhandled
}

struct TriggerView: View {
	@Environment(\.errorReporter) var errorReporter
	
	var body: some View {
		VStack(spacing: 20) {
			Button("Trigger First Console Error") {
				errorReporter(FirstError.first)
			}
			Button("Trigger Second Console Error") {
				errorReporter(SecondError.second)
			}
			Button("Trigger Alert Error") {
				errorReporter(UserError())
			}
			Button("Trigger Unhandled Error") {
				errorReporter(UnhandledError.unhandled)
			}
			.tint(.red)
		}
		.buttonStyle(.borderedProminent)
		.tint(.blue)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
