import CheckBox from '../components/CheckBox';
import Header from '../components/Header';
import { TabPage } from './TabPage';
import { HistoryPage } from './HistoryPage';
import { DBManager } from '../utils/DBManager';
import { vibrator } from '@kit.SensorServiceKit';
import { CustomValuePickerDialog } from '../components/CustomValuePickerDialog';

@Entry
@Component
struct Index {
  @State weightValue: number = 70
  @State heightValue: number = 170
  @State isMale: boolean = true
  @State focusOnWeight: boolean = true
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  scroller: Scroller = new Scroller();
  weightDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomValuePickerDialog({
      title: $r('app.string.weight'),
      range: this.generateRange(30, 200),
      selectedIndex: this.weightValue - 30,
      confirm: (val: string) => {
        this.weightValue = parseInt(val)
      }
    }),
    alignment: DialogAlignment.Center,
    customStyle: true
  })
  heightDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomValuePickerDialog({
      title: $r('app.string.height'),
      range: this.generateRange(100, 250),
      selectedIndex: this.heightValue - 100,
      confirm: (val: string) => {
        this.heightValue = parseInt(val)
      }
    }),
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  @Builder
  PagesMap(name: string) {
    if (name === 'TabPage') {
      TabPage()
    } else if (name === 'HistoryPage') {
      HistoryPage()
    }
  }

  build() {
    Navigation(this.pageStack) {
      Column() {
        Header()

        Scroll(this.scroller) {
          Column({ space: 8 }) {

            CheckBox({
              isMale: $isMale,
              onGenderChange: () => {
                this.triggerHaptic()
              }
            })

            Row() {
              Text($r('app.string.weight'))
                .fontSize('14fp')
                .fontColor(this.focusOnWeight ? $r('app.color.accent_color') : $r('app.color.text_secondary'))
              Blank()
              Text(`${this.weightValue} kg`)
                .fontSize('16fp')
                .fontColor(this.focusOnWeight ? $r('app.color.accent_color') : $r('app.color.text_primary'))
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding('12vp')
            .backgroundColor(this.focusOnWeight ? '#3337a1e0' : '#1AFFFFFF')
            .borderRadius('20vp')
            .borderWidth(this.focusOnWeight ? 2 : 0)
            .borderColor($r('app.color.accent_color'))
            .onClick(() => {
              this.triggerHaptic()
              this.focusOnWeight = true
              this.weightDialogController.open()
            })

            Row() {
              Text($r('app.string.height'))
                .fontSize('14fp')
                .fontColor(!this.focusOnWeight ? $r('app.color.accent_color') : $r('app.color.text_secondary'))
              Blank()
              Text(`${this.heightValue} cm`)
                .fontSize('16fp')
                .fontColor(!this.focusOnWeight ? $r('app.color.accent_color') : $r('app.color.text_primary'))
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding('12vp')
            .backgroundColor(!this.focusOnWeight ? '#3337a1e0' : '#1AFFFFFF')
            .borderRadius('20vp')
            .borderWidth(!this.focusOnWeight ? 2 : 0)
            .borderColor($r('app.color.accent_color'))
            .onClick(() => {
              this.triggerHaptic()
              this.focusOnWeight = false
              this.heightDialogController.open()
            })

            Button($r('app.string.calculate'))
              .width('100%')
              .height('40vp')
              .backgroundColor($r('app.color.accent_color'))
              .onClick(async () => {
                this.triggerHaptic()
                let bmi = parseFloat((this.weightValue / ((this.heightValue / 100)**2)).toFixed(1))
                await DBManager.getInstance().insertRecord({
                  weight: this.weightValue,
                  height: this.heightValue,
                  bmi: bmi,
                  date: Date.now()
                })
                this.pageStack.pushPath({
                  name: 'TabPage',
                  param: bmi
                })
              })

            Button($r('app.string.history'))
              .width('100%')
              .height('40vp')
              .backgroundColor(Color.Transparent)
              .borderWidth('1vp')
              .borderColor($r('app.color.accent_color'))
              .fontColor($r('app.color.accent_color'))
              .onClick(() => {
                this.triggerHaptic()
                this.pageStack.pushPath({ name: 'HistoryPage' })
              })
          }
          .padding({ left: '5%', right: '5%', bottom: '25%' })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.background_color'))
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PagesMap)
  }

  private triggerHaptic() {
    try {
      vibrator.startVibration({
        type: 'time',
        duration: 10
      }, {
        id: 0,
        usage: 'touch'
      });
    } catch (err) {
      console.error('Haptic failed', JSON.stringify(err));
    }
  }

  generateRange(start: number, end: number): string[] {
    let range: string[] = []
    for (let i = start; i <= end; i++) {
      range.push(i.toString())
    }
    return range
  }
}
