
class ChecklistItem {
  List<String> mediaPaths; // Stores the paths to uploaded images/videos

  ChecklistItem({required this.mediaPaths});

  // Check if the minimum requirement of 2 media files is met
  bool isValid() => mediaPaths.length >= 2;

  // To save data to local storage, we need a toMap method
  Map<String, dynamic> toMap() => {
        'mediaPaths': mediaPaths,
      };

  // To restore data from local storage
  static ChecklistItem fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      mediaPaths: List<String>.from(map['mediaPaths']),
    );
  }
}
