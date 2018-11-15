/**** Declarations: Statements which define new symbols.
  * 
  * Declarations declare (and in most cases also define) a
  * new symbol that is to be accessible to everything at the
  * current scope.
  * 
  * Declarations create objects such as functions,
  * variables, and types.
  * 
  * Declarations are statements. They know the scope at
  * which they were declared.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.declarations;

import roasted.scopes;
import roasted.statements;
import roasted.types;

import utils.maybe;

/// Statements which define new symbols.
abstract class Declaration: Statement {

  /// The name of the declaration.
  string name;

  /// The type of the declaration.
  /// If the type is nonexistent, then the declaration is a
  /// type itself.
  Maybe!Type type;

  //- Properties ---------------------------------------//

 @safe nothrow pure:

 @property {

  /**** The path to the declaration.
    * 
    * This provides a way to refer to the declaration 
    * unambiguously.
    */
  string path() const {
    return (context.maybe.apply!(c => c.path ~ '.').get("")
      ~ name).idup;
  }

 }

}

/**** Compile-time declarations.
  * 
  * These declarations simply reference expressions known at
  * compile time and can be used for anything that is
  * specifically known at compile time. This includes items
  * like type property declarations.
  * 
  * These cannot be modified.
  */
class ConstantDecl: Declaration {
  import roasted.expressions;

  Expression exp;

  //- Functions ----------------------------------------//

 @safe nothrow pure:

  /// Constructor.
  this(Scope context, string name, Expression exp) {
    this.context = context;
    this.name = name;
    this.type = exp.type;
    this.exp = exp;
  }

}