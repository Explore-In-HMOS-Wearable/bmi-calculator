class MyCurve {
  public title: string;
  public curve: Curve;
  public color: Color | string;
  public position: number;

  constructor(title: string, curve: Curve, color: Color | string = '', position: number) {
    this.title = title;
    this.curve = curve;
    this.color = color;
    this.position = position;
  }
}

const myCurves: MyCurve[] = [
  new MyCurve(' Linear', Curve.Linear, '#f60207', 162),
  new MyCurve(' Ease', Curve.Ease, '#ff9416', 120),
  new MyCurve(' EaseIn', Curve.EaseIn, '#fde912', 90),
  new MyCurve(' EaseOut', Curve.EaseOut, '#44e643', 54),
  new MyCurve(' EaseInOut', Curve.EaseInOut, '#3caaff', 18)
]

@Component
export struct TabPage {
  @State dRotate: number = 0;
  @State bmiValue: number = 0;
  @Consume('NavPathStack') pageStack: NavPathStack;

  aboutToAppear() {
    const param = this.pageStack.getParamByName('TabPage')[0] as number;
    this.bmiValue = param;

    setTimeout(() => {
      if (!this.dRotate) {
        if (this.bmiValue < 18.5) {
          this.dRotate = 18;
        } else if (this.bmiValue < 24.9) {
          this.dRotate = 54;
        } else if (this.bmiValue < 29.9) {
          this.dRotate = 90;
        } else if (this.bmiValue < 39.9) {
          this.dRotate = 120;
        } else if (this.bmiValue >= 40.0) {
          this.dRotate = 162;
        }
      }
    }, 300);
  }

  build() {
    Column() {
      NavDestination() {
        Stack() {
          Image($r('app.media.table'))
            .width('100%')
            .height('100%')
            .padding({
              bottom: 110
            })
          ForEach(myCurves, (item: MyCurve) => {
            Column() {
              Row()
                .width(10)
                .height(10)
                .borderRadius(15)
                .backgroundColor(item.color)
                .clip(true)
            }
            .width('50%')
            .height('55%')
            .rotate({ angle: this.dRotate - 90 })
            .animation({
              duration: 2000,
              iterations: -1,
              curve: item.curve,
              delay: 100
            })
          }, (item: string, index: number) => item)
          Column() {
            Text(`BMI: ${this.bmiValue}`)
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.blue_color'))
              .height('14%')
            Text(this.getMessageBasedOnBMI())
              .fontStyle(FontStyle.Italic)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Red)
              .height('14%')
              .width('80%')
              .padding({
                top: 10
              })
          }
          .padding({
            top: 20
          })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
      }
      .hideTitleBar(true)
      .mode(NavDestinationMode.STANDARD)
    }
  }

  private getMessageBasedOnBMI(): string {
    const bmi = this.bmiValue;
    if (bmi < 18.5) {
      return 'Your journey to strength starts here—small steps can lead to powerful transformations!';
    } else if (bmi < 24.9) {
      return 'You are in a great place—keep up the balance and stay strong and energized!';
    } else if (bmi < 29.9) {
      return 'Every healthy choice counts—you are closer to your goals than you think!';
    } else if (bmi < 39.9) {
      return 'This is your moment to rise—consistency will lead you to a healthier you!';
    } else {
      return 'You have the power to change your story—every effort is a step toward a brighter, healthier future!';
    }
  }
}