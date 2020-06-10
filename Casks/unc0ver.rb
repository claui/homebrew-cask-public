cask 'unc0ver' do
  version '5.0.1'
  sha256 'dd04a3e28a1eb81a6f3c586f1236feb0377f76e331e94554ea1a89330fa4b06b'

  # github.com was verified as official when first introduced to the cask
  url "https://github.com/pwn20wndstuff/Undecimus/releases/download/v#{version}/unc0ver-v#{version}.ipa"
  appcast 'https://github.com/pwn20wndstuff/Undecimus/releases.atom'
  name 'unc0ver'
  homepage 'https://unc0ver.dev/'

  stage_only true

  preflight do
    signing_identity = ENV.fetch('HOMEBREW_SIGNING_IDENTITY') do |key|
      raise "Set the #{key} environment variable to a valid signing identity name."
    end
    app_id = ENV.fetch('HOMEBREW_APP_ID') do |key|
      raise "Set the #{key} environment variable to the full app ID including the prefix."
    end
    upp_path = ENV.fetch('HOMEBREW_UPP_PATH') do |key|
      raise "Set the #{key} environment variable so it points to a valid provisioning profile."
    end

    FileUtils.mv(staged_path.join('Payload').children, staged_path)
    FileUtils.rm_r(staged_path / 'Payload')

    system_command '/usr/bin/plutil',
                   args:         [
                                   '-convert', 'xml1',
                                   '-o', staged_path / 'Entitlements.plist',
                                   '-'
                                 ],
                   input:        { "application-identifier": app_id }.to_json,
                   must_succeed: true

    system_command '/usr/bin/codesign',
                   args:         [
                                   '-f', '-s', signing_identity,
                                   '--entitlements', staged_path / 'Entitlements.plist',
                                   staged_path / 'unc0ver.app'
                                 ],
                   must_succeed: true

    FileUtils.cp(upp_path, "#{staged_path}/unc0ver.app/embedded.mobileprovision")
    FileUtils.rm(staged_path / 'Entitlements.plist')
  end

  caveats <<~EOS
    To install unc0ver, first open Xcode and go to Window » Devices
    and Simulators.
    Then open #{staged_path}/unc0ver.app in Finder and drag the app to
    the target device.
  EOS
end
