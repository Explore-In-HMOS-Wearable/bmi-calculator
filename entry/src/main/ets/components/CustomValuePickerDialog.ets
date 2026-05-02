@CustomDialog
export struct CustomValuePickerDialog {
  controller: CustomDialogController
  title: string | Resource = ''
  range: string[] = []
  @State selectedIndex: number = 0
  confirm: (value: string) => void = () => {
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize('16fp')
        .fontColor($r('app.color.text_primary'))
        .margin({ top: '15vp' })

      TextPicker({ range: this.range, selected: this.selectedIndex })
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedIndex = index as number
        })
        .height(114)
        .width('100%')
        .backgroundColor(Color.Transparent)

      Row() {
        Button('Cancel')
          .onClick(() => {
            this.controller.close()
          })
          .backgroundColor(Color.Transparent)
          .fontColor($r('app.color.text_secondary'))
          .fontSize('14fp')

        Button('Confirm')
          .onClick(() => {
            this.confirm(this.range[this.selectedIndex])
            this.controller.close()
          })
          .backgroundColor(Color.Transparent)
          .fontColor($r('app.color.accent_color'))
          .fontSize('14fp')
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: '5vp' })
    }
    .width('100%')
    .backgroundColor('#222222')
    .borderRadius(30)
    .padding({
      left: 10,
      right: 10,
      top: 10,
      bottom: 40
    })
  }
}
