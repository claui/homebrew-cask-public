cask 'xmlmind' do
  version '9.2.0'
  sha256 'c4734b6a636f53591096f8072cb700e534a6f9ef9f545eab0a3163f23bd673c4'

  url "https://www.xmlmind.com/xmleditor/_download/xxe-perso-#{version.dots_to_underscores}.dmg"
  appcast 'https://www.xmlmind.com/xmleditor/download.shtml'
  name 'XMLmind XML Editor'
  homepage 'https://www.xmlmind.com/'

  app 'XMLmind.app'

  uninstall quit: "com.xmlmind.xmleditapp.app.DesktopApp.xxe-perso-#{version.dots_to_hyphens}"

  zap trash: '~/Library/Application Support/XMLmind/XMLEditor9'

  caveats do
    depends_on_java '8+'
  end
end
