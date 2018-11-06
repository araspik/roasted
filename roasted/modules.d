/**** Modules: A heirarchy system for organization of code.
  * 
  * They provide a nemspace and scope for declarations.
  * All modules have these things associated with them:
  * 1. A parent module.
      It may not have one if it is at the top of a module 
      heirarchy.
  * 2. A name.
  *   It is used as an identifier for it within the parent
  *   module. By default, this is the name of the
  *   corresponding file or directory's name (in case of
  *   files, without the language file extension).
  * 3. A path.
  *   It is made by combining the path of the parent module
  *   with the name of the current module. It is used as a
  *   global identifier for that module.
  *   It is a `.`-separated list of module names in
  *   descending order of ancestry. For example, a module
  *   `foo` with parent `bar` which has parent `zarg` has a
  *   path of `zarg.bar.foo`.
  * 
  * A 'module heirarchy' is a tree of modules, beginning
  * with the 'root' module which contains all the other
  * modules. Module heirarchies are defined primarily by
  * directories: The highest _known_ directories containing
  * Lang code form individual module heirarchies.
  * 
  * There are three places where modules are stored:
  * 1. Files.
  *   These modules have a direct correspondence to a file.
  *   They are declared with a single statement at the top
  *   of a file. Their names default to the name of their
  *   containing file (without language file extension), but
  *   thety may override it.
  * 2. Directories.
  *   They may store a special file whose base name (without
  *   language file extension) is `pkg`, which is used if
  *   the directory is referred to. `pkg` otherwise acts
  *   like a normal source file. `pkg` may override the
  *   module's name, which defaults to the name of the
  *   directory.
  * 3. Within other modules.
  *   These modules, called 'submodules', are declared
  *   within the source code of other modules. They declare
  *   their names explicitly, as there is no source of
  *   information to infer it from.
  * 
  * Syntax:
  * 
  *     // File (or directory) module.
  *     mod foo;
  *     
  *     ...
  *     
  *     // Submodule.
  *     mod bar {
  *       ...
  *     }
  *     
  *     ...
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.modules;

import roasted.constants;
import roasted.declarations;
import roasted.resolvables;
import roasted.scopes;

import std.typecons;

/**** Provides a heirarchy system for organization of code.
  * 
  * See Also: roasted.modules
  */
final class Module: Declaration, Scope, Constant {

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
  dstring path() const {
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

  /// The evaluatability of the object, always 'static'.
  override Evalness evalable() const {
    return Evalness.full;
  }

 }

  //- Functions ----------------------------------------//

  /// Evaluates and returns the object.
  override Nullable!(Constant, null) eval() {
    return typeof(return)(this);
  }

}