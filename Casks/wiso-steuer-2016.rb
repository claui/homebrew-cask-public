cask 'wiso-steuer-2016' do
  version :latest
  sha256 :no_check

  url 'https://update1.buhl-data.com/ESD/Steuer/2016/WISOSteuerMac2016.dmg'
  name 'WISO Steuer:Mac 2016'
  homepage 'https://www.buhl.de/produkte/wiso-steuer-mac'

  pkg 'steuerMac 2016.pkg'

  uninstall pkgutil: 'com.BuhlData.WISOsteuerMac2016.pkg',
            quit:    'com.BuhlData.WISOsteuerMac2016'
end
