/**** Statements: Define single declarations or actions.
  * 
  * TODO: Explanation of statements
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.statements;

import roasted.constants;
import roasted.resolvables;
import roasted.scopes;

import std.typecons;

/// Defines single declarations or actions.
class Statement: Resolvable {

  /**** Context of the statement.
    * 
    */
  Nullable!(Scope, null) context;

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  /**** Returns the evaluatability of the object.
    * 
    */
  Evalness evalable() const {return Evalness.none;}

 }

  //- Functions ----------------------------------------//

  /**** Attempts to evaluate the object.
    * 
    */
  Nullable!(Constant, null) eval() {
    return typeof(return)();
  }

}