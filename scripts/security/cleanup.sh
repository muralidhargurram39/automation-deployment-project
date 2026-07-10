#!/bin/bash

set -e

echo "========================================"
echo "Cleaning Security Reports"
echo "========================================"

rm -rf reports/filesystem/*
rm -rf reports/image/*
rm -rf reports/summary/*

mkdir -p reports/filesystem
mkdir -p reports/image
mkdir -p reports/summary

echo
echo "Cleanup completed."
