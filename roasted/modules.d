/**** Modules: A rigid heirarchy for code organization.
  * 
  * They provide a namespace and scope for declarations.
  * 
  * All modules have these properties:
  * 1. A parent module.
  *   It does not have one if it is at the top of a module
  *   hierarchy.
  * 2. A name.
  *   It is used as an identifier for it within the parent
  *   module. By default, this is the name of the
  *   corresponding file or directory's name (in case of 
  *   files, without the language file extension).
  * 3. A path.
  *   It is made by combining the path of the parent module 
  *   with the name of the current module. It is used as a 
  *   global identifier for that module. It is a 
  *   `.`-separated list of module names in descending 
  *   order of ancestry. For example, a module `foo` with 
  *   parent `bar` which has parent `zarg` has a path of 
  *   `zarg.bar.foo`.
  * 
  * A 'module hierarchy' is a tree of modules, beginning 
  * with the 'root' module which contains all the other 
  * modules. Module hierarchies are defined primarily by 
  * directories: The  highest _known_ directories 
  * containing Lang code form individual module hierarchies.
  * 
  * There are three places where modules are stored:
  * 1. Files.
  *   These modules have a direct correspondence to a file. 
  *   They are declared with a single statement at the top 
  *   of a file. Their names default to the name of their 
  *   containing file (without language file extension), 
  *   but they may override it.
  * 2. Directories.
  *   They may store a special file whose base name (without
  *   language file extension) is `pkg`, which is used if 
  *   the directory is referred to. `pkg` otherwise acts 
  *   like a normal source file. `pkg` may override the 
  *   module's name, which defaults to the name of the 
  *   directory.
  * 3. Within other modules.
  *   These modules, called 'sub-modules', are declared 
  *   within the source code of other modules. They declare 
  *   their names explicitly, as there is no source of 
  *   information to infer it from.
  * 
  * Syntax:
  * ---
  * // File (or directory) module.
  * mod foo;
  *     
  * ...
  *     
  * // Sub-module.
  * mod bar {
  *   ...
  * }
  *     
  * ...
  * ---
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.modules;

import roasted.declarations;
import roasted.scopes;
import roasted.statements;

import utils.maybe;

/// Provides a rigid heirarchy for code organization.
final class Module: Scope {

  /**** Parent module.
    * 
    * This might be confused with Statement.context, except
    * that since modules contain all other statements there
    * it makes no sense to set the parent module as the
    * scope context. Additionaly, in this way parent modules
    * are not automatically imported, which would be
    * unexpected behaviour.
    */
  Maybe!Module parent;

  /// Children modules.
  Maybe!(Module[]) children;

  //- Properties ---------------------------------------//

 @safe nothrow pure:

 @property {

  /// The path to the module.
  override string path() const {
    return (parent.apply!(p => p.path ~ '.').get("") ~ name)
      .idup;
  }

 }

}