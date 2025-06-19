import { AppItem } from '../bean/AppItem'
import { ItemState } from '../bean/ItemState'
import { DragController } from '../drag/DragController'
import { ItemTextView } from './ItemTextView'
import { ImageModifier } from '@kit.ArkUI'
import { LayoutConfig } from '../layout/LayoutConfig'

const TAG = "[AppItemView]"

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct AppItemView {
    @Require @Param data: AppItem
    private dragController: DragController = DragController.getInstance()
    private dragImageModify = new ImageModifier().opacity(1)

    aboutToAppear(): void {
    }

    build() {
        Column() {
            // todo 动态计算图标尺寸
            // todo 创建文件夹动画
            Stack() {
                Image(this.data.icon)
                    .syncLoad(true)
                    .width("100%")
                    .height("100%")
                    .objectFit(ImageFit.Contain)
                    .draggable(false)
                    .borderRadius(12)
            }
            .size(LayoutConfig.getInstance().getContentSize(this.data.spanX, this.data.spanY))
            // .dragPreviewOptions({ mode: DragPreviewMode.DISABLE_SCALE, modifier: this.dragImageModify })
            .onPreDrag((status: PreDragStatus) => {
                this.dragController.onPreDrag(this.data, status)
            })
            .onDragStart((event: DragEvent) => {
                this.dragController.onDragStart(this.data, event)
            })
            .onDragEnd((event: DragEvent) => {
                this.dragController.onDragEnd(this.data, event)
            })

            // .border({ width: 1 })

            ItemTextView({ data: this.data })
        }.width("100%")
        .height("100%")
        .justifyContent(FlexAlign.End)
    }
}