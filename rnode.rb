class Rnode < Formula
  desc "Offical implementation of the RChain platform."
  homepage "developer.rchain.coop"
  version "0.8.1"
  url "https://github.com/rchain/rchain/releases/download/v#{version}/rnode-#{version}.tgz"
  sha256 "df67b49d5c977eb94fcc027a6e63f969e1c68a59952daa556dc861e59709dd19"

  JAVA_VERSION = "1.8"

  depends_on :java => JAVA_VERSION
  depends_on "libsodium"

  def install
    rm_f Dir["bin/*.bat"]
    libexec.mkpath
    libexec.install %w[bin lib]
    (bin/"rnode").write_env_script "#{libexec}/bin/rnode", "JAVA_HOME" => "$(#{Language::Java.java_home_cmd(JAVA_VERSION)})"
  end

  test do
    system shell_output("#{bin}/rnode --version").include?(version).to_s
  end
end
