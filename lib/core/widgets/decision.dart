class Decision {
  static dynamic decide({
    bool condition,
    Function ifTrue,
    Function ifFalse,
  }) {
    return condition ? ifTrue() : ifFalse();
  }
}
