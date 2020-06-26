cask 'patch-installer' do
  version '0.1.3'
  sha256 "7e33a97b5c30726b006148bcb5faebe7a207bfa75c4e47e0190c632c77e5df0e"

  url "https://parrotgeek.com/bigsur/tool#{version}.zip"
  name 'Big Sur installer patch tool'
  homepage "https://parrotgeek.com/bigsur/"

  binary "tool/patch_installer.sh"
end
