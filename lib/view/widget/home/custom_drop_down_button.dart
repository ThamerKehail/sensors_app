import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChange;
  const CustomDropDownButton(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 3, color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 3, color: Colors.blue),
            ),
          ),
          value: value,
          items: items,
          onChanged: onChange,
        ));
  }
}
