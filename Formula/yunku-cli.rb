class YunkuCli < Formula
  desc "Yunku CLI"
  homepage "https://github.com/gokuai/yunku-cli"
  url "https://github.com/gokuai/yunku-cli/releases/download/v1.0.1/ykc-darwin-amd64.tar.gz"
  sha256 "053a581ced0263efac610bbb2a6517f9d7f54facdc26283ae99bb0d1ee213de4"
  license "Apache-2.0"


  resource "skills" do
    url "https://github.com/gokuai/yunku-cli/releases/download/v1.0.1/ykc-skills.zip"
    sha256 "7105dc160dbacb3210cd6e05044141313100a4e794cf2362f7bd5f7286c21454"
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
