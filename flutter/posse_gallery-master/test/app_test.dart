import 'package:flutter_test/flutter_test.dart';

import 'package:posse_gallery/main.dart';

void main() {
  testWidgets('app should start', (WidgetTester tester) async {
    tester.pumpWidget(new GalleryApp());
  });
}
