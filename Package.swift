// swift-tools-version:5.1
import PackageDescription

var package = Package(
    name: "ImGuizmo",
    products: [
        .library(name: "ImGuizmo", targets: ["ImGuizmo"]),
        .library(name: "CImGuizmo", targets: ["CImGuizmo"])
    ],
    targets: [
        .target(name: "ImGuizmo", dependencies: ["CImGuizmo"]),
        .target(name: "CImGuizmo", path: "Sources/CImGuizmo", cxxSettings: [.define("CIMGUI_DEFINE_ENUMS_AND_STRUCTS")]),
        .target(name: "AutoWrapper"),
        .testTarget(name: "ImGuizmoTests", dependencies: ["ImGuizmo"])
    ],
    cxxLanguageStandard: .cxx11
)
