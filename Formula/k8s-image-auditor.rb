class K8sImageAuditor < Formula
  desc "Audits container images for architecture compatibility (amd64/arm64)"
  homepage "https://github.com/PraveenPrabhuT/k8s-image-auditor"
  url "https://github.com/PraveenPrabhuT/k8s-image-auditor/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "3c12f49faa12d40512185a701cf6838bafadcb5d714f341dd48a716378c79646"
  license "MIT"

  # Dependencies required at runtime
  depends_on "jq"
  depends_on "kubernetes-cli"
  depends_on "skopeo"
  depends_on "awscli"
  depends_on "bash"
  
  # Dependencies required only for building (man pages)
  depends_on "pandoc" => :build

  def install
    # Homebrew downloads the tarball and unzips it.
    # We invoke your Makefile, overriding PREFIX to install into Homebrew's sandbox (Cellar)
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # Simple integration test to verify the binary executes and prints help
    assert_match "Usage:", shell_output("#{bin}/k8s-image-auditor -h")
  end
end
