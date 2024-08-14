// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_http.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HttpRequestBody {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? body) basic,
    required TResult Function(
            Map<String, String>? fields, Map<String, XFile>? files)
        multipart,
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$BasicHttpRequestBodyImpl implements _BasicHttpRequestBody {
  const _$BasicHttpRequestBodyImpl([this.body]);

  @override
  final Map<String, dynamic>? body;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? body) basic,
    required TResult Function(
            Map<String, String>? fields, Map<String, XFile>? files)
        multipart,
  }) {
    return basic(body);
  }
}

abstract class _BasicHttpRequestBody implements HttpRequestBody {
  const factory _BasicHttpRequestBody([final Map<String, dynamic>? body]) =
      _$BasicHttpRequestBodyImpl;

  Map<String, dynamic>? get body;
}

/// @nodoc

class _$MultipartHttpRequestBodyImpl implements _MultipartHttpRequestBody {
  const _$MultipartHttpRequestBodyImpl({this.fields, this.files});

  @override
  final Map<String, String>? fields;

  /// The key is the name of the file field, the value is the file to be uploaded.
  ///
  /// We use [XFile] here instead of `File` because it is not supported on web.
  @override
  final Map<String, XFile>? files;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic>? body) basic,
    required TResult Function(
            Map<String, String>? fields, Map<String, XFile>? files)
        multipart,
  }) {
    return multipart(fields, files);
  }
}

abstract class _MultipartHttpRequestBody implements HttpRequestBody {
  const factory _MultipartHttpRequestBody(
      {final Map<String, String>? fields,
      final Map<String, XFile>? files}) = _$MultipartHttpRequestBodyImpl;

  Map<String, String>? get fields;

  /// The key is the name of the file field, the value is the file to be uploaded.
  ///
  /// We use [XFile] here instead of `File` because it is not supported on web.
  Map<String, XFile>? get files;
}
