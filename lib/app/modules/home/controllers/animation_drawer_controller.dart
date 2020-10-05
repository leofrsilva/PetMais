import 'package:mobx/mobx.dart';
part 'animation_drawer_controller.g.dart';

class AnimationDrawerController = _AnimationDrawerControllerBase
    with _$AnimationDrawerController;

abstract class _AnimationDrawerControllerBase with Store {
  @observable
  double xOffset;

  @observable
  double yOffset;

  @observable
  double scaleFactor;

  @observable
  bool isShowDrawer;

  _AnimationDrawerControllerBase({
    double x = 0,
    double y = 0,
    double scale = 1,
    bool isOpen = false,
  }) {
    this.xOffset = x;
    this.yOffset = y;
    this.scaleFactor = scale;
    this.isShowDrawer = isOpen;
  }

  @action
  void openDrawer() {
    this.xOffset = 220;
    this.yOffset = 130;
    this.scaleFactor = 0.75;
    this.isShowDrawer = true;
  }

  @action
  void closeDrawer() {
    this.xOffset = 0;
    this.yOffset = 0;
    this.scaleFactor = 1;
    this.isShowDrawer = false;
  }
}
