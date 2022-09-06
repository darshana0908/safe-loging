class NameOne {
  String sn, name, address, phone;

  NameOne({required this.sn,required this.name,required this.address,required this.phone});
  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json) {
    return NameOne(
        sn: json["sn"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"]);
  }
}
