cask 'macos-sdk-headers' do
  version '10.2.1.1.1.1554506761'
  sha256 'de751905853dc3765962abe8e9aa45a8c4080a414ba603cfd4dd32c45aae455c'

  url 'file:///Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg'
  name 'macOS SDK headers for macOS 10.14'

  depends_on macos: :mojave

  pkg 'macOS_SDK_headers_for_macOS_10.14.pkg'
end
