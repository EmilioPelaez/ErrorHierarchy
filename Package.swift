// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ErrorHierarchy",
	products: [
		.library(
			name: "ErrorHierarchy",
			targets: ["ErrorHierarchy"]),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "ErrorHierarchy",
			dependencies: []),
		.testTarget(
			name: "ErrorHierarchyTests",
			dependencies: ["ErrorHierarchy"]),
	]
)
