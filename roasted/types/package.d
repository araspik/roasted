/**** Types: Provide compile-time properties of expressions.
  * 
  * They provide a set of known properties for expressions.
  * All expressions have types known at compile time, even
  * if the actual value of the expression is not known then.
  * 
  * Most defined expression types correspond to different
  * types of types.
  * 
  * All types whose properties are known (which is true for
  * a majority of types) have a defined size as a minimum.
  * They also offer indexibility by string to access those
  * properties, as declarations.
  * 
  * All types have a known initialiser state, and all types
  * must expose it.
  * 
  * All types are resolvable and parsable. In addition, they
  * may have a related symbol.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.types;

import roasted.declarations;
import roasted.symbols;
import roasted.scopes;

import std.typecons;

// TODO: Add Resolvable and Parsable interfaces to Type.
/// Provides compile-time properties for expressions.
class Type: Declaration {

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  /**** Returns whether the type is known.
    * 
    * This is determined by whether the initialiser of the
    * type is non-null.
    */
  final bool known() const {
    return !this["init"].isNull;
  }

 }

  //- Functions ----------------------------------------//

  /**** Constructor.
    * 
    * Only for deriving types.
    */
  protected this(Symbol name,
      Nullable!(Scope, null) context = null) {
    super(name, context);
  }

  /**** Exposes properties of the type as declarations.
    * 
    * 'null' indicates that the property does not exist.
    */
  Nullable!(const(Declaration), null) opIndex(dstring prop) 
         const;

}