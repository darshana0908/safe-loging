class FolderSettings {
  int id;
  String folder_name;
  String covername;
  FolderSettings({
    required this.id,
    required this.folder_name,
    required this.covername,
  });
  factory FolderSettings.fromJson(Map<String, dynamic> json) {
    return FolderSettings(
      id: json['id'] as int,
      folder_name: json['folder_name'] as String,
      covername: json['covername'] as String,
    );
  }
}
