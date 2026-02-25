class StepperviewMcp < Formula
  desc "MCP server for generating production-ready SwiftUI StepperView code via Claude Desktop, Cursor, and VS Code"
  homepage "https://github.com/badrinathvm/StepperView"
  url "https://github.com/badrinathvm/StepperView/archive/refs/tags/2.0.1.tar.gz"
  version "2.0.1"
  sha256 "FILL_IN_AFTER_TAGGING"

  depends_on "swift"
  depends_on :macos

  def install
    cd "StepperViewMCP" do
      system "swift", "build", "--configuration", "release", "--disable-sandbox"
      bin.install ".build/release/StepperViewMCP"
    end
  end

  test do
    input = %({"jsonrpc":"2.0","method":"initialize","id":1,"params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"brew-test","version":"1.0"}}}\n)
    output = pipe_output("#{bin}/StepperViewMCP", input)
    assert_match "StepperView MCP", output
  end
end
