abstract class ImageChangeEvent{}
class ImageEvent extends ImageChangeEvent{
  var image;
  ImageEvent({this.image});
}