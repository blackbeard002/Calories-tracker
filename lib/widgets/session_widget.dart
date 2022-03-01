class sessionTracker
{
  //someday i'll find a use for this. for now stays here

  DateTime? selectedDate;

  //vars related to addFood
  List? defaultWeights;
  List? defaultUnits;
  String? food_name;
  String? imgUrl;

  sessionTracker({
    this.selectedDate,
    this.defaultUnits,
    this.defaultWeights,
    this.food_name,
    this.imgUrl,
  });
}