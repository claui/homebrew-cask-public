cask 'rambox-pro' do
  version '1.1.6'
  sha256 '3551e2426cfe68bc202f7a7ca14c14596456e2c96f40139886f0157a45de865c'

  # github.com/ramboxapp/download was verified as official when first introduced to the cask
  url "https://github.com/ramboxapp/download/releases/download/v#{version}/RamboxPro-#{version}-mac.zip"
  appcast 'https://github.com/ramboxapp/download/releases.atom'
  name 'Rambox Pro'
  homepage 'https://rambox.pro/'

  app 'RamboxPro.app'

  uninstall login_item: 'RamboxPro'

  zap trash: [
               '~/Library/Application Support/CrashReporter/RamboxPro Helper_*.plist',
               '~/Library/Application Support/CrashReporter/RamboxPro_*.plist',
               '~/Library/Application Support/RamboxPro',
               '~/Library/Caches/com.grupovrs.ramboxpro',
               '~/Library/Caches/com.grupovrs.ramboxpro.ShipIt',
               '~/Library/Logs/RamboxPro',
               '~/Library/Preferences/ByHost/com.grupovrs.ramboxpro.ShipIt.*.plist',
               '~/Library/Preferences/com.grupovrs.ramboxpro.helper.plist',
               '~/Library/Preferences/com.grupovrs.ramboxpro.plist',
               '~/Library/Saved Application State/com.grupovrs.ramboxpro.savedState',
             ]
end
