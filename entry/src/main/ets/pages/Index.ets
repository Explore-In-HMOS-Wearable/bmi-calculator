import { router } from '@kit.ArkUI';
import CheckBox from '../components/CheckBox';
import Header from '../components/Header';

@Entry
@Component
struct Index {
  @State weight_value: number = 0
  @State height_value: number = 0
  @State bmi: number = 0

  build() {
    RelativeContainer() {
      Column(){
        Header()
        CheckBox()
        .height('12%')
        Row(){
          Text('Weight')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.blue_color'))
          TextInput({ placeholder: 'type your weight' })
            .placeholderColor(Color.Gray)
            .placeholderFont({ size: 12, weight: 500 })
            .caretColor(Color.Red)
            .fontColor(Color.Black)
            .fontSize(12)
            .onChange(val => this.weight_value = parseInt(val))
        }
        .width('60%')
        .height('14%')

        Row(){
          Text('Height')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.blue_color'))
          TextInput({ placeholder: 'type your weight' })
            .placeholderColor(Color.Gray)
            .placeholderFont({ size: 12, weight: 500 })
            .caretColor(Color.Red)
            .fontColor(Color.Black)
            .fontSize(12)
            .onChange(val => this.height_value = parseInt(val))
        }
        .width('60%')
        .height('14%')

        Button('Calculate')
          .width('100')
          .height('20')
          .backgroundColor($r('app.color.blue_color'))
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .borderColor(Color.Red)
          .onClick(() => {
            this.bmi = this.weight_value / ((this.height_value / 100) ** 2)
            router.pushUrl({
              url: 'pages/TabPage',
              params: { bmi: this.bmi.toFixed(1) }
            })
          })
      }
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}