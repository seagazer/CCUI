import { AppItem } from '../bean/AppItem'
import { DockData } from '../bean/DockData'

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct DockView {
    @Require @Param data: DockData

    build() {
        Row() {
            List() {
                ForEach(this.data.itemList, (item: AppItem) => {
                    ListItem() {
                        Image(item.icon)
                    }
                })
            }
        }
        .width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)
        .backgroundColor("#cccc")
    }
}