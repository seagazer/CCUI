import { LayoutConfig } from "./layout/LayoutConfig"
import { window } from "@kit.ArkUI"
import { Logger } from "./extensions/Logger"

const TAG = "[Launcher]"

/**
 *
 * Author: Seagazer
 * Date: 2025/6/19
 */
export class Launcher {
    private static window: window.Window | null = null
    private static context: UIContext | null = null

    static onUICreated(win: window.Window) {
        Logger.i(TAG, "onUICreated")
        Launcher.window = win
        Launcher.context = win.getUIContext()
        LayoutConfig.getInstance().setUIContext(Launcher.context)
        LayoutConfig.getInstance().onCreate()
    }
}