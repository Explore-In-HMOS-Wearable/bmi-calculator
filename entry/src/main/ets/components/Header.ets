@Component
export default struct Header{
  build() {
    Text('BMI Calculator')
      .fontSize(12)
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .backgroundColor($r('app.color.blue_color'))
      .borderRadius(6)
      .width('80%')
      .height('10%')
  }
}