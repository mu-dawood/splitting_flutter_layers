import 'package:domain/domain.dart';

class FileModel extends IFile {
  @override
  final String name;
  @override
  final String path;
  FileModel({
    required this.name,
    required this.path,
  });
}
