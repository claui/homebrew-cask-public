cask 'safe-t-bridge' do
  version '1.0.2'
  sha256 '166c64dba947198990cb06ec2951d45581225ec502f9de2bd818239226d6f088'

  # storage.googleapis.com was verified as official when first introduced to the cask
  url "https://storage.googleapis.com/safe-t-software/bridge/#{version}/safe-t-bridge-#{version}.pkg"
  appcast 'https://storage.googleapis.com/safe-t-software/bridge/latest_version.txt'
  name 'Safe-T Bridge'
  homepage 'https://app.safe-t.io/device'

  pkg "safe-t-bridge-#{version}.pkg"

  uninstall pkgutil:   'com.archos.pkg.SafeTBridge.uninstall',
            launchctl: 'com.archos.safeTBridge.safe-t-daemon',
            delete:    '/Applications/Utilities/Safe-T Bridge'

  zap trash: '~/Library/Logs/safe-t-daemon.log'
end
