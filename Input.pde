class Input {

  boolean[] keys = new boolean[256];

  void press(char k) {
    int code = (int)Character.toUpperCase(k);
    if (code >= 0 && code < keys.length) {
      keys[code] = true;
    }
  }

  void release(char k) {
    int code = (int)Character.toUpperCase(k);
    if (code >= 0 && code < keys.length) {
      keys[code] = false;
    }
  }

  boolean isDown(char c) {
    int code = (int)Character.toUpperCase(c);
    return (code >= 0 && code < keys.length) && keys[code];
  }
}
