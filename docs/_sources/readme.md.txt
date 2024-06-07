[![](https://raw.githubusercontent.com/LUCIT-Systems-and-Development/lucit-backtesting/master/images/logo/lucit-backtesting.png)](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting)

lucit-backtesting - 'backtesting.py' maintained by LUCIT
========================================================

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

Backtest trading strategies with Python.

Kudos to ***Zach Lûster*** for the original project [`kernc/backtesting.py`](https://github.com/kernc/backtesting.py) 
which he built and maintained for 5 years. 

We at [LUCIT](https://www.lucit.tech) like to use `backtesting.py` with our customers in smaller projects. 
Unfortunately the project is missing important updates, and therefore we decided to fork the project and release new 
stable versions. 

We are happy to maintain [our forked repository](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting) 
and take care of code reviews, pull requests and releases and hope for good support from the community!

Description
-----------
`lucit-backtesting` is a Python framework for inferring viability of trading strategies on historical (past) data. Of 
course, past performance is not indicative of future results, but a strategy that proves itself resilient in a multitude 
of market conditions can, with a little luck, remain just as reliable in the future. Improved upon the vision of 
Backtrader, and by all means surpassingly comparable to other accessible alternatives, Backtesting.py is lightweight, 
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


Installation
------------
You can have either `backtesting.py` or `lucit-backtesting` installed, but not both!

    $ pip uninstall backtesting
    $ pip install lucit-backtesting


Usage
-----
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


bt = Backtest(GOOG, SmaCross, commission=.02,
              exclusive_orders=True)
stats = bt.run()
bt.plot()
```

Results in:

<iframe src="https://lucit-backtesting.docs.lucit.tech/_static/example_result.html" width="100%" height="500px" frameborder="0"></iframe>

```
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
```

Features
--------
* Simple, well-documented API
* Blazing fast execution
* Built-in optimizer
* Library of composable base strategies and utilities
* Indicator-library-agnostic
* Supports _any_ financial instrument with candlestick data
* Detailed results
* Interactive visualizations

![xkcd.com/1570](https://imgs.xkcd.com/comics/engineer_syllogism.png)


Bugs
----
Before [reporting bugs](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/issues) or posting to the
[discussion board](https://github.com/LUCIT-Systems-and-Development/lucit-backtesting/discussions),
please read [contributing guidelines](https://lucit-backtesting.docs.lucit.tech/contributing.html), 
particularly the section about crafting useful bug reports and ```` ``` ````-fencing your code. We thank you!

