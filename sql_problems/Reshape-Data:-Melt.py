import pandas as pd

def meltTable(report: pd.DataFrame) -> pd.DataFrame:
    melt_df = pd.melt(report, id_vars='product', value_vars = ['quarter_1','quarter_2','quarter_3','quarter_4'])
    melt_df.rename(columns={'variable':'quarter', 'value':'sales'},inplace=True)
    return melt_df