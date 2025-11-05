import 'dart:io';

void main(List<String> arguments) async {
  print('\n' + '=' * 60);
  print('  🚀 Flutter BLoC Boilerplate Setup');
  print('=' * 60 + '\n');

  final isDryRun = arguments.contains('--dry-run');

  if (isDryRun) {
    print('ℹ️  Running in DRY RUN mode - no files will be modified\n');
  }

  // Collect user inputs
  print('📝 Please provide the following information:\n');

  final appDisplayName = _promptInput(
    'App Display Name (e.g., "My Awesome App")',
    validator: (value) =>
        value.isNotEmpty ? null : 'App display name cannot be empty',
  );

  final packageName = _promptInput(
    'Package Name (e.g., "com.company.myapp")',
    validator: _validatePackageName,
  );

  final projectName = _promptInput(
    'Project Name (e.g., "my_awesome_app")',
    validator: _validateProjectName,
  );

  // Show confirmation
  print('\n' + '-' * 60);
  print('📋 Configuration Summary:');
  print('-' * 60);
  print('  App Display Name: $appDisplayName');
  print('  Package Name:     $packageName');
  print('  Project Name:     $projectName');
  print('-' * 60 + '\n');

  if (!_confirm('Do you want to proceed with these settings?')) {
    print('❌ Setup cancelled.');
    exit(0);
  }

  if (isDryRun) {
    print('\n✅ Dry run completed. No files were modified.');
    _showDryRunChanges(appDisplayName, packageName, projectName);
    exit(0);
  }

  // Perform actual updates
  print('\n🔄 Updating project files...\n');

  try {
    await _updatePubspec(projectName);
    await _updateDartFiles(projectName);
    await _updateAndroidFiles(appDisplayName, packageName);
    await _updateiOSFiles(appDisplayName, packageName, projectName);

    print('\n' + '=' * 60);
    print('  ✅ Setup completed successfully!');
    print('=' * 60);
    print('\n📚 Next steps:');
    print('  1. Run: flutter pub get');
    print('  2. Run: flutter run');
    print('\n💡 Tip: Check README.md for more information\n');
  } catch (e) {
    print('\n❌ Error during setup: $e');
    exit(1);
  }
}

String _promptInput(String prompt, {String? Function(String)? validator}) {
  while (true) {
    stdout.write('$prompt: ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (validator != null) {
      final error = validator(input);
      if (error != null) {
        print('  ⚠️  $error');
        continue;
      }
    }

    return input;
  }
}

String? _validatePackageName(String value) {
  if (value.isEmpty) return 'Package name cannot be empty';

  final regex = RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$');
  if (!regex.hasMatch(value)) {
    return 'Invalid package name. Use format: com.company.appname (lowercase, dots only)';
  }

  return null;
}

String? _validateProjectName(String value) {
  if (value.isEmpty) return 'Project name cannot be empty';

  final regex = RegExp(r'^[a-z][a-z0-9_]*$');
  if (!regex.hasMatch(value)) {
    return 'Invalid project name. Use snake_case (lowercase letters, numbers, underscores only)';
  }

  return null;
}

bool _confirm(String message) {
  while (true) {
    stdout.write('$message (y/n): ');
    final input = stdin.readLineSync()?.trim().toLowerCase();

    if (input == 'y' || input == 'yes') return true;
    if (input == 'n' || input == 'no') return false;

    print('  ⚠️  Please answer with y (yes) or n (no)');
  }
}

Future<void> _updatePubspec(String projectName) async {
  print('  📄 Updating pubspec.yaml...');

  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    throw Exception('pubspec.yaml not found');
  }

  var content = await file.readAsString();
  content = content.replaceAll(
    RegExp(r'^name:.*$', multiLine: true),
    'name: $projectName',
  );

  await file.writeAsString(content);
  print('     ✓ pubspec.yaml updated');
}

Future<void> _updateDartFiles(String projectName) async {
  print('  📄 Updating Dart files...');

  final libDir = Directory('lib');
  final testDir = Directory('test');

  int fileCount = 0;

  // Update lib directory
  if (libDir.existsSync()) {
    await for (final entity in libDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        await _updateDartFile(entity, projectName);
        fileCount++;
      }
    }
  }

  // Update test directory
  if (testDir.existsSync()) {
    await for (final entity in testDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        await _updateDartFile(entity, projectName);
        fileCount++;
      }
    }
  }

  print('     ✓ Updated $fileCount Dart files');
}

Future<void> _updateDartFile(File file, String projectName) async {
  var content = await file.readAsString();

  // Replace package imports
  content = content.replaceAll(
    'package:flutter_bloc_boilerplate/',
    'package:$projectName/',
  );

  await file.writeAsString(content);
}

Future<void> _updateAndroidFiles(
    String appDisplayName, String packageName) async {
  print('  📱 Updating Android configuration...');

  // Update build.gradle
  final buildGradle = File('android/app/build.gradle');
  if (buildGradle.existsSync()) {
    var content = await buildGradle.readAsString();

    content = content.replaceAll(
      RegExp(r'namespace = ".*"'),
      'namespace = "$packageName"',
    );

    content = content.replaceAll(
      RegExp(r'applicationId ".*"'),
      'applicationId "$packageName"',
    );

    await buildGradle.writeAsString(content);
    print('     ✓ build.gradle updated');
  }

  // Update AndroidManifest.xml
  final manifest = File('android/app/src/main/AndroidManifest.xml');
  if (manifest.existsSync()) {
    var content = await manifest.readAsString();

    content = content.replaceAll(
      RegExp(r'package=".*"'),
      'package="$packageName"',
    );

    content = content.replaceAll(
      RegExp(r'android:label=".*"'),
      'android:label="$appDisplayName"',
    );

    await manifest.writeAsString(content);
    print('     ✓ AndroidManifest.xml updated');
  }

  // Update MainActivity.kt
  await _updateMainActivity(packageName);
}

Future<void> _updateMainActivity(String packageName) async {
  // Find MainActivity.kt
  final kotlinDir = Directory('android/app/src/main/kotlin');
  if (!kotlinDir.existsSync()) {
    print('     ⚠️  Kotlin directory not found, skipping MainActivity');
    return;
  }

  File? mainActivityFile;
  await for (final entity in kotlinDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('MainActivity.kt')) {
      mainActivityFile = entity;
      break;
    }
  }

  if (mainActivityFile == null) {
    // Create new MainActivity
    final packagePath = packageName.replaceAll('.', '/');
    final newDir = Directory('android/app/src/main/kotlin/$packagePath');
    await newDir.create(recursive: true);

    mainActivityFile = File('${newDir.path}/MainActivity.kt');
    await mainActivityFile.writeAsString('''
package $packageName

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
''');
    print('     ✓ MainActivity.kt created');
  } else {
    // Update existing MainActivity
    var content = await mainActivityFile.readAsString();
    content = content.replaceAll(
      RegExp(r'^package .*$', multiLine: true),
      'package $packageName',
    );

    // Move to new location
    final packagePath = packageName.replaceAll('.', '/');
    final newDir = Directory('android/app/src/main/kotlin/$packagePath');
    await newDir.create(recursive: true);

    final newFile = File('${newDir.path}/MainActivity.kt');
    await newFile.writeAsString(content);

    // Delete old file if different location
    if (mainActivityFile.path != newFile.path) {
      await mainActivityFile.delete();
    }

    print('     ✓ MainActivity.kt updated');
  }
}

Future<void> _updateiOSFiles(
    String appDisplayName, String packageName, String projectName) async {
  print('  🍎 Updating iOS configuration...');

  // Update Info.plist
  final infoPlist = File('ios/Runner/Info.plist');
  if (infoPlist.existsSync()) {
    var content = await infoPlist.readAsString();

    content = content.replaceAll(
      RegExp(r'<key>CFBundleDisplayName</key>\s*<string>.*</string>'),
      '<key>CFBundleDisplayName</key>\n\t<string>$appDisplayName</string>',
    );

    content = content.replaceAll(
      RegExp(r'<key>CFBundleName</key>\s*<string>.*</string>'),
      '<key>CFBundleName</key>\n\t<string>$projectName</string>',
    );

    await infoPlist.writeAsString(content);
    print('     ✓ Info.plist updated');
  }

  // Update project.pbxproj
  final pbxproj = File('ios/Runner.xcodeproj/project.pbxproj');
  if (pbxproj.existsSync()) {
    var content = await pbxproj.readAsString();

    content = content.replaceAll(
      RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = .*;'),
      'PRODUCT_BUNDLE_IDENTIFIER = $packageName;',
    );

    await pbxproj.writeAsString(content);
    print('     ✓ project.pbxproj updated');
  }
}

void _showDryRunChanges(
    String appDisplayName, String packageName, String projectName) {
  print('\n📝 The following changes would be made:');
  print('\n  Files to update:');
  print('    • pubspec.yaml');
  print('    • All Dart files in lib/ and test/');
  print('    • android/app/build.gradle');
  print('    • android/app/src/main/AndroidManifest.xml');
  print('    • android/app/src/main/kotlin/.../MainActivity.kt');
  print('    • ios/Runner/Info.plist');
  print('    • ios/Runner.xcodeproj/project.pbxproj');
  print('\n  Run without --dry-run to apply these changes.');
}

