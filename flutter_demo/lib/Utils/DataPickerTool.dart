import 'package:flutter/material.dart';

class DataPickerTool extends StatelessWidget {
  //数据源
  final List<String> list;
  final List widgets = [];
  //确定
  final ValueChanged confirmClick;
  //改变选中回调
  final ValueChanged onSelectedItemChanged;
  //记录选中
  late final int selectedIndex;

  DataPickerTool(
      {Key? key,
      required this.list,
      required this.confirmClick,
      required this.onSelectedItemChanged})
      : super(key: key);
  //静态构造方法
  static show(BuildContext context,
      {required List<String> list,
      required ValueChanged onSelectedItemChanged,
      required ValueChanged confirmClick}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(4)),
        builder: (BuildContext context) {
          return DataPickerTool(
            list: list,
            onSelectedItemChanged: onSelectedItemChanged,
            confirmClick: confirmClick,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i < list.length; i++) {
      widgets.add(getRow(i, context));
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8,
          ),
          _headerWidget(context),
          _pickerViewWidget(context),
        ],
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          height: 4,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: const Text(
            " Manufacturer",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget getRow(int i, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, right: 10),
            // decoration: BoxDecoration(color: Colors.red),
            width: 1000,
            child: Text(
              list[i],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 10),
            // width: 40,
            height: 1,
            decoration: BoxDecoration(color: Colors.grey[350]),
          ),
        ],
      ),
      onTap: () {
        selectedIndex = i;
        Navigator.of(context).pop();
        confirmClick(selectedIndex);
      },
    );
  }

  //piceerView
  Widget _pickerViewWidget(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return getRow(index, context);
        },
      ),
    );
  }
}
