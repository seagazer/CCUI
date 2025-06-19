import { Workspace } from '@seagazer/workspace'

@Entry
@ComponentV2
struct Index {

    build() {
        Stack() {
            Workspace()
        }.width("100%")
        .height("100%")
    }
}