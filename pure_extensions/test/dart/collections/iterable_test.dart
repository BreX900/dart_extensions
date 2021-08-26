import 'package:pure_extensions/src/dart/collections/iterable.dart';
import 'package:test/test.dart';

void main() {
  group('Test iterable extensions', () {
    group('Iterable.withoutNull', () {
      test('omit all null elements', () {
        final iterable = [0, null, 2, null];

        final res = iterable.whereNotNull();

        expect(res.toList(), [0, 2]);
      });
    });

    group('Iterable.joinElement', () {
      test('add 0 separator in empty array', () {
        final iterable = [];

        final res = iterable.joinElement(0);

        expect(res.toList(), []);
      });

      test('add 0 separator in array with one element', () {
        final iterable = [1];

        final res = iterable.joinElement(0);

        expect(res.toList(), [1]);
      });

      test('add 0 separator in array with two elements', () {
        final iterable = [1, 2];

        final res = iterable.joinElement(0);

        expect(res.toList(), [1, 0, 2]);
      });

      test('add 0 separator in array with four elements', () {
        final iterable = [1, 2, 3, 4];

        final res = iterable.joinElement(0);

        expect(res.toList(), [1, 0, 2, 0, 3, 0, 4]);
      });
    });

    group('Iterable.mapWithIndex', () {
      test('mapWithIndex full list', () {
        final iterable = ['first'];

        final res = iterable.mapWithIndex((e, i) => i);

        expect(res.toList(), [0]);
      });

      test('mapWithIndex empty list', () {
        final iterable = [];

        final res = iterable.mapWithIndex((e, i) => i);

        expect(res.toList(), []);
      });
    });
  });
}
