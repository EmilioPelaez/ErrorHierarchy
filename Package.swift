// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ErrorHierarchy",
	platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .macCatalyst(.v13), .tvOS(.v13)],
	products: [
		.library(
			name: "ErrorHierarchy",
			targets: ["ErrorHierarchy"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "ErrorHierarchy",
			dependencies: []
		),
	]
)
