

enum OrderOption {
  dateModified,
  dateCreated;

  String get name {
    return switch(this) {
      OrderOption.dateCreated => 'Created Date',
      OrderOption.dateModified => 'Modified Date'
    };
  }
}