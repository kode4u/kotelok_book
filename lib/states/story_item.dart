import 'dart:convert';

class StoryItem {
  String id = "";
  String title = "";
  String image = "";
  String story = "";
  String peak = "";

  StoryItem.fromInput(
      {String? id, String? title, String? image, String? story, String? peak})
      : id = id!,
        title = title!,
        image = image!,
        story = story!,
        peak = peak!;
  StoryItem.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? "",
        title = parsedJson['title'] ?? "",
        image = parsedJson['image'] ?? "",
        story = parsedJson['story'] ?? "",
        peak = '${parsedJson['bookno']}' ?? "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "image": image,
      "story": story,
      "peak": peak
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
