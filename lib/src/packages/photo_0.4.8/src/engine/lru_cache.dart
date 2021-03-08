import 'dart:collection';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

LRUMap<_ImageCacheEntity, Uint8List> _map = LRUMap(500);

Uint8List? getData(AssetEntity? entity, [int? size = 64]) {
  return _map.get(_ImageCacheEntity(entity, size));
}

void setData(AssetEntity? entity, int? size, Uint8List list) {
  _map.put(_ImageCacheEntity(entity, size), list);
}

class _ImageCacheEntity {
  _ImageCacheEntity(this.entity, this.size);

  AssetEntity? entity;
  int? size;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ImageCacheEntity &&
          runtimeType == other.runtimeType &&
          entity == other.entity &&
          size == other.size;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => entity.hashCode ^ size.hashCode;
}

// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

typedef EvictionHandler<K, V> = Function(K key, V value);

class LRUMap<K, V> {
  LRUMap(this._maxSize, [this._handler]);

  final LinkedHashMap<K, V> _map = LinkedHashMap<K, V>();
  final int _maxSize;
  final EvictionHandler<K, V?>? _handler;

  V? get(K key) {
    final value = _map.remove(key);
    if (value != null) {
      _map[key] = value;
    }
    return value;
  }

  void put(K key, V value) {
    _map.remove(key);
    _map[key] = value;
    if (_map.length > _maxSize) {
      final evictedKey = _map.keys.first;
      final evictedValue = _map.remove(evictedKey);
      if (_handler != null) {
        _handler!(evictedKey, evictedValue);
      }
    }
  }

  void remove(K key) {
    _map.remove(key);
  }
}
