import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wallpaper_manager_flutter_example/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Wallpaper selection and setting test", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WallpaperExampleApp());

    // Verify app starts at the main screen
    expect(find.text("Wallpaper Manager Demo"), findsOneWidget);

    // Check if images are displayed
    expect(find.byType(Image), findsWidgets);

    // Swipe to the second wallpaper
    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.byType(PageView), findsOneWidget);

    // Tap the "Home" button
    await tester.tap(find.widgetWithText(ElevatedButton, "Home"));
    await tester.pump(); // Allow UI to update

    // Simulate successful wallpaper set (wait for UI update)
    await tester.pumpAndSettle();

    // Verify success message appears
    expect(find.textContaining("Wallpaper set successfully!"), findsOneWidget);
  });
}
