// swift-tools-version:5.1
import PackageDescription

var package = Package(
    name: "ImGuizmo",
    products: [
        .library(name: "ImGuizmo", targets: ["ImGuizmo"])
    ],
    dependencies: [
        .package(url: "https://github.com/ctreffs/SwiftImGui.git", .revision("b0f848e34d44fa0c9ad6082641d4793f30073e8d")),
    ],
    targets: [
        .target(name: "ImGuizmo", dependencies: ["CImGuizmo"]),
        .target(name: "CImGuizmo", dependencies: ["CImGui"]),
        .target(name: "AutoWrapper"),
    ],
    cxxLanguageStandard: .cxx11
)
