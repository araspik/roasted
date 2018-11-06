/**** Scopes: Limitations on declaration accessibility.
  * 
  * TODO: Doc for scopes
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.scopes;

import roasted.declarations;

import std.typecons;
import std.traits;
import std.functional;

/// Limitations on declaration accessibility.
interface Scope {

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  /**** Parent to this scope.
    * 
    * If 'null', then this is the root scope.
    */
  inout(Nullable!(Scope, null)) context() inout;

  /**** A list of declarations.
    * 
    * These declarations are what are declared at this
    * scope. Access to them is provided so that declarations
    * may be found form within a certain scope by iterating
    * over all the parents of the scope.
    */
  inout(Declaration[]) decls() inout;

 }

  //- Functions ----------------------------------------//

  /**** Returns whether this scope can be found within
    * another.
    * 
    */
  bool opBinary(string op: "in")
        (const scope Scope oth) const {
    for (auto sc = oth; !sc.isNull; sc = sc.parent)
      if (sc is this)
        return true;
    return false;
  }

  /**** Finds a scope matching the given predicate and
    * returns it.
    * 
    */
  Nullable!(inout Scope, null) findScope(alias pred)()
        inout
      if (is(typeof(unaryFun!pred))
        && arity!(unaryFun!pred) == 1
        && is(typeof(unaryFun!pred(this)) == bool)) {
    for (auto sc = this.nullable; !sc.isNull;
        sc = sc.get.parent)
      if (sc.apply!(s => unaryFun!pred(s)).get(false))
        return sc;
    return typeof(return)();
  }
}