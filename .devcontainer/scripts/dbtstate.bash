#!/bin/bash

# Set default values
branch="main"
profile="prod"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    update)
      shift
      while [[ $# -gt 0 ]]; do
        case "$1" in
          -b|--branch)
            branch="$2"
            shift
            shift
            ;;
          -p|--profile)
            profile="$2"
            shift
            shift
            ;;
          *)
            echo "Invalid option: $1" >&2
            exit 1
            ;;
        esac
      done
      WORKING_BRANCH=$(git rev-parse --abbrev-ref HEAD)
      git checkout "${branch}"
      dbt compile --target "${profile}"
      cp target/manifest.json artifacts/manifest.json
      git checkout "$WORKING_BRANCH"
      exit 0
      ;;
    debug)
      shift
      while [[ $# -gt 0 ]]; do
        case "$1" in
          -p|--profile)
            profile="$2"
            shift
            shift
            ;;
          *)
            echo "Invalid option: $1" >&2
            exit 1
            ;;
        esac
      done
      dbt debug --target "${profile}" | tee /dev/tty | tail -n 1 | grep -q "All checks passed!"
      if [ $? -ne 0 ]; then
        echo "Debug checks failed" >&2
        exit 1
      fi
      exit 0
      ;;
    help)
      echo "Usage: $0 {update|debug}"
      exit 0
      ;;
    *)
      echo "Invalid command: $1" >&2
      exit 1
      ;;
  esac
done

echo "No command specified. Use '$0 help' for usage information." >&2
exit 1