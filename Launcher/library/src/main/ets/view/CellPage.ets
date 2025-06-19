import { AppItem } from '../bean/AppItem'
import { CellItem } from '../bean/CellItem'
import { FolderItem } from '../bean/FolderItem'
import { ItemState } from '../bean/ItemState'
import { WidgetItem } from '../bean/WidgetItem'
import { AppItemView } from './AppItemView'
import { FolderItemView } from './FolderItemView'
import { WidgetItemView } from './WidgetItemView'
import { PageDataManager } from '../data/PageDataManager'
import { Logger } from '../extensions/Logger'
import { PageData } from '../data/PageData'
import { LayoutConfig } from '../layout/LayoutConfig'
import { OnItemChangedListener } from '../data/OnItemChangedListener'
import { ItemTypeHelper } from '../extensions/ItemTypeHelper'

const TAG = "[CellPage]"

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct CellPage {
    @Require @Param pageData: PageData
    private screenId: number = -1
    @Local itemList: CellItem[] = []
    private pageDataManger: PageDataManager = PageDataManager.getInstance()
    private onPageDataChangedListener: OnItemChangedListener = {
        onItemAdd: (screenId: number, item: CellItem) => {
            Logger.d(TAG, "onDataAdd screenId= " + screenId + ", item= " + item.id)
        },
        onItemDelete: (screenId: number, item: CellItem) => {
            Logger.d(TAG, "onDataDelete screenId= " + screenId + ", item= " + item.id)
        },
        onItemUpdate: (screenId: number, item: CellItem, newValue: CellItem) => {
            Logger.d(TAG, "onDataUpdate screenId= " + screenId + ", item= " + item.id)
        },
    }
    @Local cellXSize: number = 1
    @Local cellYSize: number = 1

    aboutToAppear(): void {
        this.pageDataManger.addOnPageDataChangedListener(this.onPageDataChangedListener)
        this.screenId = this.pageData.screenId
        this.itemList = this.pageData.itemList
        const layoutTemplate = LayoutConfig.getInstance().getTemplate()
        this.cellXSize = layoutTemplate.x
        this.cellYSize = layoutTemplate.y
        Logger.i(TAG, "create page= " + this.screenId + ", layoutTemplate= " + JSON.stringify(layoutTemplate))
    }

    aboutToDisappear(): void {
        this.pageDataManger.removeOnPageDataChangedListener(this.onPageDataChangedListener!)
    }

    build() {
        Column() {
            Grid() {
                Repeat(this.itemList)
                    .each((repeatData) => {
                        GridItem() {
                            if (ItemTypeHelper.isApp(repeatData.item)) {
                                AppItemView({ data: repeatData.item as AppItem })
                            } else if (ItemTypeHelper.isFolder(repeatData.item)) {
                                FolderItemView({ data: repeatData.item as FolderItem })
                            } else if (ItemTypeHelper.isWidget(repeatData.item)) {
                                WidgetItemView({ data: repeatData.item as WidgetItem })
                            }
                        }
                        .columnStart(repeatData.item.cellX)
                        .columnEnd(repeatData.item.cellX + repeatData.item.spanX - 1)
                        .rowStart(repeatData.item.cellY)
                        .rowEnd(repeatData.item.cellY + repeatData.item.spanY - 1)
                        .visibility(repeatData.item.state == ItemState.DRAG ? Visibility.Hidden : Visibility.Visible)
                        .border({ width: LayoutConfig.Debug ? 1 : 0 })
                    })
                    .key((item) => item.id)
            }
            .columnsTemplate("1fr ".repeat(this.cellXSize))
            .rowsTemplate("1fr ".repeat(this.cellYSize))
            .onSizeChange((_, size) => {
                Logger.d(TAG, "onSizeChanged= " + JSON.stringify(size))
            })
        }
    }
}