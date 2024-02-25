
interface Guid {
}

interface IGuidConstructor {
    new(): Guid;
    newGuid(size: number): string;
}

declare const Guid: IGuidConstructor;
export = Guid;