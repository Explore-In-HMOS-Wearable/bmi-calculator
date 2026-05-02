@Component
export default struct CheckBox {
  @Link isMale: boolean
  onGenderChange?: () => void

  build() {
    Row() {
      Row() {
        Checkbox({ name: 'female', group: 'genderGroup' })
          .select(!this.isMale)
          .selectedColor($r('app.color.accent_color'))
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            if (value) {
              this.isMale = false
              this.onGenderChange?.()
            }
          })
        Text($r('app.string.female'))
          .fontSize('14fp')
          .fontColor($r('app.color.text_primary'))
          .margin({ left: '4vp' })
      }
      .margin({ right: '12vp' })

      Row() {
        Checkbox({ name: 'male', group: 'genderGroup' })
          .select(this.isMale)
          .selectedColor($r('app.color.accent_color'))
          .shape(CheckBoxShape.CIRCLE)
          .onChange((value: boolean) => {
            if (value) {
              this.isMale = true
              this.onGenderChange?.()
            }
          })
        Text($r('app.string.male'))
          .fontSize('14fp')
          .fontColor($r('app.color.text_primary'))
          .margin({ left: '4vp' })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}
