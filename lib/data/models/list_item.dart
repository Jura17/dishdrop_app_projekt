class ListItem {
  String id;
  String description;
  double? amount;
  String? unit;
  bool isShoppingListItem;
  bool isDone;

  ListItem({
    required this.id,
    required this.description,
    this.amount,
    this.unit,
    this.isShoppingListItem = false,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'unit': unit,
      'isShoppingListItem': isShoppingListItem,
      'isDone': isDone,
    };
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
