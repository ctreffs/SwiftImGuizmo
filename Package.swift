// swift-tools-version:5.1
import PackageDescription

var package = Package(
    name: "ImGuizmo",
    products: [
        .library(name: "ImGuizmo", targets: ["ImGuizmo"])
    ],
    dependencies: [
        .package(url: "https://github.com/ctreffs/SwiftImGui.git", .revision("164f3271e784ac09dc23920eb1bca4cfdc2b542d")),
    ],
    targets: [
        .target(name: "ImGuizmo", dependencies: ["CImGuizmo"]),
        .target(name: "CImGuizmo", dependencies: ["CImGui"]),
        .target(name: "AutoWrapper"),
        .testTarget(name: "ImGuizmoTests", dependencies: ["ImGuizmo"])
    ],
    cxxLanguageStandard: .cxx11
)
