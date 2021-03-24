#!/usr/bin/env python3

import sys
import os.path
import glob

import pandas as pd


SCREEN_DIR = sys.argv[1]
MULT_OUT = sys.argv[2]

screen_header = [
    "Identity",
    "Shared hashes",
    "Median multiplicity",
    "P-value",
    "Query ID",
    "Query comment"
]

mult_list = []
for fn in glob.glob(os.path.join(SCREEN_DIR, "*")):
    screen_bn = os.path.basename(fn)
    screen_id = os.path.splitext(screen_bn)[0]
    screen_df = pd.read_table(fn, sep='\t', names=screen_header)
    mult_series = screen_df \
        .set_index(["Query ID", "Query comment"])["Median multiplicity"]
    mult_series.name = screen_id
    mult_list.append(mult_series)

mult_df = pd.DataFrame(mult_list).T
mult_df.fillna(0, inplace=True)
mult_df.to_csv(MULT_OUT, sep='\t', float_format='%.0f',
    index_label=["Query ID", "Query comment"])