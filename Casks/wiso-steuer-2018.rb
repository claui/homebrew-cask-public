cask 'wiso-steuer-2018' do
  version :latest
  sha256 :no_check

  url 'https://update1.buhl-data.com/ESD/Steuer/2018/WISOSteuerMac2018.dmg'
  name 'WISO Steuer:Mac 2018'
  homepage 'https://www.buhl.de/produkte/wiso-steuer-mac'

  pkg 'steuerMac 2018.pkg'

  uninstall pkgutil: 'com.BuhlData.WISOsteuerMac2018.pkg',
            quit:    'com.BuhlData.WISOsteuerMac2018'
end
