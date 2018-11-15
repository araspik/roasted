/**** Scopes: Limit the usability of declarations.
  * 
  * Scopes provide heirarchies throughout code, and all 
  * declarations created are part of some level of scope.
  * 
  * Scopes are inherited by children scopes such that all
  * declarations accessible to the parent scope are 
  * accessible to the children scope.
  * 
  * Children scopes can create new declarations, which are
  * not accessible to parent scopes.
  * 
  * All scopes provide a path through which internal
  * declarations to them can be accessed. Some scopes may
  * prevent searcihng for declarations within them (for e.g
  * if it is a block statement scope). 
  * 
  * Since scopes have names which are used to refer to them,
  * they are actually a subset of declarations!
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.scopes;

import roasted.declarations;

import utils.maybe;

/// Limits the usability of declarations.
abstract class Scope: Declaration {

  /// Declaration list.
  Declaration[] decls;

  /// The root scope.
  static Scope root;

  shared static this() {
    import roasted.types: Type;

    import std.algorithm: map;
    import std.range: chain;

    root = new RootScope(chain(
      Type.builtins.byValue.map!(t => cast(Declaration)t),
    ));
  }

  //- Properties ---------------------------------------//

 @safe nothrow pure:

 @property {

  /**** Range of scopes.
    * 
    * This can be used to find scopes matching certain
    * predicates.
    */
  final auto ancestry() {
    import std.range: recurrence;
    import std.algorithm: until;

    return this.recurrence!"a[n-1].context".until(null);
  }

  /**** All accessible declarations.
    * 
    * This can be used to find certain declarations.
    */
  final auto allDecls() {
    import std.algorithm: map, joiner;
    import std.range: retro;

    return ancestry.map!(sc => sc.decls.retro).joiner;
  }

 }

  //- Functions ----------------------------------------//

  /**** Whether the given scope contains this scope.
    * 
    * It iterates through the parents of the given scope,
    * looking for this scope.
    * 
    * If it is found, it returns 'true'. Otherwise, it
    * returns 'false'.
    */
  bool opBinary(string op: "in")(const Scope oth) const {
    for (auto sc = oth; sc !is null; sc = sc.context)
      if (sc is this)
        return true;
    return false;
  }

  /**** Finds a declaration at this scope level by name.
    * 
    * If a matching declaration is not found, then nothing
    * is returned.
    * Otherwise, the declaration is returned.
    * 
    * To search upper declarations, use 'getDecl'.
    */
  Maybe!Declaration opIndex(string name) {
    foreach_reverse (decl; decls)
      if (decl.name == name)
        return decl.maybe;
    return maybe!Declaration;
  }

  /**** Finds a declaration in any level scope.
    * 
    * Searches through this scope and all parent scopes for
    * a matching declaration.
    * 
    * It follows the same rules as set up by allDecls().
    */
  Maybe!Declaration getDecl(string name) {
    for (auto sc = this; sc !is null; sc = sc.context)
      foreach_reverse (decl; decls)
        if (decl.name == name)
          return decl.maybe;
    return maybe!Declaration;
  }

}

/// Special scope as the root scope.
private final class RootScope: Scope {
  import std.range: isInputRange, ElementType;
  import std.array: array;
  import roasted.statements: Statement;

  //- Functions ----------------------------------------//

 @safe nothrow:

  /// Constructor.
  this(R)(R decls) pure
      if (isInputRange!R
       && is(ElementType!R == Declaration)) {
    // Only possible instance of null context.
    context = null;
    name = "";
    // type is undefined
    this.decls = decls.array;
  }

}