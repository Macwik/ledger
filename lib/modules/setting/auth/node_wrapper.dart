import 'package:animated_tree_view/animated_tree_view.dart';

class NodeWrapper<T> extends TreeNode<T> {
  bool? selected;

  NodeWrapper({super.data, select}) {
    this.selected = selected;
  }
}
