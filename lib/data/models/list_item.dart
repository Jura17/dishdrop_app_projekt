class ListItem {
  String description;
  double? amount;
  String? unit;
  bool isShoppingListItem = false;
  bool isDone = false;

  ListItem({required this.description, this.amount, this.unit});

  void setDescription(String newDescription) {
    description = newDescription;
  }

  String getDescription() {
    return description;
  }

  void setAmount(double newAmount) {
    amount = newAmount;
  }

  double? getAmount() {
    return amount;
  }

  void setUnit(String newUnit) {
    unit = newUnit;
  }

  String? getUnit() {
    return unit;
  }
}

/*
- ListItem wird sowohl für Rezepte als auch Einkaufslisten genutzt. 
- amount und unit können beide 'null' sein, da es dem Nutzer freistehen soll, einfach nur "Spülmittel" ohne weitere Angaben auf seine Einkaufsliste zu schreiben

Format:
5 slices of ...
3.5 tea spoons of ...
1/2 of ...
1 pinch of ...

==> amount wird, sofern nicht null, später umgewandelt um z. B. ½ anstatt 1/2 oder 0.5 anzuzeigen
==> unit wird vom Nutzer selber eingegeben, quasi freigewählt und kann auch freigelassen werden
 */
