cask 'wiso-steuer-2019' do
  version :latest
  sha256 :no_check

  url 'https://update1.buhl-data.com/ESD/Steuer/2019/WISOSteuerMac2019.dmg'
  name 'WISO Steuer:Mac 2019'
  homepage 'https://www.buhl.de/produkte/wiso-steuer-mac'

  pkg 'steuerMac 2019.pkg'

  uninstall pkgutil: 'com.BuhlData.WISOsteuerMac2019.pkg',
            quit:    'com.BuhlData.WISOsteuerMac2019'
end
