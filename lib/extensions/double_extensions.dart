extension range on List<double> {
  double getMax({List<double> exclude}) {
    if(exclude == null) exclude = [];
    if (this == null || this.length == 0) return 0;
    double res;
    this.forEach((element) {
      if (!exclude.contains(element)) {
        if (res == null) res = element;
        if (element > res) res = element;
      }
    });
    return res ?? 0;
  }
}
