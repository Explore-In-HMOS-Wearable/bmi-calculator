@Component
export default struct Header {
  build() {
    Text($r('app.string.header'))
      .fontSize('16fp')
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .textAlign(TextAlign.Center)
      .margin({ top: '10vp', bottom: '10vp' })
  }
}
