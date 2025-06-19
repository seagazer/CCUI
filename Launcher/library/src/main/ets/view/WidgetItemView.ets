import { WidgetItem } from '../bean/WidgetItem';
import { DragController } from '../drag/DragController';
import { ItemTextView } from './ItemTextView';
import { ImageModifier } from '@kit.ArkUI';
import { LayoutConfig } from '../layout/LayoutConfig';

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct WidgetItemView {
    @Require @Param data: WidgetItem
    private dragController: DragController = DragController.getInstance()
    private dragImageModify = new ImageModifier().opacity(1)

    build() {
        Column() {
            Stack() {
                Image(this.data.image)
                    .syncLoad(true)
                    .width("100%")
                    .height("100%")
                    .objectFit(ImageFit.Cover)
                    .draggable(false)
            }
            .dragPreviewOptions({ mode: DragPreviewMode.DISABLE_SCALE, modifier: this.dragImageModify })
            .size(LayoutConfig.getInstance().getContentSize(this.data.spanX, this.data.spanY))
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