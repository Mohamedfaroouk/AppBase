import 'dart:async';

import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

import 'animation_build_widget.dart';

class MultiSelectDropDown<T> extends StatefulWidget {
  const MultiSelectDropDown({
    super.key,
    required this.items,
    required this.onChange,
    this.selectedItems,
    required this.itemAsString,
    this.shape,
    this.label,
    this.isRequired = false,
  });
  // item as String
  final FutureOr<List<T>> Function() items;
  final Function(List<T>) onChange;
  final List<T>? selectedItems;
  final String Function(T) itemAsString;
  final ShapeBorder? shape;
  final String? label;
  final bool isRequired;
  @override
  State<MultiSelectDropDown<T>> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  late List<T> selectedItems;
  final LayerLink _layerLink = LayerLink();
  bool _hasOpenedOverlay = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    selectedItems = widget.selectedItems ?? [];

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropDown<T> oldWidget) {
    selectedItems = widget.selectedItems ?? [];
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  String listItems(List<T> items) {
    String result = items
        .map((name) => widget.itemAsString.call(name).split(" ")[0])
        .join(" , ");
    return result;
  }

  addOrRemoveItem(T item) {
    selectedItems.any((element) => element == item)
        ? selectedItems.remove(item)
        : selectedItems.add(item);

    widget.onChange(selectedItems);
  }

  final GlobalKey _key = GlobalKey();
  Color mainColor = const Color(0xff939393);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: FormField<List<T>>(
          initialValue: selectedItems,
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return "من فضلك اختر ${widget.label}";
                  }
                  return null;
                }
              : null,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(widget.label.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 15)),
                const SizedBox(height: 10),
                WillPopScope(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Card(
                          margin: EdgeInsets.zero,
                          clipBehavior: Clip.hardEdge,
                          elevation: 0,
                          shape: widget.shape ??
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      width: 1, color: Colors.black38)),
                          child: ListTile(
                            tileColor: AppColors.grey,
                            key: _key,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 7),
                            onTap: () {
                              openOverlay();
                            },
                            minLeadingWidth: 20,
                            title: selectedItems.isEmpty
                                ? Text(
                                    widget.label.toString(),
                                    style: TextStyle(
                                        color: mainColor, fontSize: 15),
                                  )
                                : Wrap(
                                    spacing: 5,
                                    children: selectedItems
                                        .map((e) => Chip(
                                              padding: EdgeInsets.zero,
                                              deleteIcon: Icon(
                                                Icons.clear,
                                                color: AppColors.primary,
                                                size: 20,
                                              ),
                                              onDeleted: () {
                                                addOrRemoveItem(e);
                                                setState(() {});
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  side: BorderSide(
                                                      color: AppColors.primary,
                                                      width: 0.5)),
                                              backgroundColor: AppColors.primary
                                                  .withOpacity(0.1),
                                              label: Text(
                                                widget.itemAsString.call(e),
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 15),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(
                                    _hasOpenedOverlay
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    key: ValueKey(_hasOpenedOverlay),
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // future
  Future<List<T>>? _future;
  void openOverlay() {
    _future ??= Future.value(widget.items.call());

    // if (_overlayEntry == null) {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
        maintainState: true,
        builder: (context) => AnimationAppearanceOpacity(
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
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
                      offset: Offset(0.0, size.height + 5.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: SizedBox(
                          child: StatefulBuilder(builder: (context, set) {
                            return Card(
                                clipBehavior: Clip.hardEdge,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: const BorderSide(
                                      color: Color(0xff939393),
                                      width: 1,
                                    )),
                                child: FutureBuilder(
                                    future: _future,
                                    builder: (context, items) {
                                      return items.connectionState ==
                                              ConnectionState.waiting
                                          ? const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            )
                                          : items.data == null
                                              ? const SizedBox()
                                              : Column(
                                                  children: <Widget>[
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      itemCount:
                                                          items.data?.length,
                                                      itemBuilder: ((context,
                                                              index) =>
                                                          ListTile(
                                                            shape: const UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black26)),
                                                            onTap: () {
                                                              addOrRemoveItem(
                                                                  items.data![
                                                                      index]);
                                                              setState(() {});
                                                              set(() {});
                                                            },
                                                            title: Text(
                                                                widget
                                                                    .itemAsString
                                                                    .call(items
                                                                            .data![
                                                                        index]),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15)),
                                                            // tileColor: selectedItems.any((element) => element == items.data![index])
                                                            //     ? AppColors.lightGrey
                                                            //     : Colors.transparent,
                                                            trailing: Icon(
                                                              selectedItems.any((element) =>
                                                                      element ==
                                                                      items.data![
                                                                          index])
                                                                  ? Icons
                                                                      .check_box
                                                                  : Icons
                                                                      .check_box_outline_blank,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                          )),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      closeOverlay();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "تم",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15),
                                                                    )),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                    }));
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
    // }
    if (!_hasOpenedOverlay) {
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      _overlayEntry!.remove();
      setState(() {
        _hasOpenedOverlay = false;
      });
    }
  }
}
