/**** Maybe: A customized nullable type.
  * 
  * This is similar to the normal Phobos' Nullable, except
  * that if the type is a class or it's 'init' state is 
  * null then by default the null state for the Maybe is
  * when the class is null.
  * 
  * Author: ARaspiK
  * License: MIT
  */
module utils.maybe;

public import std.typecons: Nullable, nullable, apply;

template Maybe(T) {
  static if (__traits(compiles, T.init is null))
    alias Maybe = Nullable!(T, null);
  else
    alias Maybe = Nullable!T;
}

Maybe!T maybe(T)(T data) {
  return Maybe!T(data);
}

Maybe!T maybe(T)() {
  return Maybe!T();
}