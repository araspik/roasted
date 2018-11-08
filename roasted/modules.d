/**** Modules: A heirarchy system for organization of code.
  * 
  * See the wiki for more information.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.modules;

import roasted.declarations;
import roasted.scopes;
import roasted.symbols;

import std.typecons;

/**** Provides a heirarchy system for organization of code.
  * 
  * See Also: `docs/modules.md`
  */
final class Module: Declaration, Scope {

  /**** Parent module.
    * Nonexistent when this module is at the top of a 
    * module heirarchy.
    */
  Nullable!(Module, null) parent;

  /**** Children modules.
    * These are file modules (if this module is a directory)
    * and submodules which are stored within this module.
    */
  Nullable!(Module[], null) children;

  /**** Declarations contained in this module.
    * These constitute of everything inside the module.
    * This is guaranteed to be non-null.
    */
  Declaration[] data = [];

  //- Properties ---------------------------------------//

 @safe nothrow pure :
 
 @property {

  /// Path of the module.
  override dstring path() const {
    return parent
      .apply!(p => p.path ~ '.' ~ name.ident)
      .get(name.ident).idup;
  }

  /// The context to this scope. There is none.
  inout(Nullable!(Scope, null)) context() inout {
    return typeof(return).init;
  }

  /// A list of declarations at this scope.
  inout(Declaration[]) decls() inout {
    return decls;
  }

 }

  //- Functions ----------------------------------------//

  /**** Constructor.
    * 
    */
  this(dstring name, Declaration[] data = [],
        Module[] children = null, Module parent = null) {
    super(new Symbol(name));
    this.data = data;
    this.children = children;
    this.parent = parent;
  }

}