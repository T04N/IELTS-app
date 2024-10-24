// ignore_for_file: public_member_api_docs, sort_constructors_first
class Input {
  String email;
  String fileName;
  String url;
  Input({
    required this.email,
    required this.fileName,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'file_name': fileName,
      'url': url,
    };
  }

  static Input fromMap(Map<String, dynamic> map, email) {
    return Input(email: email, fileName: map['file_name'], url: map['url']);
  }
}
