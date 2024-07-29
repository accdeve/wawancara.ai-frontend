import 'dart:convert';

class DetectionResponse {
    final Detection data;
    final String message;
    final String status;

    DetectionResponse({
        required this.data,
        required this.message,
        required this.status,
    });

    factory DetectionResponse.fromJson(Map<String, dynamic> json) => DetectionResponse(
        data: Detection.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
    };
}

class Detection {
    final int gazeCount;
    final int handCount;
    final int headCount;
    final int smileCount;

    Detection({
        required this.gazeCount,
        required this.handCount,
        required this.headCount,
        required this.smileCount,
    });

    factory Detection.fromRawJson(String str) => Detection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Detection.fromJson(Map<String, dynamic> json) => Detection(
        gazeCount: json["gaze_count"],
        handCount: json["hand_count"],
        headCount: json["head_count"],
        smileCount: json["smile_count"],
    );

    Map<String, dynamic> toJson() => {
        "gaze_count": gazeCount,
        "hand_count": handCount,
        "head_count": headCount,
        "smile_count": smileCount,
    };
}
