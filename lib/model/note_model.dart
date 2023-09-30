
class Note{
    int? note_id,user_id;
    String? title,content,image,date;

  Note(this.note_id, this.user_id, this.title, this.content, this.image,this.date);

  Map<String ,dynamic> toJson(Note note)
  {
    return{
      "title":note.title,
      "content":note.content,
      "image":note.image,
      "user_id":note.user_id,
      "date":note.date,
    };
  }

  Note.fromJson(Map<String,dynamic> map)
  {
    this.note_id=map['id'];
    this.title=map['title'];
    this.content=map['content'];
    this.image=map['image'];
    this.user_id=map['user_id'];
    this.date=map['date'].toString();
  }
}