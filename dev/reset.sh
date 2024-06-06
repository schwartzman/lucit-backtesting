#!/usr/bin/bash

rm *.log
rm dev/*.log

rm build -r
rm dist -r
rm *.egg-info -r
rm stubs -r
rm out -r

rm lucit_backtesting/*.c
rm lucit_backtesting/*.html
rm lucit_backtesting/*.dll
rm lucit_backtesting/*.so
rm lucit_backtesting/*.pyi
