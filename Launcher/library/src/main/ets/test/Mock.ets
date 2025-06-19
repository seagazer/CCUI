import { LayoutManager } from '../layout/LayoutManager'
import { AppItem } from '../bean/AppItem'
import { CellItem } from '../bean/CellItem'
import { FolderItem } from '../bean/FolderItem'
import { ItemType } from '../bean/ItemType'
import { WidgetItem } from '../bean/WidgetItem'

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
export function mock() {
    // todo mock data
    let itemList: CellItem[] = []
    const iconList =
        [$r('app.media.app0'), $r('app.media.app1'), $r('app.media.app2'), $r('app.media.app3'), $r('app.media.app4'), $r('app.media.app5'),
            $r('app.media.app6'), $r('app.media.app7'),]
    for (let i = 0; i < 11; i++) {
        let item: CellItem
        if (i == 4) { //Folder-4
            item = new FolderItem("folder_" + i, 0)
            const folderItem = item as FolderItem
            folderItem.title = "Folder-" + i
            // folder app list
            for (let i = 0; i < 4; i++) {
                const appItem = new AppItem("sa_" + i, 0)
                appItem.title = "SApp-" + i
                appItem.icon = iconList[i%iconList.length]
                folderItem.itemList.push(appItem)
            }
        } else if (i == 6) { //Folder-6
            item = new FolderItem("folder_" + i, 0)
            item.setType(ItemType.FOLDER_2x2)
            const folderItem = item as FolderItem
            folderItem.title = "Folder-" + i
            // folder app list
            const appItem = new AppItem("sa_", 0)
            appItem.title = "SApp-" + i
            appItem.icon = iconList[i%iconList.length]
            folderItem.itemList.push(appItem)
        } else if (i == 8) { //Widget-0
            item = new WidgetItem("widget_" + i, 0)
            const widgetItem = item as WidgetItem
            widgetItem.setType(ItemType.WIDGET_4x2)
            item.title = "Widget-" + i
            widgetItem.image = $r("app.media.widget")
        } else {
            item = new AppItem("app_" + i, 0)
            const appItem = item as AppItem
            appItem.title = "App-" + i
            appItem.icon = iconList[i%iconList.length]
        }
        let result = LayoutManager.getInstance().layoutItem(item)
        if (result) {
            itemList.push(item)
        }
    }
    return itemList
}