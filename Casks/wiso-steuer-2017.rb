cask 'wiso-steuer-2017' do
  version :latest
  sha256 :no_check

  url 'https://update1.buhl-data.com/ESD/Steuer/2017/WISOSteuerMac2017.dmg'
  name 'WISO Steuer:Mac 2017'
  homepage 'https://www.buhl.de/produkte/wiso-steuer-mac'

  pkg 'steuerMac 2017.pkg'

  uninstall pkgutil: 'com.BuhlData.WISOsteuerMac2017.pkg',
            quit:    'com.BuhlData.WISOsteuerMac2017'
end
