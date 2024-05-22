import 'dart:async';

import 'package:macros/macros.dart';

macro class TestMacro implements ClassTypesMacro, ClassDeclarationsMacro  {

  const TestMacro();

  @override
  FutureOr<void> buildTypesForClass(ClassDeclaration clazz, ClassTypeBuilder builder) {
    var implName = "${clazz.identifier.name}Impl";
    builder.declareType(implName, DeclarationCode.fromParts([
      "class $implName extends ${clazz.identifier.name} {",
      "  factory $implName({Object? arg = #default_value}) {",
      "    return $implName._(arg: arg == #default_value ? 5 : arg as int?);",
      "  }",
      "  $implName._({int? arg}) : super.name(arg: arg);",
      "}"
    ]));
  }

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) {
    builder.declareInType(DeclarationCode.fromParts([
      "int? arg;",
      "factory ${clazz.identifier.name}({int? arg}) = ${clazz.identifier.name}Impl;",
      "${clazz.identifier.name}.name({this.arg});"
    ]));
  }

}