class Video {
  final String id;
  final String title;
  final String fileName;
  final int duration;
  final int smileDetection;
  final int gazeDetection;
  final int handDetection;
  final int headDetection;
  final String type;
  final int hasDetection;

  Video({
    required this.id,
    required this.title,
    required this.fileName,
    required this.duration,
    required this.smileDetection,
    required this.gazeDetection,
    required this.handDetection,
    required this.headDetection,
    required this.type,
    required this.hasDetection
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"],
      title: json["title"],
      fileName: json["file_name"],
      duration: json["duration"],
      smileDetection: json["smile_detection"],
      gazeDetection: json["gaze_detection"],
      handDetection: json["head_detection"],
      headDetection: json["head_detection"],
      type: json["type"],
      hasDetection: json["has_detection"]
    );
  }
}
