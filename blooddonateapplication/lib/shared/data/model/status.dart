enum Status {
  success,
  failure,
  none;

  factory Status.fromString(String? name) {
    switch (name) {
      case 'success':
        return Status.success;
      case 'failure':
        return Status.failure;
      default:
        return Status.none;
    }
  }
}

extension StatusExtension on String? {
  bool get isSuccess => this == Status.success.name;

  bool get isNotSuccess => this != Status.success.name;

  bool get isFailure => this == Status.failure.name;
}
