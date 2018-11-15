/**** Expressions: Represents values.
  * 
  * Expressions might not be known at compile-time.
  * 
  * Operations, function calls, variable references,
  * constant values, etc. are all represented by these
  * expressions.
  * 
  * Expressions may be recursive.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.expressions;

import roasted.types;

import utils.maybe;

/// Represents values.
abstract class Expression {

  //- Properties ---------------------------------------//

 @safe nothrow pure:

 @property {

  /// The type of the expression.
  abstract inout(Type) type() inout;

 }

}

/// Represents integral expressions.
class IntegralExp: Expression {
  import std.traits: isFloatingPoint;

  private union {
    /// Integral value.
    ulong integral_;
    /// Floating-point value.
    real floating_;
  }

  private IntegralType type_;

  //- Properties ---------------------------------------//

 @safe nothrow pure:

 @property {

  /// The type of the expression.
  override inout(IntegralType) type() inout {return type_;}

  /// The integral value if the value is integral.
  Maybe!ulong integral() const {
    if (type.integral)
      return maybe!ulong(integral_);
    else
      return maybe!ulong;
  }

  /// The floating-point value if valid.
  Maybe!real floating() const {
    if (type.floating)
      return maybe!real(floating_);
    else
      return maybe!real;
  }

 }

  //- Functions ----------------------------------------//

  /// Constructor, integral values.
  this(IntegralType type, ulong integral) {
    assert (type.integral,
      "Got passed a floating-point type and integral value!");
    this.integral_ = integral;
    this.type_ = type;
  }

  /// Constructor, floating-point values.
  this(IntegralType type, real floating) {
    assert (type.floating,
      "Got passed an integral type and floating-point value!");
    this.floating_ = floating;
    this.type_ = type;
  }

}