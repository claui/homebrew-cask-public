cask 'patch-installer' do
  version '0.1.3'
  sha256 "7e33a97b5c30726b006148bcb5faebe7a207bfa75c4e47e0190c632c77e5df0e"

  url "https://parrotgeek.com/bigsur/tool#{version}.zip"
  name 'Big Sur installer patch tool'
  homepage "https://parrotgeek.com/bigsur/"

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/tool/patch_installer.wrapper.sh"
  binary shimscript, target: 'patch_installer.sh'

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/bash
      if [ "$1" ]; then
        DISKPATH="$(pwd)/$1"
      fi
      cd '#{staged_path}/tool'
      exec './patch_installer.sh' "${DISKPATH:-}"
    EOS
  end
end
