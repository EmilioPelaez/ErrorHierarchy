//
//  ContentView.swift
//  ErrorHierarchyTests
//
//  Created by Emilio Peláez on 8/1/22.
//

import SwiftUI

import SwiftUI

struct FirstError: Error {}
struct SecondError: Error {}
struct ThirdError: Error {}
struct FourthError: Error {}
struct FifthError: AlertableError {
	var message: String { "Test 3" }
}
struct SixthError: Error {}

struct ContentView: View {
	@State var alertTitle = ""
	@State var handled = false
	
	var body: some View {
		TriggerView()
			.receiveError { _ in .notHandled }
			.receiveError(SixthError.self) { _ in .handled }
			.transformError(FirstError.self) { SecondError() }
			.receiveError(SecondError.self) { .notHandled }
			.handleError(SecondError.self) {
				alertTitle = "Test 1"
				handled = true
			}
			.handleAlertErrors()
			.transformError { _ in FourthError() }
			.handleError { _ in
				alertTitle = "Test 2"
				handled = true
			}
			.alert(alertTitle, isPresented: $handled) {
				Button("Close") {
					handled = false
				}
			}
	}
}

struct TriggerView: View {
	@Environment(\.reportError) var reportError
	
	var body: some View {
		Button("Test 1") {
			reportError(FirstError())
		}
		Button("Test 2") {
			reportError(ThirdError())
		}
		Button("Test 3") {
			reportError(FifthError())
		}
		Button("Test 4") {
			reportError(SixthError())
		}
	}
}
