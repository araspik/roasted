/**** Integral types: Provide the most basic builtin types.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.types.integral;

import roasted.types;
import roasted.symbols;
import roasted.declarations;

import std.bitmanip;
import std.typecons;
import std.exception: assumeWontThrow;
import std.format: format;

/// Provides the most basic builtin types.
class IntegralType: Type {

  //- Variables ----------------------------------------//

 private {

  mixin(bitfields!(
    bool, "isIntegral", 1,
    bool, "signedness", 1,
    uint, "_size",      6,
  ));

 }

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  /// Whether the type is integral or not.
  bool integral() const {
    return isIntegral;
  }

  /// Whether the type is floating-point or not.
  bool floating() const {
    return !isIntegral;
  }

  /// Whether the type is signed or not.
  Nullable!bool signed() const {
    return integral
      ? nullable!bool(signedness)
      : Nullable!bool();
  }

  /// Whether the type is unsigned or not.
  Nullable!bool unsigned() const {
    return integral
      ? nullable(!signedness)
      : Nullable!bool();
  }

 }

  //- Functions ----------------------------------------//

  /**** Constructor for integral types.
    *
    */
  this(uint size, bool signed) {
    super(new Symbol(
      format!"%c%u"d(signed ? 'i' : 'u', size)
      .assumeWontThrow));
    this._size = size;
    this.isIntegral = true;
    this.signedness = signed;
  }

  /**** Constructor for floating-point types.
    * 
    */
  this(uint size) {
    super(new Symbol(format!"f%u"d(size)
      .assumeWontThrow));
    this._size = size;
    this.isIntegral = false;
  }

  /**** Constructor for named integral types.
    * 
    */
  this(dstring name, uint size, bool signed) {
    super(new Symbol(name));
    this._size = size;
    this.isIntegral = true;
    this.signedness = signed;
  }

  /**** Exposes properties of the type.
    * 
    */
  override Nullable!(const(Declaration), null) opIndex
        (dstring prop) const {
    // TODO: Implement properties for integral types once
    // static declarations are made.
    return typeof(return).init;
  }

}