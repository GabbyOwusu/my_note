abstract class FileContract {
  Future<String> getPath();

  Future<bool> writeFile(String data);

  Future<String> readFile();
}
