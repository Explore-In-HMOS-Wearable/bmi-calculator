import { common } from '@kit.AbilityKit';

@Component
export struct TabPage {
  @State bmiValue: number = 0;
  @Consume('NavPathStack') pageStack: NavPathStack;
  context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  aboutToAppear() {
    const tab = this.context.resourceManager.getStringSync($r('app.string.tab').id)
    const params: Object[] = this.pageStack.getParamByName(tab) as Object[];
    if (params && params.length > 0) {
      this.bmiValue = params[0] as number;
    }
  }

  build() {
    NavDestination() {
      Column() {
        Text($r('app.string.bmi_header'))
          .fontSize('14fp')
          .fontColor($r('app.color.text_secondary'))
          .margin({ top: '10vp' })

        Column() {
          Gauge({ value: this.bmiValue, min: 10, max: 50 }) {
            Column() {
              Text(this.bmiValue.toString())
                .fontSize('24fp')
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
              Text($r('app.string.bmi_label'))
                .fontSize('11fp')
                .fontColor($r('app.color.text_secondary'))

              Text(this.getCategory())
                .fontSize('16fp')
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCategoryColor())
                .margin({ top: '2vp' })

              Text(this.getMessage())
                .fontSize('13fp')
                .fontColor($r('app.color.text_primary'))
                .textAlign(TextAlign.Center)
                .padding({ left: '16vp', right: '16vp' })
            }
            .margin({ top: 20 })
          }
          .startAngle(210)
          .endAngle(150)
          .colors([[0x3CAAFF, 0.2], [0x44E643, 0.2], [0xFDE912, 0.2], [0xFF9416, 0.2], [0xF60207, 0.2]])
          .strokeWidth(12)
          .width(200)
          .height(200)
          .margin({ top: '4vp' })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.background_color'))
    }
    .hideTitleBar(true)
  }

  private getCategory(): Resource {
    if (this.bmiValue < 18.5) {
      return $r('app.string.category_underweight');
    }
    if (this.bmiValue < 25.0) {
      return $r('app.string.category_normal');
    }
    if (this.bmiValue < 30.0) {
      return $r('app.string.category_overweight');
    }
    if (this.bmiValue < 35.0) {
      return $r('app.string.category_obese1');
    }
    return $r('app.string.category_obese2');
  }

  private getCategoryColor(): Resource {
    if (this.bmiValue < 18.5) {
      return $r('app.color.bmi_underweight');
    }
    if (this.bmiValue < 25.0) {
      return $r('app.color.bmi_normal');
    }
    if (this.bmiValue < 30.0) {
      return $r('app.color.bmi_overweight');
    }
    if (this.bmiValue < 35.0) {
      return $r('app.color.bmi_obese1');
    }
    return $r('app.color.bmi_obese2');
  }

  private getMessage(): Resource {
    if (this.bmiValue < 18.5) {
      return $r('app.string.msg_underweight');
    }
    if (this.bmiValue < 25.0) {
      return $r('app.string.msg_normal');
    }
    if (this.bmiValue < 30.0) {
      return $r('app.string.msg_overweight');
    }
    return $r('app.string.msg_obese');
  }
}