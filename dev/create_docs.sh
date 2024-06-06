#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#
# File: dev/sphinx/create_docs.sh
#
# Author: LUCIT Systems and Development
#
# Copyright (c) 2019-2024, LUCIT Systems and Development (https://www.lucit.tech)
# All rights reserved.

# set -xeuo pipefail

cd doc
./build.sh
echo "Creating CNAME file for GitHub."
echo "lucit-backtesting.docs.lucit.tech" >> ./build/lucit_backtesting/CNAME
cp ./build/lucit_backtesting/* -r ../docs
rm ./build/lucit_backtesting -r