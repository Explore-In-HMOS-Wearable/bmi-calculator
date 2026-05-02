import { relationalStore } from '@kit.ArkData';

export interface BMIRecord {
  id?: number;
  weight: number;
  height: number;
  bmi: number;
  date: number;
}

export class DBManager {
  private static instance: DBManager;
  private rdbStore: relationalStore.RdbStore | null = null;
  private readonly TABLE_NAME = 'bmi_records';

  private constructor() {
  }

  public static getInstance(): DBManager {
    if (!DBManager.instance) {
      DBManager.instance = new DBManager();
    }
    return DBManager.instance;
  }

  public async init(context: Context): Promise<void> {
    const config: relationalStore.StoreConfig = {
      name: 'bmi.db',
      securityLevel: relationalStore.SecurityLevel.S1
    };

    const SQL_CREATE_TABLE = `CREATE TABLE IF NOT EXISTS ${this.TABLE_NAME} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      weight REAL,
      height REAL,
      bmi REAL,
      date INTEGER
    )`;

    try {
      this.rdbStore = await relationalStore.getRdbStore(context, config);
      await this.rdbStore.executeSql(SQL_CREATE_TABLE);
    } catch (err) {
      console.error('DBManager init failed:', JSON.stringify(err));
    }
  }

  public async insertRecord(record: BMIRecord): Promise<number> {
    if (!this.rdbStore) {
      return -1;
    }
    const valueBucket: relationalStore.ValuesBucket = {
      weight: record.weight,
      height: record.height,
      bmi: record.bmi,
      date: record.date
    };
    return await this.rdbStore.insert(this.TABLE_NAME, valueBucket);
  }

  public async queryAll(): Promise<BMIRecord[]> {
    if (!this.rdbStore) {
      return [];
    }
    let predicates = new relationalStore.RdbPredicates(this.TABLE_NAME);
    predicates.orderByDesc('date');
    let resultSet = await this.rdbStore.query(predicates);
    let records: BMIRecord[] = [];
    while (resultSet.goToNextRow()) {
      records.push({
        id: resultSet.getLong(resultSet.getColumnIndex('id')),
        weight: resultSet.getDouble(resultSet.getColumnIndex('weight')),
        height: resultSet.getDouble(resultSet.getColumnIndex('height')),
        bmi: resultSet.getDouble(resultSet.getColumnIndex('bmi')),
        date: resultSet.getLong(resultSet.getColumnIndex('date'))
      });
    }
    resultSet.close();
    return records;
  }
}
