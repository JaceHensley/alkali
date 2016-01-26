#!/usr/bin/env bash

set -e

pub get

DART_FLAGS=--checked pub run dart_dev test
