#!/usr/bin/env bash

pub get

DART_FLAGS=--checked pub run dart_dev coverage
