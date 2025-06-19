import { AppItem } from './bean/AppItem'
import { DockData } from './bean/DockData'
import { FolderItem } from './bean/FolderItem'
import { ItemType } from './bean/ItemType'
import { WidgetItem } from './bean/WidgetItem'
import lazy { PageDataManager } from './data/PageDataManager'
import { Logger } from './extensions/Logger'
import { LayoutConfig } from './layout/LayoutConfig'
import { LayoutManager } from './layout/LayoutManager'
import { CellViewPage } from './view/CellViewPage'

const TAG = "[Workspace]"

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct Workspace {
    private dockList: DockData = new DockData()

    aboutToAppear(): void {
    }

    build() {
        Column() {
            CellViewPage()
                .width("100%")
                .height(LayoutConfig.getInstance().cellViewPageHeight)
                .backgroundColor("#80ddcad1")

            Blank()

            Row()
                .width("100%")
                .height(32)
                .backgroundColor("#ccf05050")

            Stack() {
                Column() {
                    Row() {
                        Button("+Page")
                            .onClick(() => {
                                PageDataManager.getInstance().addPage()
                            })
                        Button("-Page")
                            .onClick(() => {
                                PageDataManager.getInstance().deletePage(PageDataManager.getInstance().getPageSize() - 1)
                            })
                    }

                    Row() {
                        Button("+App")
                            .onClick(() => {
                                let app = new AppItem("App-" + i, 0)
                                app.title = app.id
                                app.icon = $r("app.media.app1")
                                let handle = LayoutManager.getInstance().layoutItem(app)
                                if (handle) {
                                    PageDataManager.getInstance().addItem(0, app)
                                    i++
                                }
                            })
                        Button("+F2x2")
                            .onClick(() => {
                                let folder = new FolderItem("Folder-" + i, 0)
                                folder.setType(ItemType.FOLDER_2x2)
                                folder.title = folder.id
                                let handle = LayoutManager.getInstance().layoutItem(folder)
                                if (handle) {
                                    PageDataManager.getInstance().addItem(0, folder)
                                    i++
                                }
                            })
                        Button("+W4x2")
                            .onClick(() => {
                                let widget = new WidgetItem("Widget-" + i, 0)
                                widget.setType(ItemType.WIDGET_4x2)
                                widget.title = widget.id
                                let handle = LayoutManager.getInstance().layoutItem(widget)
                                if (handle) {
                                    PageDataManager.getInstance().addItem(0, widget)
                                    i++
                                }
                            })
                    }
                }
                .width("100%")
                .height("100%")
                .justifyContent(FlexAlign.SpaceEvenly)
                .backgroundColor("#80a53bd3")
            }
            .width("100%")
            .height(LayoutConfig.getInstance().dockHeight)
            .padding({ top: LayoutConfig.getInstance().dockPaddingTop, bottom: LayoutConfig.getInstance().dockPaddingBottom })
            .backgroundColor("#803b87d3")
        }
        .width("100%")
        .height("100%")
        .padding({ top: LayoutConfig.getInstance().workspacePaddingTop, bottom: LayoutConfig.getInstance().workspacePaddingBottom })
        .backgroundImage($r('app.media.wallpaper'))
        .backgroundImageSize(ImageSize.Cover)
    }
}

let i = 100