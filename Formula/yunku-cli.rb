class YunkuCli < Formula
  desc "Yunku CLI"
  homepage "https://github.com/gokuai/yunku-cli"
  url "https://github.com/gokuai/yunku-cli/releases/download/v1.0.1/ykc-darwin-amd64.tar.gz"
  sha256 "92f6ebac5480be4a4dafbc5ecd37da38e33c66b90b3e00d5abbd78d4ad3a735c"
  license "Apache-2.0"


  resource "skills" do
    url "https://github.com/gokuai/yunku-cli/releases/download/v1.0.1/ykc-skills.zip"
    sha256 "05828698611ba9fd9194939e62ce52e93981497b0493c0c1cec3c191f701f6f3"
  end

  def install
    require "fileutils"

    root = Dir["ykc-*"].find { |entry| File.directory?(entry) } || "."
    binary = File.join(root, "ykc")
    raise "binary not found: #{binary}" unless File.exist?(binary)

    bin.install binary => "ykc"

    %w[LICENSE NOTICE README.md CHANGELOG.md].each do |name|
      source = File.join(root, name)
      pkgshare.install source if File.exist?(source)
    end

    skill_dest = pkgshare/"skills/ykc"
    skill_dest.mkpath
    resource("skills").stage do
      FileUtils.cp_r(Dir["*"], skill_dest)
    end
  end

  def post_install
    require "fileutils"

    skill_root = pkgshare/"skills/ykc"
    entries = Dir["#{skill_root}/*"]
    return if entries.empty?

    targets = [
      Pathname.new(File.join(Dir.home, ".agents/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".claude/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".cursor/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".gemini/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".codex/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".github/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".windsurf/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".augment/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".cline/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".amp/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".kiro/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".trae/skills/ykc")),
      Pathname.new(File.join(Dir.home, ".openclaw/skills/ykc")),
    ]

    targets.each_with_index do |dest, index|
      parent_gate = dest.parent.parent
      next if index > 0 && !parent_gate.directory?

      FileUtils.rm_rf(dest)
      FileUtils.mkdir_p(dest)
      FileUtils.cp_r(entries, dest)
    end
  end

  test do
    assert_match "ykc", shell_output("#{bin}/ykc --help")
  end
end
