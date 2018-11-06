/**** Resolvable: Compile-time resolvable objects.
  * 
  * Objects which are compile-time resolvable by nature (e.g
  * templates) are called "static", and objects which are
  * not _necessarily_ resolvable at compile time but can be
  * in certain contexts are called "CT evaluatable". This
  * interface provides functions designed to test for and
  * evaluate these objects.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.resolvables;

import roasted.constants;

import std.typecons;

/// Enumerates types of compile-time resolvability.
enum Evalness {
  none,   /// Objects which cannot be evaluated.
  cteval, /// CT evaluatable objects.
  full,   /// Static objects.
}

/// Compile-time resolvable objects.
interface Resolvable {

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  /// Returns the evaluatability of the object.
  Evalness evalable() const;

 }

  //- Functions ----------------------------------------//

  /// Evaluates and returns the object.
  Nullable!(Constant, null) eval();

}