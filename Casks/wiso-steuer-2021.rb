cask "wiso-steuer-2021" do
  version :latest
  sha256 :no_check

  url "https://update1.buhl-data.com/ESD/Steuer/2021/WISOSteuerMac2021.dmg",
      verified: "update1.buhl-data.com/"
  name "WISO Steuer:Mac 2021"
  desc "File your German tax return for the tax year 2020"
  homepage "https://www.buhl.de/produkte/wiso-steuer-mac"

  app "steuerMac 2021.app"

  uninstall quit: "com.BuhlData.WISOsteuerMac2021"
end
