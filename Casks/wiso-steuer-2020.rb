cask 'wiso-steuer-2020' do
  version :latest
  sha256 :no_check

  url 'https://update1.buhl-data.com/ESD/Steuer/2020/WISOSteuerMac2020.dmg'
  name 'WISO Steuer:Mac 2020'
  homepage 'https://www.buhl.de/produkte/wiso-steuer-mac'

  app 'steuerMac 2020.app'

  uninstall quit: 'com.BuhlData.WISOsteuerMac2020'
end
