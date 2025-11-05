# Setup Guide

This guide provides detailed instructions for setting up and configuring your Flutter BLoC Boilerplate project.

## Table of Contents

- [Initial Setup](#initial-setup)
- [Setup Script Usage](#setup-script-usage)
- [Manual Configuration](#manual-configuration)
- [Platform-Specific Setup](#platform-specific-setup)
- [Troubleshooting](#troubleshooting)

## Initial Setup

### 1. Prerequisites

Before you begin, ensure you have the following installed:

```bash
# Check Flutter version
flutter --version
# Required: Flutter 2.12.0 or higher

# Check Dart version
dart --version
# Required: Dart 2.12.0 or higher
```

### 2. Clone the Repository

```bash
git clone <repository-url>
cd flutter-boiler-plate
```

## Setup Script Usage

The setup script is the **recommended way** to configure your project. It automatically updates all necessary files across your entire project.

### Basic Usage

```bash
dart run tool/setup.dart
```

You'll be prompted for three pieces of information:

#### 1. App Display Name
- **Example**: `"My Awesome App"`, `"Todo Manager"`, `"E-Commerce App"`
- **Usage**: This is the name users see on their device home screen
- **Validation**: Can contain spaces and special characters

#### 2. Package Name
- **Example**: `com.company.myapp`, `com.example.todoapp`
- **Usage**: Unique identifier for your app on app stores
- **Format**: Must follow reverse domain notation
- **Validation**: Lowercase letters, dots only, no spaces
- **Common patterns**:
  - `com.yourcompany.appname`
  - `com.github.username.appname`
  - `org.yourorg.appname`

#### 3. Project Name
- **Example**: `my_awesome_app`, `todo_manager`, `ecommerce_app`
- **Usage**: Package name in pubspec.yaml and Dart imports
- **Format**: snake_case only
- **Validation**: Lowercase letters, numbers, and underscores only

### Example Session

```bash
$ dart run tool/setup.dart

============================================================
  🚀 Flutter BLoC Boilerplate Setup
============================================================

📝 Please provide the following information:

App Display Name (e.g., "My Awesome App"): My Todo App
Package Name (e.g., "com.company.myapp"): com.example.todoapp
Project Name (e.g., "my_awesome_app"): my_todo_app

------------------------------------------------------------
📋 Configuration Summary:
------------------------------------------------------------
  App Display Name: My Todo App
  Package Name:     com.example.todoapp
  Project Name:     my_todo_app
------------------------------------------------------------

Do you want to proceed with these settings? (y/n): y

🔄 Updating project files...

  📄 Updating pubspec.yaml...
     ✓ pubspec.yaml updated
  📄 Updating Dart files...
     ✓ Updated 68 Dart files
  📱 Updating Android configuration...
     ✓ build.gradle updated
     ✓ AndroidManifest.xml updated
     ✓ MainActivity.kt updated
  🍎 Updating iOS configuration...
     ✓ Info.plist updated
     ✓ project.pbxproj updated

============================================================
  ✅ Setup completed successfully!
============================================================

📚 Next steps:
  1. Run: flutter pub get
  2. Run: flutter run

💡 Tip: Check README.md for more information
```

### Dry Run Mode

Preview changes without modifying any files:

```bash
dart run tool/setup.dart --dry-run
```

This will show you:
- What files will be updated
- What changes will be made
- No actual modifications

## What the Script Updates

### Dart/Flutter Files
- ✅ `pubspec.yaml` - Project name
- ✅ All `.dart` files in `lib/` - Package imports
- ✅ All `.dart` files in `test/` - Package imports

### Android Files
- ✅ `android/app/build.gradle`
  - `namespace`
  - `applicationId`
- ✅ `android/app/src/main/AndroidManifest.xml`
  - `package` attribute
  - `android:label` attribute
- ✅ `android/app/src/main/kotlin/.../MainActivity.kt`
  - Package declaration
  - File location (moved to match new package structure)

### iOS Files
- ✅ `ios/Runner/Info.plist`
  - `CFBundleName`
  - `CFBundleDisplayName`
- ✅ `ios/Runner.xcodeproj/project.pbxproj`
  - `PRODUCT_BUNDLE_IDENTIFIER` (all occurrences)

## Manual Configuration

If you prefer to configure manually or need to update specific parts:

### Update pubspec.yaml

```yaml
name: your_project_name  # Change this
description: Your project description
```

### Update Dart Imports

Find and replace across all `.dart` files:
```dart
// Old
import 'package:flutter_bloc_boilerplate/...';

// New
import 'package:your_project_name/...';
```

### Update Android

**android/app/build.gradle:**
```gradle
android {
    namespace = "com.yourcompany.yourapp"
    
    defaultConfig {
        applicationId "com.yourcompany.yourapp"
    }
}
```

**android/app/src/main/AndroidManifest.xml:**
```xml
<manifest package="com.yourcompany.yourapp">
    <application android:label="Your App Name">
    </application>
</manifest>
```

**MainActivity.kt:**
```kotlin
package com.yourcompany.yourapp

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
```

### Update iOS

**ios/Runner/Info.plist:**
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
<key>CFBundleName</key>
<string>your_app_name</string>
```

## Platform-Specific Setup

### Android

#### 1. Update Signing Configuration

If using custom signing, update `android/key.properties`:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=your_key_alias
storeFile=path/to/your/keystore.jks
```

#### 2. Update Gradle Versions (if needed)

Check `android/build.gradle` for compatibility with your environment.

### iOS

#### 1. Open in Xcode

```bash
open ios/Runner.xcworkspace
```

#### 2. Update Bundle Identifier

1. Select Runner in Project Navigator
2. Go to "Signing & Capabilities"
3. Update Bundle Identifier to match your package name

#### 3. Update Display Name

1. Select Runner in Project Navigator
2. Go to "General" tab
3. Update Display Name

### Clean Build Files

After configuration, clean and rebuild:

```bash
# Flutter clean
flutter clean

# Get dependencies
flutter pub get

# For iOS, also update pods
cd ios
pod install
cd ..

# Run the app
flutter run
```

## Troubleshooting

### Issue: "Package name doesn't match"

**Solution**: Ensure all package references are updated:
```bash
# Search for old package name
grep -r "flutter_bloc_boilerplate" lib/ test/
```

### Issue: "Build failed after setup"

**Solution**: Clean and rebuild:
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

### Issue: "iOS build errors"

**Solution**: 
1. Open `ios/Runner.xcworkspace` in Xcode
2. Product → Clean Build Folder
3. Close Xcode
4. Run `flutter run` again

### Issue: "Android signing errors"

**Solution**: 
1. Check `android/key.properties` exists and is correct
2. Verify keystore file path
3. Update passwords if changed

### Issue: "MainActivity not found"

**Solution**: 
1. Verify `MainActivity.kt` is in correct directory matching package structure
2. Check package declaration matches your package name
3. Rebuild project: `flutter clean && flutter run`

## After Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Launch Icons (Optional)

If you want custom app icons:

1. Add `flutter_launcher_icons` to `dev_dependencies`
2. Configure in `pubspec.yaml`
3. Run: `flutter pub run flutter_launcher_icons:main`

### 3. Setup Firebase (Optional)

If using Firebase:

1. Create project in Firebase Console
2. Download `google-services.json` (Android)
3. Download `GoogleService-Info.plist` (iOS)
4. Add to respective directories
5. Update dependencies

### 4. Environment Variables

Create `.env` file for sensitive data:

```bash
# .env
API_BASE_URL=https://api.yourapp.com
API_KEY=your_api_key
STRIPE_KEY=your_stripe_key
```

Don't forget to add `.env` to `.gitignore`!

### 5. Version Control

Initialize git if not already done:

```bash
git init
git add .
git commit -m "Initial commit: Configured boilerplate for [Your App Name]"
```

## Best Practices

1. **Run Setup Script First**: Always run the setup script before making manual changes
2. **Test After Setup**: Run the app on both platforms after configuration
3. **Commit After Setup**: Make a commit after successful setup for easy rollback
4. **Document Changes**: Keep track of any manual modifications
5. **Update README**: Update the main README with your project-specific information

## Need Help?

If you encounter issues not covered here:

1. Check the main [README.md](README.md)
2. Review Flutter documentation
3. Open an issue on GitHub
4. Check existing issues for solutions

---

**Note**: This guide assumes you're using the latest stable version of Flutter. If using older versions, some steps might differ slightly.

