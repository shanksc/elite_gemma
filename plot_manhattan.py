import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

usage = '<tsv> <out>'
if len(sys.argv) != 3:
    print(usage)
    sys.exit()
#chr     rs      ps      n_miss  allele1 allele0 af      beta    se      logl_H1 l_remle p_wald

df = pd.read_csv(sys.argv[1], sep='\t', index_col=False) 
        #names=['chr','rs','ps','n_miss','allele1','allele0','af','beta','se','logl_H1', 'l_remle', 'p_wald'])
print(df.head())
df['-log10'] = -np.log10(df['p_wald'])
#df.reset_index(inplace=True, drop=True)
df['i'] = df.index
print(df.head())


plot = sns.relplot(data=df, x='i', y='-log10', aspect=2.5, hue='chr', palette=sns.color_palette('colorblind'), legend=None, linewidth=0, s=11)
plt.margins(x=0.01, y=0.01)
chrom_df=df.groupby('chr')['i'].median()
plot.ax.set_xlabel('Chromsome')
plot.ax.set_xticks(chrom_df, labels=[x for x in range(1, len(chrom_df.index)+1)])
plot.ax.tick_params(axis='x', labelsize=9)
plt.ylabel('-log10(p-value)')
plt.axhline(y=7.3, linestyle='--', color='black', linewidth=1.5)
plt.savefig(sys.argv[2])

#percentile = df['pbs'].quantile(.9999)
#print(percentile)
#top = df[df['pbs'] > percentile]
#top = top.sort_values('pbs', ascending=False)
#print(top.head())

