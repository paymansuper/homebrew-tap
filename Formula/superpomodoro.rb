# Source-build formula, also used as template by the release workflow
# (0.2.0 and c121f6cd8fd8cc14fa31f73001688ac0095b36b45c5a82468606b58dfcd8d71e get filled in automatically on every tag).
class Superpomodoro < Formula
  desc "Pretty Pomodoro timer for your terminal"
  homepage "https://github.com/paymansuper/terminal-superpomodoro"
  url "https://github.com/paymansuper/terminal-superpomodoro/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c121f6cd8fd8cc14fa31f73001688ac0095b36b45c5a82468606b58dfcd8d71e"
  license "MIT"
  head "https://github.com/paymansuper/terminal-superpomodoro.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/superpomodoro"
    bin.install_symlink "superpomodoro" => "spomo"
    # native floating mini window (needs the Xcode Command Line Tools, which Homebrew requires anyway)
    system "swiftc", "-O", "-o", bin/"superpomodoro-float", "macos/main.swift" if OS.mac?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/superpomodoro --version")
  end
end
