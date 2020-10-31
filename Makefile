imgui_src := 3rdparty/cimguizmo
c_imgui_src := Sources/CImGuizmo
swift_imgui_src := Sources/ImGuizmo
release_dir := .build/release

lint:
	swiftlint autocorrect --format
	swiftlint lint --quiet

lintErrorOnly:
	@swiftlint autocorrect --format --quiet
	@swiftlint lint --quiet | grep error

genLinuxTests:
	swift test --generate-linuxmain
	swiftlint autocorrect --format --path Tests/

test: genLinuxTests
	swift test

submodule:
	git submodule update --init --recursive

updateCLibImGui: submodule

copyLibImGui:
	cp $(imgui_src)/imgui/*.h $(c_imgui_src)/imgui
	cp $(imgui_src)/imgui/*.cpp $(c_imgui_src)/imgui
	cp $(imgui_src)/generator/output/cimgui.h $(c_imgui_src)/include
	cp $(imgui_src)/generator/output/cimgui.cpp $(c_imgui_src)

generateCInterface:
	cd $(imgui_src)/generator && luajit ./generator.lua gcc true sdl glfw glut metal

buildCImGui: updateCLibImGui generateCInterface copyLibImGui

buildAutoWrapper:
	swift build -c release --product AutoWrapper

buildRelease:
	swift build -c release -Xcxx -Wno-modules-import-nested-redundant -Xcxx -Wno-return-type-c-linkage

runCI:
	swift package reset
	swift build -c release -Xcxx -Wno-modules-import-nested-redundant -Xcxx -Wno-return-type-c-linkage -Xcc -Wno-modules-import-nested-redundant -Xcc -Wno-return-type-c-linkage
	swift test -Xcxx -Wno-modules-import-nested-redundant -Xcxx -Wno-return-type-c-linkage -Xcc -Wno-modules-import-nested-redundant -Xcc -Wno-return-type-c-linkage

wrapLibImGui: buildAutoWrapper
	$(release_dir)/AutoWrapper $(imgui_src)/generator/output/definitions.json $(swift_imgui_src)/ImGui+Definitions.swift
	#$(release_dir)/AutoWrapper $(imgui_src)/generator/output/impl_definitions.json $(swift_imgui_src)/ImGui+ImplDefinitions.swift

clean:
	swift package reset
	rm -rdf .swiftpm/xcode
	rm -rdf .build/
	rm Package.resolved
	rm .DS_Store

cleanArtifacts:
	swift package clean

latest:
	swift package update

resolve:
	swift package resolve

genXcode:
	swift package generate-xcodeproj --enable-code-coverage --skip-extra-files 


genXcodeOpen: genXcode
	open *.xcodeproj

precommit: lint genLinuxTests

testReadme:
	markdown-link-check -p -v ./README.md
