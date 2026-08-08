# Handled by Slackware's package manager
# We just ensure the user knows to run the setup tool.

if [ ! -f boot/efi/EFI/elilong/elilong.efi ]; then
    echo ""
    echo "NOTICE: To finish the installation of elilong,"
    echo "        please run 'elilongsetup' as root."
    echo ""
fi
