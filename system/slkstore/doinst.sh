chmod -R a+w /opt/slkstore

cat <<EOF

slkstore - Package Store for Slackware 64-bit Stable

Description:
  A package management store specifically designed for Slackware Linux
  64-bit stable releases. Provides an easy-to-use interface for browsing,
  searching, and managing Slackware packages.

Usage: slkstore [options]

Options:
  --help          Show this help message
  --local         Run PHP server on 127.0.0.1:8000 (localhost only, no GUI)
  --remote        Run PHP server on 0.0.0.0:8000 (accessible from network, no GUI)
  (no options)    Run with GUI and local server on 127.0.0.1:8000

Configuration:
  The program reads settings from 'systemc' file in the current directory.
  Configuration options: width, height, title, showMaximize, showMinimize

Examples:
  slkstore          # Start with GUI (default mode)
  slkstore --local  # Start local server without GUI
  slkstore --remote # Start remote server without GUI

For more information, visit: https://github.com/hellocodelinux/slkstore

the installation was completed in /opt/slkstore

EOF
