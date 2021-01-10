import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

/// Implement a multi platform interface to be able to read a file (network/local/memory/...).
abstract class ReadableFile {
  /// The file size in bytes.
  Future<int> get size;

  /// File name including its extension.
  String get name;

  /// File extension for this file.
  String get extension => name?.split('.')?.last;

  /// Read the entire file contents as a list of bytes.
  Future<Uint8List> readBytes();

  /// Create a new independent [Stream] for the contents of this file.
  Stream<List<int>> onReadBytes();
}

class NetworkReadableFile extends ReadableFile {
  final String uri;

  /// [ReadableFile.size]
  final Future<int> size;

  /// [ReadableFile.name]
  final String name;

  NetworkReadableFile({
    @required this.uri,
    int size,
    @required this.name,
  })  : assert(uri != null),
        assert(name != null),
        size = Future.value(size);

  /// [ReadableFile.readBytes]
  @override
  Future<Uint8List> readBytes() {
    throw UnimplementedError();
  }

  /// [ReadableFile.onReadBytes]
  @override
  Stream<List<int>> onReadBytes() {
    throw UnimplementedError();
  }
}

class MemoryReadableFile extends ReadableFile {
  final Uint8List bytes;

  /// [ReadableFile.name]
  final String name;

  MemoryReadableFile({@required this.bytes, @required this.name})
      : assert(bytes != null),
        assert(name != null);

  /// [ReadableFile.size]
  @override
  Future<int> get size async => bytes.length;

  /// [ReadableFile.readBytes]
  @override
  Future<Uint8List> readBytes() async => bytes;

  /// [ReadableFile.onReadBytes]
  @override
  Stream<List<int>> onReadBytes() async* {
    yield bytes;
  }
}

class StreamReadableFile extends ReadableFile {
  final Stream<Uint8List> bytesStream;

  /// [ReadableFile.size]
  final Future<int> size;

  /// [ReadableFile.name]
  final String name;

  StreamReadableFile({@required this.bytesStream, this.size, @required this.name})
      : assert(bytesStream != null),
        assert(name != null);

  /// [ReadableFile.readBytes]
  @override
  Future<Uint8List> readBytes() {
    return bytesStream.reduce((previous, element) => Uint8List.fromList([...previous, ...element]));
  }

  /// [ReadableFile.onReadBytes]
  @override
  Stream<List<int>> onReadBytes() => bytesStream;
}

class LocalReadableFile extends ReadableFile {
  final File file;

  LocalReadableFile({@required this.file}) : assert(file != null);

  /// [ReadableFile.size]
  @override
  Future<int> get size => file.length();

  /// [ReadableFile.name]
  @override
  String get name => file.path.split('/').last;

  /// [ReadableFile.readBytes]
  @override
  Future<Uint8List> readBytes() => file.readAsBytes();

  /// [ReadableFile.onReadBytes]
  @override
  Stream<List<int>> onReadBytes() => file.openRead();
}
