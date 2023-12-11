import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import '../../core/utils/Utils.dart';

class SearchField extends StatefulWidget {
  SearchField({
    Key? key,
    this.controller,
    required this.onSearch,
    this.hint,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
  }) : super(key: key);

  TextEditingController? controller;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String) onSearch;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Timer? _debounce;
  String query = "";
  final int _debouncetime = 1000;

  @override
  void initState() {
    // widget.controller.addListener(onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    // widget.controller.removeListener(onSearchChanged);
    super.dispose();
  }

  onSearchChanged(String s) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debouncetime), () {
      widget.onSearch(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        Utils.fixRtlLastChar(widget.controller);
      },
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      onChanged: (s) {
        onSearchChanged.call(s);
      },
      keyboardType: widget.keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.primary)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.primary)),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            ImageIcon(
              const AssetImage(
                "assets/icons/search.png",
              ),
              color: AppColors.primary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
