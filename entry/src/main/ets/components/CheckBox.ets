@Component
export default struct CheckBox{

  build() {
    Row() {
      Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
        .selectedColor($r('app.color.blue_color'))
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        .onChange((value: boolean) => {
          console.info('Checkbox1 change is'+ value)
        })
        .unselectedColor(Color.Red)
        .width('5%')
      Text('Female')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.blue_color'))

      Checkbox({ name: 'checkbox2', group: 'checkboxGroup' })
        .selectedColor(0x39a2db)
        .unselectedColor(Color.Red)
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        .onChange((value: boolean) => {
          console.info('Checkbox2 change is' + value)
        })
        .width('5%')
      Text('Male')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.blue_color'))
    }
  }
}