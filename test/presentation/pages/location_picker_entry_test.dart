import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart'
    as geocoding_pi;
import 'package:geolocator/geolocator.dart';
import 'package:n42_chat/l10n/app_localizations.dart';
import 'package:n42_chat/src/presentation/pages/chat/location_picker_page.dart';

class _PositionSource extends GeolocatorPlatform {
  @override
  Future<bool> isLocationServiceEnabled() async => true;
  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.whileInUse;
  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async => Position(
    longitude: 20,
    latitude: 10,
    timestamp: DateTime(2026),
    accuracy: 1,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

class _Places extends geocoding_pi.GeocodingPlatformFactory {
  bool unavailable = false;
  final queries = <String, Completer<List<Location>>>{};
  final requestedCoordinates = <({double latitude, double longitude})>[];
  @override
  geocoding_pi.Geocoding createGeocoding(
    geocoding_pi.GeocodingCreationParams params,
  ) => _PlacesClient(this);
}

class _PlacesClient extends geocoding_pi.Geocoding {
  _PlacesClient(this.places)
    : super.implementation(const geocoding_pi.GeocodingCreationParams());

  final _Places places;

  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    Locale? locale,
  }) => (places.queries[address] = Completer<List<Location>>()).future;

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    Locale? locale,
  }) async => const [];

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    Locale? locale,
  }) async {
    places.requestedCoordinates.add((latitude: latitude, longitude: longitude));
    if (places.unavailable) throw StateError('Geocoder unavailable');
    return [Placemark(name: 'Place $latitude', street: 'Street $latitude')];
  }
}

class _TransparentTileProvider extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) =>
      MemoryImage(TileProvider.transparentImage);
}

void main() {
  late _Places places;
  setUp(() {
    final originalPosition = GeolocatorPlatform.instance;
    final originalPlaces = geocoding_pi.GeocodingPlatformFactory.instance;
    addTearDown(() {
      GeolocatorPlatform.instance = originalPosition;
      geocoding_pi.GeocodingPlatformFactory.instance =
          originalPlaces ?? _Places();
    });
    GeolocatorPlatform.instance = _PositionSource();
    geocoding_pi.GeocodingPlatformFactory.instance = places = _Places();
  });

  testWidgets('unavailable geocoder preserves usable coordinates', (
    tester,
  ) async {
    places.unavailable = true;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: ChatLocationPickerPage(tileProvider: _TransparentTileProvider()),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('10.000000, 20.000000'), findsOneWidget);
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Send'))
          .onPressed,
      isNotNull,
    );
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets(
    'current position has no invented nearby POIs and stale searches are ignored',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          home: ChatLocationPickerPage(
            tileProvider: _TransparentTileProvider(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Nearby Place 1'), findsNothing);
      expect(find.text('Nearby Place 2'), findsNothing);
      expect(find.text('My location'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'old');
      await tester.pump(const Duration(milliseconds: 550));
      await tester.enterText(find.byType(TextField), 'new');
      await tester.pump(const Duration(milliseconds: 550));
      places.queries['new']!.complete([
        Location(latitude: 30, longitude: 40, timestamp: DateTime(2026)),
      ]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Place 30.0'), findsOneWidget);
      places.queries['old']!.complete([
        Location(latitude: 50, longitude: 60, timestamp: DateTime(2026)),
      ]);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Place 30.0'), findsOneWidget);
      expect(find.text('Place 50.0'), findsNothing);
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();
      expect(find.text('My location'), findsOneWidget);
      expect(find.text('Place 30.0'), findsNothing);
      await tester.pumpWidget(const SizedBox());
    },
  );
  testWidgets('relocate sends GPS coordinates and invalidates pending search', (
    tester,
  ) async {
    Map<String, dynamic>? selected;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              selected = await Navigator.of(context).push<Map<String, dynamic>>(
                MaterialPageRoute(
                  builder: (_) => ChatLocationPickerPage(
                    tileProvider: _TransparentTileProvider(),
                  ),
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.enterText(find.byType(TextField), 'destination');
    await tester.pump(const Duration(milliseconds: 550));
    places.queries['destination']!.complete([
      Location(latitude: 30, longitude: 40, timestamp: DateTime(2026)),
    ]);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Place 30.0'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'pending');
    await tester.pump(const Duration(milliseconds: 550));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    places.queries['pending']!.complete([
      Location(latitude: 50, longitude: 60, timestamp: DateTime(2026)),
    ]);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('My location'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
    await tester.tap(find.text('Send'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(selected?['latitude'], 10);
    expect(selected?['longitude'], 20);
    expect(selected?['address'], 'Street 10.0');
  });

  testWidgets('dragging the map sends its visible center', (tester) async {
    Map<String, dynamic>? selected;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              selected = await Navigator.of(context).push<Map<String, dynamic>>(
                MaterialPageRoute(
                  builder: (_) => ChatLocationPickerPage(
                    tileProvider: _TransparentTileProvider(),
                  ),
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    final map = find.byType(FlutterMap);
    await tester.ensureVisible(map);
    await tester.dragFrom(
      tester.getTopLeft(map) + const Offset(80, 100),
      const Offset(120, 0),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Send'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(selected, isNotNull);
    expect(places.requestedCoordinates, isNotEmpty);
    final resolvedCenter = places.requestedCoordinates.last;
    expect(resolvedCenter.latitude, isNot(10));
    expect(resolvedCenter.longitude, isNot(20));
    expect(selected!['latitude'], resolvedCenter.latitude);
    expect(selected!['longitude'], resolvedCenter.longitude);
  });
}
