# Object Mapper

![Coverage](https://raw.githubusercontent.com/markgravity/object_mapper/master/coverage_badge.svg?sanitize=true) [![GitHub issues](https://img.shields.io/github/issues/markgravity/object_mapper)](https://github.com/markgravity/object_mapper/issues) [![GitHub stars](https://img.shields.io/github/stars/markgravity/object_mapper)](https://github.com/markgravity/object_mapper/stargazers) [![GitHub license](https://img.shields.io/github/license/markgravity/object_mapper)](https://github.com/markgravity/object_mapper/blob/master/LICENSE)

---

A package written in Dart that makes it easy for you to convert your model objects to and from JSON.
It's inspired by [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)

**object_mapper vs json_annotation**

- No extras file (`*.g.dart`), no need to use `builder_runner`
- Re-usable `Transform` (known as `Converter` in json_annotation) with `generic`

## Implement
- **Step 1**: Extend your class with `Mappable` mixin
```dart
class TestInfo with Mappable {
    //
}

```



- **Step 2**: Override `Mappable.mapping` method & add your map functions. Check more [use cases](#map---use-cases) here
```dart
class TestInfo with Mappable {
 int id;
  
 @override
 void mapping(Mapper map) {
  map("id", id, (v) => id = v);
 }
}

```

* **Step 3**: Register factory for new model into `Mappable.factories`

  ```dart
  Mappable.factories = {
    TestInfo: () => TestInfo()
  };
  ```


## Usage

- **Map to Object**
```dart
final json = {
 "id" : 2
};

final info = Mapper.fromJson(json).toObject<TestInfo>();
print(info.id); // 2
```

- **Object to Map**
```dart
final info = TestInfo();
info.id = 2;
final json = info.toJson();
print(json); // { "id": 2 }
```



## Map - Use Cases

- `int`, `string`, `numeric`, `bool`
```dart
void mapping(Mapper map) {
 map("field", field, (v) => field = v);
}
```
- `List` of number or bool
```dart
void mapping(Mapper map) {
 map("field", field, (v) => field = v.cast<int>());
}
```
- `List` of object or nested object
```dart
void mapping(Mapper map) {
 map<ObjectClass>("field", field, (v) => field = v);
}
```
- With transform, such as `DateTransform`, `EnumTransform`
```dart
DateTime time;
void mapping(Mapper map) {
 map("time", time, (v) => time = v, DateTransform());
}
```



## Custom transform

Implement your class with `Transformable`
```dart
class EnumTransform<Object extends Enumerable, JSON>
    with Transformable<Object, JSON> {
  Object fromJson(value) {
    if (value == null || !(value is JSON)) return null;
    return RawRepresentable(Object, value);
  }

  JSON toJson(Object value) {
    if (value == null) return null;
    return value.rawValue;
  }
}
```