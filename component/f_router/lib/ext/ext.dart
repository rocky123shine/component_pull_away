// Object扩展：
extension ObjectExt<T> on T? {
  bool isNullOrEmpty() {
    if (this is String) {
      return (this as String).isEmpty;
    } else if (this is Iterable) {
      return (this as Iterable).isEmpty;
    }
    return this == null;
  }

  void safeCall(Function(T t) f) {
    if (!this.isNullOrEmpty()) {
      f.call(this as T);
    }
  }
}
