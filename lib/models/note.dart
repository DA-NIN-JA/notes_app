class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? dateAdded;

  Note({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.dateAdded,
  });

  factory Note.fromMap(Map<String, dynamic> mp) {
    return Note(
      id: mp["id"],
      userId: mp["userId"],
      title: mp["title"],
      content: mp["content"],
      dateAdded: DateTime.tryParse(mp["dateAdded"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "content": content,
      "dateAdded": dateAdded!.toIso8601String(),  
    };
  }
}
