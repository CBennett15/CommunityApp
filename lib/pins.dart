class Pin {
  final String eventname;
  final String eventtype;

  Pin({this.eventname, this.eventtype});

  factory Pin.fromJson(Map<String, dynamic> json) {
    return new Pin(
      eventname: json['name'] as String,
      eventtype: json['flag'] as String,
    );
  }
}
