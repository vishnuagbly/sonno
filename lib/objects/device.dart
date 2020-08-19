class Device {
  String name;
  int id;

  Device(this.name, this.id);


  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Device && other.id == this.id;

}