cask 'macos-sdk-headers' do
  version :latest
  sha256 :no_check

  url 'file:///Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg'
  name 'macOS SDK headers for macOS 10.14'

  depends_on macos: :mojave

  pkg 'macOS_SDK_headers_for_macOS_10.14.pkg'
end
