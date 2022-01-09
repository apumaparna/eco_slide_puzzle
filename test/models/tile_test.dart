// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:eco_slide_puzzle/models/models.dart';

void main() {
  const String imagePath = 'assets/images/tester.jpg';
  const value = 1;
  const position = Position(x: 1, y: 1);
  const newPosition = Position(x: 2, y: 2);

  group('Tile', () {
    test('supports value comparisons', () {
      expect(
        const Tile(
          imagePath: imagePath,
          value: value,
          correctPosition: position,
          currentPosition: position,
        ),
        const Tile(
          imagePath: imagePath,
          value: value,
          correctPosition: position,
          currentPosition: position,
        ),
      );
    });

    group('copyWith', () {
      test(
          'returns object with updated current position when current position '
          'is passed', () {
        expect(
          Tile(
            imagePath: imagePath,
            value: value,
            correctPosition: position,
            currentPosition: position,
          ).copyWith(currentPosition: newPosition),
          equals(
            Tile(
              imagePath: imagePath,
              value: value,
              correctPosition: position,
              currentPosition: newPosition,
            ),
          ),
        );
      });
    });
  });
}
