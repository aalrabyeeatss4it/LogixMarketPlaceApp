class FcmTokenDto {
  String fcmToken;
  FcmTokenDto({required this.fcmToken});

  Map<String, dynamic> toJson() {
    return {"FcmToken": fcmToken};
  }
}
