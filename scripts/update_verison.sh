#!/bin/bash

# Script to update macOS and Windows versions from version_config.json
# Usage: ./scripts/update_versions.sh

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq first."
    echo "You can install it with: brew install jq"
    exit 1
fi

# Check if version_config.json exists
if [ ! -f "../version_config.json" ]; then
    echo "Error: version_config.json not found in project root"
    exit 1
fi

# Read version info from JSON
VERSION_NAME=$(jq -r '.version.name' ../version_config.json)
MACOS_CODE=$(jq -r '.version.macos.code // .version.windows.code' ../version_config.json)
WINDOWS_CODE=$(jq -r '.version.windows.code // .version.macos.code' ../version_config.json)

# Check if values were read successfully
if [ "$VERSION_NAME" = "null" ] || [ "$MACOS_CODE" = "null" ] || [ "$WINDOWS_CODE" = "null" ]; then
    echo "Error: Could not read version information from JSON file"
    exit 1
fi

echo "Updating versions to: $VERSION_NAME"
echo "macOS build number: $MACOS_CODE"
echo "Windows build number: $WINDOWS_CODE"
echo ""

# Update macOS version
echo "Updating macOS version..."
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $VERSION_NAME" ../macos/Runner/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $MACOS_CODE" ../macos/Runner/Info.plist
echo "✓ macOS version updated successfully!"
echo "  CFBundleShortVersionString: $VERSION_NAME"
echo "  CFBundleVersion: $MACOS_CODE"
echo ""

# Update Windows version
echo "Updating Windows version..."
sed -i '' "s/#define VERSION_AS_STRING \".*\"/#define VERSION_AS_STRING \"$VERSION_NAME\"/" ../windows/runner/Runner.rc
sed -i '' "s/#define VERSION_AS_NUMBER .*/#define VERSION_AS_NUMBER ${WINDOWS_CODE}/" ../windows/runner/Runner.rc
echo "✓ Windows version updated successfully!"
echo "  VERSION_AS_STRING: $VERSION_NAME"
echo "  VERSION_AS_NUMBER: $WINDOWS_CODE"
echo ""

# Update pubspec.yaml
echo "Updating pubspec.yaml..."
sed -i '' "s/version: .*/version: $VERSION_NAME/" ../pubspec.yaml
echo "✓ pubspec.yaml updated successfully!"
echo "  version: $VERSION_NAME"
echo ""

# Update AppVersion.dart
echo "Updating AppVersion.dart..."
sed -i '' "s/static const String appVersion = '[^']*';/static const String appVersion = '$VERSION_NAME';/" ../lib/core/data/constants/app_versions.dart
echo "✓ AppVersion.dart updated successfully!"
echo "  AppVersion.value: $VERSION_NAME"
echo ""

echo "🎉 macOS and Windows versions updated successfully!"
echo "Next steps:"
echo "  - For macOS: Rebuild your project in Xcode"
echo "  - For Windows: Rebuild your project"
echo "  - Run 'flutter pub get' if pubspec.yaml changed"