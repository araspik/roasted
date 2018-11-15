/**** Statements: The primary blocks of source code.
  * 
  * Statements are declarations, expressions, etc. that are
  * used to generate executables by the compiler (this).
  * 
  * Statements are usually read in order and are meant to be
  * processed in that way, except in the case of blocks
  * where only declarations are permitted. There, forward
  * references are legal.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.statements;

import roasted.scopes;

import utils.maybe;

/// The primary blocks of source code.
abstract class Statement {

  /**** The context of where the declaration is declared.
    * 
    * It is optional as some builtin declarations have no
    * scope and are viable everywhere.
    */
  Scope context;

  //- Functions ----------------------------------------//

 @safe nothrow pure:

  /**** Inlines the statement.
    * 
    * It attempts to inline as much of the potential effects
    * of the statement as possible.
    * 
    * It returns another statement, which may be
    * nonexistent, which is to replace the current statement
    * wherever the statement exists.
    * 
    * If the returned statement does not exist, then the
    * statement should be removed.
    * 
    * Otherwise, the statement should be replaced by the
    * returned statement.
    * 
    * A dummy default is provided that returns the same
    * statement back.
    */
  Maybe!Statement inline() {
    return this.maybe;
  }

}