import { Direction } from './Direction';
import Cell from './Cell';

interface Grid<T> {
    getCell(x: number, y: number): Cell<T>;
    setCell(x: number, y: number, value: T): void;
    getWidth(): number;
    getHeight(): number;
    getNextCell(x: number, y: number, direction: Direction): Cell<T>;
}

interface GridConstructor<T> {
    new(width: number, height: number, initialValue: T): Grid<T>;
}

declare const Grid: GridConstructor<any>;
export = Grid;