# isar_learning

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


[isar quick start](https://isar.dev/tutorials/quickstart.html)

## 1. Add dependencies
Before the fun begins, we need to add a few packages to the `pubspec.yaml` We can use pub to do the heavy lifting for us.
```
flutter pub add isar isar_flutter_libs
flutter pub add -d isar_generator build_runner
```

## 2. Annotate classes

Annotate your collection classes with `@collection` and choose an `Id` field.

```
part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;

  int? age;
}
```
Ids uniquely identify objects in a collection and allow you to find them again later.

## 3. Run code generator

Execute the following command to start the build_runner:

```
dart run build_runner build
```
If you are using Flutter, use the following:

```
flutter pub run build_runner build
```

```
dart run build_runner build --delete-conflicting-outputs
```