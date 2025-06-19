import { CellItem } from '../bean/CellItem'
import { LayoutConfig } from '../layout/LayoutConfig'

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct ItemTextView {
    @Require @Param data: CellItem

    build() {
        Text(this.data.title)
            .width("100%")
            .height(LayoutConfig.getInstance().cellTitleHeight)
            .fontSize(12)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .padding({ left: 8, right: 8 })
        // .border({ color: "#cce57c7c", width: 1 })
    }
}