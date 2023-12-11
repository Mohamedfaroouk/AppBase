import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';

class CustomAutoCompleteTextField<T> extends StatefulWidget {
  const CustomAutoCompleteTextField(
      {Key? key,
      this.initialValue,
      this.lable,
      this.showClearIcon = false,
      this.showSufix = false,
      this.showLabel = false,
      this.showRequiredStar = false,
      this.keepSuggestionAftertSelect = false,
      this.removeSelectedItem = false,
      required this.onChanged,
      this.onClear,
      required this.function,
      this.itemAsString,
      this.flex = 1,
      this.hideOnLoading = false,
      this.controller,
      this.enabled = true,
      this.disableSearch = false,
      this.hint,
      this.validator,
      this.keepAfterClose = false,
      this.padding,
      this.contentPadding,
      this.border,
      this.itemBuilder,
      this.direction = AxisDirection.down,
      this.showAboveField = false,
      this.emptyWidget,
      this.searchInApi = true,
      this.height,
      this.decoration,
      this.fillColor,
      this.onChangeText,
      this.itemSubtitle})
      : super(key: key);
  final Function(T) onChanged;
  final bool showSufix;
  final String? lable;
  final String? hint;
  final String? initialValue;
  final FutureOr<Iterable<T>> Function(String) function;
  final VoidCallback? onClear;
  final bool disableSearch;
  final bool showClearIcon;
  final bool enabled;
  final bool showLabel;
  final bool hideOnLoading;
  final bool showRequiredStar;
  final bool removeSelectedItem;
  final AxisDirection direction;
  final bool keepSuggestionAftertSelect;
  final TextEditingController? controller;
  final String Function(T)? itemAsString;
  final int flex;
  final bool searchInApi;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final bool showAboveField;
  final Widget? emptyWidget;
  final double? height;
  final InputDecoration? decoration;
  final bool keepAfterClose;
  final Color? fillColor;
  final Widget Function(T)? itemSubtitle;
  final ValueChanged<String>? onChangeText;
  final Widget Function(BuildContext, T)? itemBuilder;
  @override
  State<CustomAutoCompleteTextField<T>> createState() => _CutomAutoCompleteTextFeildState<T>();
}

class _CutomAutoCompleteTextFeildState<T> extends State<CustomAutoCompleteTextField<T>> {
  late TextEditingController controller;
  final LayerLink _layerLink = LayerLink();
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  String? selectedItem;
  List<T> suggestions = [];
  List<T> searchedSuggestions = [];
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController(text: widget.initialValue?.tr());

    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showLabel)
            Row(
              children: [
                CustomText(
                  widget.lable.toString(),
                  fontSize: 16,
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          if (widget.showLabel)
            const SizedBox(
              height: 10,
            ),
          IgnorePointer(
              ignoring: !widget.enabled,
              child: WillPopScope(
                onWillPop: () async {
                  if (_hasOpenedOverlay) {
                    closeOverlay();
                    return false;
                  } else {
                    return true;
                  }
                },
                child: CompositedTransformTarget(
                    link: _layerLink,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: widget.height,
                            child: TextFormField(
                                key: _key,
                                readOnly: widget.disableSearch,
                                decoration: widget.decoration ??
                                    InputDecoration(
                                        hintText: widget.hint,
                                        filled: true,
                                        fillColor: widget.fillColor ?? AppColors.grey,
                                        labelText: widget.showLabel ? null : widget.lable,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.error, width: 1)),
                                        enabledBorder: widget.border ??
                                            OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey, width: 1)),
                                        border: widget.border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                        suffix: (widget.showClearIcon)
                                            ? IconButton(
                                                onPressed: () {
                                                  // widget.onClear?.call();
                                                  controller.text = "";
                                                  selectedItem = null;
                                                },
                                                icon: const Icon(Icons.clear),
                                              )
                                            : null,
                                        suffixIcon: widget.showSufix
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: AppColors.primary,
                                                  )
                                                ],
                                              )
                                            : null,
                                        contentPadding: widget.contentPadding),
                                controller: controller,
                                onChanged: (s) {
                                  if (!_hasOpenedOverlay) openOverlay();
                                  if (widget.searchInApi) {
                                    updateSuggestions(s);
                                  } else {
                                    searchedSuggestions = suggestions
                                        .where((element) => widget.itemAsString?.call(element).toLowerCase().contains(s.toLowerCase()) ?? true)
                                        .toList();
                                    rebuildOverlay();
                                  }
                                  widget.onChangeText?.call(s);
                                  rebuildOverlay();
                                },
                                onTap: () {
                                  openOverlay();
                                  updateSuggestions(controller.text);
                                },
                                // onEditingComplete: () => closeOverlay(),
                                validator: widget.validator != null ? (value) => widget.validator!(value) : null //
                                ),
                          )
                        ])),
              )),
        ],
      ),
    );
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      if (widget.keepAfterClose == false) {
        if (selectedItem != null) {
          controller.text = selectedItem ?? "";
        } else {
          controller.text = "";
        }
      }
      _overlayEntry!.remove();
      setState(() {
        _hasOpenedOverlay = false;
      });
    }
  }

//global key
  final GlobalKey _key = GlobalKey();
  void openOverlay() {
    if (widget.keepAfterClose == false) {
      controller.text = '';
    }
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(builder: (context) => suggestionList(offset, size, context));
    if (_hasOpenedOverlay == false) {
      print("object");
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  Stack suggestionList(Offset offset, Size size, BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.5;
    return Stack(children: [
      ModalBarrier(
        onDismiss: () {
          closeOverlay();
        },
      ),
      Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, widget.showAboveField ? -h : size.height + 5),
            child: Card(
              shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.zero,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                child: _isLoading
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ))
                    : searchedSuggestions.isEmpty
                        ? widget.emptyWidget ??
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CustomText("No Items"),
                            )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: searchedSuggestions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    if (widget.keepSuggestionAftertSelect == false) {
                                      selectedItem = widget.itemAsString?.call(searchedSuggestions[index]) ?? searchedSuggestions[index].toString();
                                      if (widget.keepAfterClose) {
                                        controller.text = selectedItem ?? "";
                                      }
                                      closeOverlay();
                                    }
                                    widget.onChanged(searchedSuggestions[index]);
                                  },
                                  child: widget.itemBuilder?.call(context, searchedSuggestions[index]) ??
                                      ListTile(
                                          shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                          subtitle: widget.itemSubtitle?.call(searchedSuggestions[index]),
                                          title: CustomText(widget.itemAsString?.call(searchedSuggestions[index]).tr() ??
                                              searchedSuggestions[index].toString().tr())),
                                )),
              ),
            ),
          ))
    ]);
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  Future<void> updateSuggestions(String input) async {
    if (widget.searchInApi == false && suggestions.isNotEmpty) {
      searchedSuggestions =
          suggestions.where((element) => widget.itemAsString?.call(element).toLowerCase().contains(input.toLowerCase()) ?? true).toList();
      rebuildOverlay();
      return;
    }
    setState(() => _isLoading = true);

    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      suggestions = (await widget.function.call(input)).toList();
      searchedSuggestions =
          suggestions.where((element) => widget.itemAsString?.call(element).toLowerCase().contains(input.toLowerCase()) ?? true).toList();

      setState(() {
        _isLoading = false;
      });
      rebuildOverlay();
    });
  }
}
