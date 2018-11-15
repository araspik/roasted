/**** Types: Defines compile-time properties of expressions.
  * 
  * They provide a set of known properties for expressions.
  * All expressions have types known at compile time, even
  * if the actual value of the expression is not known then.
  * 
  * Different types of expressions have different related
  * types.
  * 
  * All types whose properties are known (which is true for
  * a majority of types) have a defined initializer.
  * 
  * Properties are accessed by indexing the type by the
  * property name.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.types;

import roasted.declarations;
import roasted.scopes;
import roasted.statements;
import roasted.expressions;

import utils.maybe;

/// Defines compile-time properties of expressions.
abstract class Type: Scope {
  /// List of built-in types.
  static IntegralType[string] builtins;

  shared static this() {
    builtins = [
      "bool": new IntegralType(1, false, "bool"),
      "i8": new IntegralType(8, true),
      "u8": new IntegralType(8, false),
      "i16": new IntegralType(16, true),
      "u16": new IntegralType(16, false),
      "i32": new IntegralType(32, true),
      "u32": new IntegralType(32, false),
      "i64": new IntegralType(64, true),
      "u64": new IntegralType(64, false),
      // TODO: 128-bit integral types.
      "inum": new IntegralType(size_t.sizeof * 8,
                true, "inum"),
      "unum": new IntegralType(size_t.sizeof * 8,
                false, "unum"),
      "f32": new IntegralType(32),
      "f64": new IntegralType(64),
      "fbig": new IntegralType(real.sizeof * 8),
    ];
  }

  //- Functions ----------------------------------------//
 @safe nothrow:

  /// Returns a type by name.
  /// Makes Type act like an enum.
  static IntegralType opDispatch(string name)() {
    return builtins[name];
  }

  /// Inlines the type.
  /// This is a dummy replacement as inlining doesn't make
  /// sense.
  override Maybe!Statement inline() pure {
    return maybe!Statement;
  }

}

/// Provides the most baisc built-in types.
final class IntegralType: Type {
  import std.bitmanip: bitfields;

 private {

  mixin(bitfields!(
    bool, "integral_", 1,
    bool, "signed_", 1,
    uint, "size_", 30,
  ));

 }

  //- Properties ---------------------------------------//

 @safe nothrow:

 @property pure {

  /// Whether the type is integral or not.
  bool integral() const nothrow {
    return integral_;
  }

  /// Whether the type is floating-point or not.
  bool floating() const nothrow {
    return !integral_;
  }

  /// Whether the type is signed or not.
  Maybe!bool signed() const {
    if (integral_)
      return maybe!bool(signed_);
    else
      return maybe!bool;
  }

 }

  //- Functions ----------------------------------------//

  /// Constructor for integral types.
  this(uint size, bool signed, string name = null) {
    import std.conv: toChars;
    import std.array: array;

    context = Scope.root;
    this.name = name is null
      ? ((signed ? 'i' : 'u') ~ size.toChars.array).idup
      : name;
    // type is nonexistent
    integral_ = true;
    signed_ = signed;
    size_ = size;
    decls = [
      new ConstantDecl(this, "init",
        new IntegralExp(this, 0)),
      new ConstantDecl(this, "size",
        new IntegralExp(this, size)),
      new ConstantDecl(this, "min",
        new IntegralExp(this, signed ? -(1uL << size) : 0)),
      new ConstantDecl(this, "max",
        new IntegralExp(this, 1 << (size - signed))),
    ];
  }

  /// Constructor for floating-point types.
  this(uint size, string name = null) {
    import roasted.types: Type;
    import std.conv: toChars;
    import std.array: array;

    context = Scope.root;
    this.name = name is null
      ? ('f' ~ (size * 8).toChars.array).idup
      : name;
    // type is nonexistent
    integral_ = false;
    size_ = size;
    decls = [
      new ConstantDecl(this, "init",
        new IntegralExp(this, real.nan)),
      new ConstantDecl(this, "size",
        new IntegralExp(Type.unum, size)),
      new ConstantDecl(this, "min",
        new IntegralExp(this,
            size == 32 ? -float.max
          : size == 64 ? -double.max
          : -real.max)),
      new ConstantDecl(this, "max",
        new IntegralExp(this,
            size == 32 ? float.max
          : size == 64 ? double.max
          : real.max)),
      new ConstantDecl(this, "incr",
        new IntegralExp(this,
            size == 32 ? float.min_normal
          : size == 64 ? double.min_normal
          : real.min_normal)),
    ];
  }
}