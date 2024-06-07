[![](https://raw.githubusercontent.com/LUCIT-Systems-and-Development/lucit-backtesting/master/images/logo/lucit-backtesting.png)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting)

# lucit-backtesting - 'backtesting.py' maintained by LUCIT

[![GitHub Release](https://img.shields.io/github/release/LUCIT-Systems-and-Development/lucit-backtesting.svg?label=github)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/releases)
[![PyPi Release](https://img.shields.io/pypi/v/lucit-backtesting?color=blue)](https://pypi.org/project/lucit-backtesting/)
[![Supported Python Version](https://img.shields.io/pypi/pyversions/lucit_backtesting.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/github/license/LUCIT-Systems-and-Development/lucit-backtesting.svg?color=blue)](https://lucit-backtesting.docs.lucit.tech/license.html)
[![PyPi Downloads](https://pepy.tech/badge/lucit-backtesting)](https://pepy.tech/project/lucit-backtesting)
[![PyPi Downloads](https://pepy.tech/badge/lucit-backtesting/month)](https://pepy.tech/project/lucit-backtesting)
[![PyPi Downloads](https://pepy.tech/badge/lucit-backtesting/week)](https://pepy.tech/project/lucit-backtesting)
[![PyPI - Status](https://img.shields.io/pypi/status/unicorn_binance_local_depth_cache.svg)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/issues)
[![CodeQL](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/actions/workflows/codeql-analysis.yml)
[![Read the Docs](https://img.shields.io/badge/read-%20docs-yellow)](https://lucit-backtesting.docs.lucit.tech/)
[![Github](https://img.shields.io/badge/source-github-cbc2c8)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting)
[![Telegram](https://img.shields.io/badge/community-telegram-41ab8c)](https://t.me/unicorndevs)
[![Get Free Professional Support](https://img.shields.io/badge/chat-lucit%20support-004166)](https://www.lucit.tech/get-support.html)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/kernc?color=pink)](https://github.com/sponsors/kernc)

***Backtest trading strategies with Python.***

Kudos to ***Zach Lûster*** for the original project [`kernc/backtesting.py`](https://github.com/kernc/backtesting.py) 
which he built and maintained for 5 years. 

We at [LUCIT](https://www.lucit.tech) like to use `backtesting.py` with our customers in smaller projects. 
Unfortunately the project is missing important updates, and therefore we decided to fork the project and release new 
stable versions. 

We are happy to maintain [our forked repository](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting) 
and take care of code reviews, pull requests and releases and hope for good support from the community!

## Description
The package `lucit-backtesting` is a Python framework for inferring viability of trading strategies on historical (past) 
data. Of course, past performance is not indicative of future results, but a strategy that proves itself resilient in a 
multitude of market conditions can, with a little luck, remain just as reliable in the future. Improved upon the vision 
of Backtrader, and by all means surpassingly comparable to other accessible alternatives, Backtesting.py is lightweight, 
fast, user-friendly, intuitive, interactive, intelligent and, hopefully, future-proof. It is also documented well, 
including a handful of tutorials. 


| Feature | Description |
| ------- | ----------- |
| **Compatible with forex, crypto, stocks, futures ...** | Backtest any financial instrument for which you have access to historical candlestick data. |
| **Blazing fast, convenient** | Built on top of cutting-edge ecosystem libraries (i.e. Pandas, NumPy, Bokeh) for maximum usability. |
| **Small, clean API** | The API reference is easy to wrap your head around and fits on a single page. |
| **Technical indicator library agnostic** | Compatible with any sensible technical analysis library, such as TA-Lib or Tulip. |
| **Built-in optimizer** | Test hundreds of strategy variants in mere seconds, resulting in heatmaps you can interpret at a glance. |
| **High-level API** | Think market timing, swing trading, money management, stop-loss and take-profit prices, leverage, machine learning ... |
| **Interactive visualization** | Simulated trading results in telling interactive charts you can zoom into. See Example. |
| **Vectorized or event-based backtesting** | Signal-driven or streaming, model your strategy enjoying the flexibility of both approaches. |
| **Composable strategies** | Contains a library of predefined utilities and general-purpose strategies that are made to stack. |


## Installation

You can have either `backtesting.py` or `lucit-backtesting` installed, but not both!

    $ pip uninstall backtesting
    $ pip install lucit-backtesting


## Usage

The example shows a simple, unoptimized moving average cross-over strategy. It's a common introductory strategy and a 
pretty decent strategy overall, provided the market isn't whipsawing sideways.

We begin with 10,000 units of currency in cash, realistic 0.2% broker commission, and we trade through 9 years worth of 
Alphabet Inc. stock. 

Whenever the fast, 10-period simple moving average of closing prices crosses above the slower, 20-period moving average, 
we go long, buying as many stocks as we can afford. When it crosses below, we close our long position and go short 
(assuming the underlying instrument is actually a CFD and can be shorted).

We record most significant statistics this simple system produces on our data, and we show a plot for further manual 
inspection. 

```
#!/usr/bin/env python3
from backtesting import Backtest, Strategy
from backtesting.lib import crossover
from backtesting.test import SMA, GOOG

class SmaCross(Strategy):
    def init(self):
        price = self.data.Close
        self.ma1 = self.I(SMA, price, 10)
        self.ma2 = self.I(SMA, price, 20)

    def next(self):
        if crossover(self.ma1, self.ma2):
            self.buy()
        elif crossover(self.ma2, self.ma1):
            self.sell()

bt = Backtest(GOOG, SmaCross, commission=.002, exclusive_orders=True)
stats = bt.run()
bt.plot()
print(f"\r\nOverview:\r\n{stats}\r\n")
print(f"\r\nEquity:\r\n{stats['_equity_curve']}\r\n")
print(f"\r\nTrades:\r\n{stats['_trades']}")
```

Results in:

[![Backtesting HTML result](https://raw.githubusercontent.com/LUCIT-Systems-and-Development/lucit-backtesting/master/images/example_html_result.png)](https://lucit-backtesting.docs.lucit.tech/_static/example_result.html)

```
Overview:
Start                     2004-08-19 00:00:00
End                       2013-03-01 00:00:00
Duration                   3116 days 00:00:00
Exposure Time [%]                       94.27
Equity Final [$]                     68935.12
Equity Peak [$]                      68991.22
Return [%]                             589.35
Buy & Hold Return [%]                  703.46
Return (Ann.) [%]                       25.42
Volatility (Ann.) [%]                   38.43
Sharpe Ratio                             0.66
Sortino Ratio                            1.30
Calmar Ratio                             0.77
Max. Drawdown [%]                      -33.08
Avg. Drawdown [%]                       -5.58
Max. Drawdown Duration      688 days 00:00:00
Avg. Drawdown Duration       41 days 00:00:00
# Trades                                   93
Win Rate [%]                            53.76
Best Trade [%]                          57.12
Worst Trade [%]                        -16.63
Avg. Trade [%]                           1.96
Max. Trade Duration         121 days 00:00:00
Avg. Trade Duration          32 days 00:00:00
Profit Factor                            2.13
Expectancy [%]                           6.91
SQN                                      1.78
Kelly Criterion                        0.6134
_strategy              SmaCross(n1=10, n2=20)
_equity_curve                          Equ...
_trades                       Size  EntryB...
dtype: object

Equity:
                          Equity  DrawdownPct DrawdownDuration
Date
2023-01-02 13:03:00  10000.00000     0.000000              NaT
2023-01-02 13:04:00  10000.00000     0.000000              NaT
2023-01-02 13:05:00  10000.00000     0.000000              NaT
2023-01-02 13:06:00  10000.00000     0.000000              NaT
2023-01-02 13:07:00  10000.00000     0.000000              NaT
...                          ...          ...              ...
2024-01-01 00:55:00  11585.32229     0.050322              NaT
2024-01-01 00:56:00  11585.32229     0.050322              NaT
2024-01-01 00:57:00  11585.32229     0.050322              NaT
2024-01-01 00:58:00  11585.32229     0.050322              NaT
2024-01-01 00:59:00  11585.32229     0.050322 51 days 18:57:00

Trades:
    Size  EntryBar  ExitBar  EntryPrice    ExitPrice         PnL  ReturnPct           EntryTime            ExitTime   Tag        Duration
0      6     23305    23305  1524.62018  1517.480252  -42.839567  -0.004683 2023-01-18 17:28:00 2023-01-18 17:28:00  None 0 days 00:00:00
1      6     23308    23568  1522.60415  1521.180000   -8.544900  -0.000935 2023-01-18 17:31:00 2023-01-18 21:51:00  None 0 days 04:20:00
2      6     23569    32957  1525.95417  1543.780000  106.954980   0.011682 2023-01-18 21:52:00 2023-01-25 10:20:00  None 6 days 12:28:00
3      6     32958    40820  1546.69621  1542.810000  -23.317260  -0.002513 2023-01-25 10:21:00 2023-01-30 21:23:00  None 5 days 11:02:00
4      6     40821    43959  1550.01614  1690.310000  841.763160   0.090511 2023-01-30 21:24:00 2023-02-02 01:42:00  None 2 days 04:18:00
..   ...       ...      ...         ...          ...         ...        ...                 ...                 ...   ...             ...
78     5    488520   488665  2205.67724  2184.630000 -105.236200  -0.009542 2023-12-11 19:03:00 2023-12-11 21:28:00  None 0 days 02:25:00
79     5    488666   488673  2192.94917  2185.350000  -37.995850  -0.003465 2023-12-11 21:29:00 2023-12-11 21:36:00  None 0 days 00:07:00
80     5    488674   489911  2191.03344  2187.110000  -19.617200  -0.001791 2023-12-11 21:37:00 2023-12-12 18:14:00  None 0 days 20:37:00
81     5    489912   503782  2188.65633  2305.250000  582.968350   0.053272 2023-12-12 18:15:00 2023-12-22 09:25:00  None 9 days 15:10:00
82     5    514701   517609  2277.31150  2259.124026  -90.937372  -0.007986 2023-12-29 23:24:00 2023-12-31 23:52:00  None 2 days 00:28:00
```

## Bugs

Before [reporting bugs](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/issues) or posting to the
[discussion board](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/discussions) and 
please read [contributing guidelines](https://lucit-backtesting.docs.lucit.tech/contributing.html). We thank you!

## Commercial Support

[![Get professional and fast support](https://raw.githubusercontent.com/LUCIT-Systems-and-Development/unicorn-binance-suite/master/images/support/LUCIT-get-professional-and-fast-support.png)](https://www.lucit.tech/get-support.html)

***Do you need a developer, operator or consultant?*** [Contact us](https://www.lucit.tech/contact.html) for a non-binding initial consultation!