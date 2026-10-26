# Source-build formula, also used as template by the release workflow
# (0.1.0 and df9828b8a18ffa72d3646ef743cac6fca5bb77e08de8b154ef6c40b78ae0c9fc get filled in automatically on every tag).
class Superpomodoro < Formula
  desc "Pretty Pomodoro timer for your terminal"
  homepage "https://github.com/paymansuper/terminal-superpomodoro"
  url "https://github.com/paymansuper/terminal-superpomodoro/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "df9828b8a18ffa72d3646ef743cac6fca5bb77e08de8b154ef6c40b78ae0c9fc"
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
