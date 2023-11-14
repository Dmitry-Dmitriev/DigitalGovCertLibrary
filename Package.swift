// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "DigitalGovCertLibrary",
	platforms:
	[
        .iOS("12.4")
	],
	products:
	[
		.library(
			name: "DigitalGovCertLibrary",
            type: .dynamic,
			targets: ["DigitalGovCertLibrary"])
	],
	targets:
	[
		.target(name: "DigitalGovCertLibrary",
                path: "Sources",
                resources: [
                    .copy("Resources/Localization/Localizable.xcstrings"),
                    .copy("Resources/Certs/Readme.md"),
                    .copy("Resources/Certs/russiantrustedca.der"),
                    .copy("Resources/Certs/russiantrustedca.pem"),
                    .copy("Resources/Certs/russiantrustedca.crt"),
                    .copy("Resources/Certs/russiantrustedrootca.cer"),
                    .copy("Resources/Certs/russiantrustedsubca.cer")
                ]),
        .testTarget(name: "UnitTests",
                    dependencies: ["DigitalGovCertLibrary"],
                    path: "Tests")
        ]
)

// DigitalGovCertLibrary
// ru.digitalGovCert.library
