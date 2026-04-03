// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_http.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HttpRequestBody {









}




/// Adds pattern-matching-related methods to [HttpRequestBody].
extension HttpRequestBodyPatterns on HttpRequestBody {
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, dynamic>? body)  basic,required TResult Function( Map<String, String>? fields,  Map<String, XFile>? files,  Map<String, List<XFile>>? multifiles)  multipart,}) {final _that = this;
switch (_that) {
case _BasicHttpRequestBody():
return basic(_that.body);case _MultipartHttpRequestBody():
return multipart(_that.fields,_that.files,_that.multifiles);case _:
  throw StateError('Unexpected subclass');

}
}

}

/// @nodoc


class _BasicHttpRequestBody implements HttpRequestBody {
  const _BasicHttpRequestBody([this.body]);
  

 final  Map<String, dynamic>? body;








}




/// @nodoc


class _MultipartHttpRequestBody implements HttpRequestBody {
  const _MultipartHttpRequestBody({this.fields, this.files, this.multifiles});
  

 final  Map<String, String>? fields;
/// The key is the name of the file field, the value is the file to be uploaded.
///
/// We use [XFile] here instead of `File` because it is not supported on web.
 final  Map<String, XFile>? files;
/// The key is the name of the file field, the value is a list of files to be uploaded.
///
/// Use this when you need to upload multiple files with the same field name.
/// We use [XFile] here instead of `File` because it is not supported on web.
 final  Map<String, List<XFile>>? multifiles;








}




// dart format on
