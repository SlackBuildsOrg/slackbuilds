#!/bin/sh

PWD="$CWD"
OUTDIR=${OUTDIR:-/tmp}

outfile="$OUTDIR/sccache-0.15.0-vendor.tar.xz"

cargo vendor-filterer --platform "*-unknown-linux-gnu"

# Prepare .cargo/config.toml override for local vendored sources
if [ ! -d .cargo ]
then
	mkdir .cargo
fi
cat >> .cargo/config.toml << IEOF
[source.crates-io]
replace-with = "vendored-sources"

[source.vendored-sources]
directory = "vendor"
IEOF
echo "compressing files to $outfile"
tar cJf "$outfile" vendor .cargo/config.toml

echo "vendor archive output in $outfile"
