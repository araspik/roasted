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
import roasted.scopes;

import std.typecons;

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

  /**** The path to the declaration.
    * 
    * This is an unambiguous name for the declaration, even
    * among modules (as module path is included).
    */
  dstring path() const {
    return (context.apply!(sc => sc.path ~ '.').get(""d)
      ~ name.ident).idup;
  }

 }

  //- Functions ----------------------------------------//

  /**** Constructor.
    * 
    * Only for deriving classes.
    */
  protected this(Symbol name,
        Nullable!(Scope, null) context = null) {
    super(context);
    this.name = name;
  }

  alias eval = Statement.eval;

  /**** Stringifier.
    * 
    * Returns the declaration name.
    */
  override dstring toStr() const {
    return name.ident;
  }

}