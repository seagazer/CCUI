import { IOccupancy } from "./IOccupancy";

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export class GridOccupancy implements IOccupancy {
    private readonly mCountX: number;
    private readonly mCountY: number;
    public readonly cells: boolean[][];

    constructor(countX: number, countY: number) {
        this.mCountX = countX;
        this.mCountY = countY;
        this.cells = Array(countX).fill(0).map(() => Array(countY).fill(false));
    }

    findVacantCell(vacantOut: number[], spanX: number, spanY: number): boolean {
        for (let y = 0; (y + spanY) <= this.mCountY; y++) {
            for (let x = 0; (x + spanX) <= this.mCountX; x++) {
                let available = !this.cells[x][y];
                out:
                    for (let i = x; i < x + spanX; i++) {
                        for (let j = y; j < y + spanY; j++) {
                            available = available && !this.cells[i][j];
                            if (!available) {
                                break out;
                            }
                        }
                    }
                if (available) {
                    vacantOut[0] = x;
                    vacantOut[1] = y;
                    return true;
                }
            }
        }
        return false;
    }

    copyTo(dest: GridOccupancy): void {
        for (let i = 0; i < this.mCountX; i++) {
            for (let j = 0; j < this.mCountY; j++) {
                dest.cells[i][j] = this.cells[i][j];
            }
        }
    }

    isVacant(x: number, y: number, spanX: number, spanY: number): boolean {
        const x2 = x + spanX - 1
        const y2 = y + spanY - 1
        if (x < 0 || y < 0 || x2 >= this.mCountX || y2 >= this.mCountY) {
            return false
        }
        for (let i = x; i <= x2; i++) {
            for (let j = y; j <= y2; j++) {
                if (this.cells[i][j]) {
                    return false
                }
            }
        }
        return true
    }

    mark(cellX: number, cellY: number, spanX: number, spanY: number, value: boolean): void {
        if (cellX < 0 || cellY < 0) {
            return;
        }
        for (let x = cellX; x < cellX + spanX && x < this.mCountX; x++) {
            for (let y = cellY; y < cellY + spanY && y < this.mCountY; y++) {
                this.cells[x][y] = value;
            }
        }
    }

    clear(): void {
        this.mark(0, 0, this.mCountX, this.mCountY, false);
    }

    toString(): string {
        let s = "Grid: \n";
        for (let y = 0; y < this.mCountY; y++) {
            for (let x = 0; x < this.mCountX; x++) {
                s += (this.cells[x][y] ? 1 : 0) + " ";
            }
            s += "\n";
        }
        return s;
    }
}