/**** Declarations: A system for creating new things.
  * 
  * They are statements which create new objects, like
  * functions, variables, types, etc.
  * 
  * All declarations consist of at least these things:
  * 1. A symbol, defining how to refer to the declaration.
  * 
  * All declarations are parsable and resolvable.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.declarations;

import roasted.statements;
import roasted.symbols;

/// Provides a system for declaring new things.
class Declaration: Statement {

  /**** The symbol, which can be used to refer to the
    * declaration.
    */
  Symbol name;

  //- Properties ---------------------------------------//

 @safe nothrow pure :

 @property {

  alias evalable = Statement.evalable;

 }

  //- Functions ----------------------------------------//

  alias eval = Statement.eval;

}