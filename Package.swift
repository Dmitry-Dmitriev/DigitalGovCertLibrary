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
                    .copy("Certs/Readme.md"),
                    .copy("Certs/russiantrustedca.der"),
                    .copy("Certs/russiantrustedca.pem"),
                    .copy("Certs/russiantrustedca.crt"),
                    .copy("Certs/russiantrustedrootca.cer"),
                    .copy("Certs/russiantrustedsubca.cer"),
                ]),
//        .testTarget(name: "UnitTests",
//                    dependencies: ["DigitalGovCertLibrary"],
//                    path: "Tests")
        ]
)

//DigitalGovCertLibrary
//ru.digitalGovCert.library
