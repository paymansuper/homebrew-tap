# Source-build formula, also used as template by the release workflow
# (0.3.1 and 9b204cd8c4385cc975180ec931a156f56d7ed574388cb094f12f9831ac52a32c get filled in automatically on every tag).
class Superpomodoro < Formula
  desc "Pretty Pomodoro timer for your terminal"
  homepage "https://github.com/paymansuper/terminal-superpomodoro"
  url "https://github.com/paymansuper/terminal-superpomodoro/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "9b204cd8c4385cc975180ec931a156f56d7ed574388cb094f12f9831ac52a32c"
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
