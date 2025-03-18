import 'package:flutter/material.dart';

class CookingDirectionsListView extends StatefulWidget {
  const CookingDirectionsListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  State<CookingDirectionsListView> createState() => _CookingDirectionsListViewState();
}

class _CookingDirectionsListViewState extends State<CookingDirectionsListView> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    for (var i = 0; i < widget.complexInputValues["directions"].length; i++) {
      _controllers[i] = TextEditingController(text: widget.complexInputValues["directions"][i]);
      _controllers[i]?.addListener(() {
        widget.complexInputValues["directions"][i] = _controllers[i]?.text;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.complexInputValues["directions"].length,
        (index) {
          // if a controller with a certain index does not exist create it, otherwise ignore statement
          _controllers.putIfAbsent(
              index, () => TextEditingController(text: widget.complexInputValues["directions"][index]));

          return Dismissible(
            key: Key(widget.complexInputValues["directions"][index]),
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) async {
              setState(() {
                _controllers[index]?.dispose();
                _controllers.remove(index);
                widget.complexInputValues["directions"].removeAt(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}. ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: TextField(
                      maxLength: 200,
                      maxLines: null,
                      controller: _controllers[index],
                      // onChanged: (value) => widget.complexInputValues["directions"][index] = value,
                      enabled: true,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
