
interface IRandomSynced {
    numberAt: (index: number) => number;
}

interface IRandomSyncedConstructor {
    new(seed: number, min?: number, max?: number): IRandomSynced;
}

declare const RandomSynced: IRandomSyncedConstructor;
export = RandomSynced;