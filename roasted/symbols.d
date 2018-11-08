/**** Symbols: Identifiers for declarations.
  * 
  * TODO: Doc for symbols.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module roasted.symbols;

import roasted.scopes;

import std.typecons;

/// Identifiers for declarations.
final class Symbol {

  /**** The identifier for the symbol.
    * 
    */
  dstring ident;

  //- Functions ----------------------------------------//

 @safe nothrow pure :

  /**** Constructor.
    * 
    */
  this(dstring ident) {
    this.ident = ident;
  }

  /**** Locates a matching declaration given a scope.
    * 
    */
  Nullable!(Declaration, null) opBinary
      (string op: "in")(const scope Scope context) const {
    for (auto sc = context.nullable; !sc.isNull;
        sc = sc.get.parent)
      if (!sc.decls.isNull)
        foreach (d; sc.decls.get)
          if (d.sym.ident == ident)
            return d.nullable;
    return null;
  }

  /// Equality checker.
  @nogc bool opEquals(const scope Symbol oth) const {
    return oth.ident == ident;
  }

  /// Hasher.
  override @nogc size_t toHash() const {
    return ident.hashOf;
  }

  /// Returns the difference from another symbol.
  @nogc size_t opBinary(string op: "-")
        (const scope Symbol oth) const {
    import std.algorithm: levenshteinDistance;
    return levenshteinDistance(ident, oth.ident);
  }
}