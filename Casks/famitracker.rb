cask 'famitracker' do
  version '0.4.6'
  sha256 'edc24ce14a1fc402ddb87cacdca497ea25bb648286b879edfc93a4e9d57ad5dc'

  url "http://www.famitracker.com/files/FamiTracker-v#{version}.zip"
  name 'FamiTracker'
  homepage 'http://www.famitracker.com/'

  depends_on formula: 'icoutils'
  depends_on formula: 'wine'

  app 'FamiTracker.app'

  preflight do
    base_name = @cask.name.first
    app_bundle = staged_path / "#{base_name}.app"
    libexec = @cask.sourcefile_path.parent.parent / 'libexec'

    FileUtils.mkdir_p app_bundle / 'Contents' / 'MacOS'
    FileUtils.mkdir_p app_bundle / 'Contents' / 'Resources'
    FileUtils.mkdir_p staged_path / 'FamiTracker.iconset'

    system_command '/bin/cp',
                   args: [
                           '--',
                           libexec / "launch_#{@cask.token}.bash",
                           app_bundle / 'Contents' / 'MacOS' / base_name,
                         ]

    system_command Formula['icoutils'].opt_bin / 'wrestool',
                   args: [
                           '-x', '-n', '128', '-t', 'group_icon',
                           '-o', staged_path / 'icon_128x128.ico',
                           '--', staged_path / 'FamiTracker.exe'
                         ],
                   must_succeed: true

    system_command Formula['icoutils'].opt_bin / 'icotool',
                   args: [
                           '-x', '--icon', '-w', '128',
                           '-o', staged_path / 'FamiTracker.iconset' / 'icon_128x128.png',
                           '--', staged_path / 'icon_128x128.ico'
                         ],
                   must_succeed: true,
                   print_stderr: false

    system_command '/usr/bin/iconutil',
                   args: [
                           '-c', 'icns',
                           '--', staged_path / 'FamiTracker.iconset'
                         ],
                   must_succeed: true,
                   print_stderr: false

    system_command '/bin/mv',
                   args: [
                           '-v', '--',
                           staged_path / 'FamiTracker.chm',
                           staged_path / 'FamiTracker.icns',
                           staged_path / 'FamiTracker.exe',
                           staged_path / 'readme.txt',
                           staged_path / 'Demo songs',
                           app_bundle / 'Contents' / 'Resources'
                         ]

    FileUtils.chmod '+x', app_bundle / 'Contents' / 'MacOS' / base_name

    IO.write app_bundle / 'Contents' / 'Resources' / 'patch_buffer_length.reg', <<~EOS
      Windows Registry Editor Version 5.00

      [HKEY_CURRENT_USER\\Software\\FamiTracker\\Sound]
      "Buffer length"=dword:0000003c
    EOS

    IO.write app_bundle / 'Contents' / 'Info.plist', <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>CFBundleIdentifier</key>
          <string>cat.claudi.homebrew.famitracker</string>
          <key>CFBundleName</key>
          <string>#{base_name}</string>
          <key>CFBundleDisplayName</key>
          <string>#{base_name}</string>
          <key>CFBundleExecutable</key>
          <string>#{base_name}</string>
          <key>CFBundleIconFile</key>
          <string>#{base_name}</string>
          <key>CFBundleVersion</key>
          <string>#{@cask.version}</string>
          <key>CFBundleShortVersionString</key>
          <string>#{@cask.version}</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>CFBundleSignature</key>
          <string>ftrk</string>
          <key>NSHumanReadableCopyright</key>
          <string>jsr</string>
        </dict>
      </plist>
    EOS

    FileUtils.touch app_bundle
  end

  uninstall signal: [
                      ['TERM', 'cat.claudi.homebrew.famitracker'],
                      ['KILL', 'cat.claudi.homebrew.famitracker'],
                    ],
            trash:  '~/Library/Application Support/FamiTracker/wine'
end
