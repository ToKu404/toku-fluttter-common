extension ObjectExtensions<I extends Object?> on I {
  T let<T>(T Function(I it) block) {
    return block(this);
  }

  I also(void Function(I it) block) {
    block(this);
    return this;
  }
}
