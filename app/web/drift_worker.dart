import 'package:drift/wasm.dart';

// dart compile js web/drift_worker.dart -o web/drift_worker.dart.js
void main() {
  return WasmDatabase.workerMainForOpen();
}
