import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widget_tester/http_override_example.dart';

void main() {
  testWidgets('verify widget renders Image', (tester) async {
    registerFallbackValue(Uri());

    final mockHttpOverride = MockHttpOverride();
    final mockHttpClient = MockHttpClient();
    final mockHttpClientRequest = MockHttpClientRequest();
    final mockHttpClientResponse = MockHttpClientResponse();

    when(() => mockHttpOverride.createHttpClient(any()))
        .thenReturn(mockHttpClient);

    when(() => mockHttpClient.getUrl(any()))
        .thenAnswer((_) => Future.value(mockHttpClientRequest));

    when(() => mockHttpClientRequest.close())
        .thenAnswer((_) => Future.value(mockHttpClientResponse));

    when(() => mockHttpClientResponse.statusCode).thenReturn(200);

    when(() => mockHttpClientResponse.contentLength)
        .thenReturn(_transparentImage.length);
    when(() => mockHttpClientResponse.compressionState)
        .thenReturn(HttpClientResponseCompressionState.notCompressed);
    when(() => mockHttpClientResponse.listen(
          any(),
          onError: any(named: 'onError'),
          onDone: any(named: 'onDone'),
          cancelOnError: any(named: 'cancelOnError'),
        )).thenAnswer(mockImageStream);

    HttpOverrides.global = mockHttpOverride;

    await tester.pumpWidget(
      const MaterialApp(
        home: HttpOverrideExample(
          imageUrl: '',
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}

final List<int> _transparentImage = <int>[
  // Image bytes.
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE,
];

StreamSubscription<List<int>> mockImageStream(Invocation invocation) {
  final void Function(List<int>)? onData =
      invocation.positionalArguments[0] as void Function(List<int>)?;
  final void Function()? onDone =
      invocation.namedArguments[#onDone] as void Function()?;
  final void Function(Object, [StackTrace?])? onError = invocation
      .namedArguments[#onError] as void Function(Object, [StackTrace?])?;
  final bool? cancelOnError =
      invocation.namedArguments[#cancelOnError] as bool?;

  return Stream<List<int>>.fromIterable(<List<int>>[_transparentImage]).listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );
}

class MockHttpOverride extends Mock implements HttpOverrides {}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockStreamSubscription<T> extends Mock implements StreamSubscription<T> {}
