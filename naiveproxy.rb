# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  url "https://github.com/klzgrad/naiveproxy/archive/refs/tags/v111.0.5563.64-1.tar.gz"
  sha256 "a5411d28943be60a273c58059e3ee81cb8e4623d8286f8e57bf5a34e4fa7e7ac"
  desc "Make a fortune quietly"
  homepage "https://github.com/klzgrad/naiveproxy"
  version "v111.0.5563.64-1"
  license ""


  depends_on "go" => :build

  def install
    system "go", "install", "github.com/caddyserver/xcaddy/cmd/xcaddy@latest"
    system "xcaddy", "build", "--with", "github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive"
  end

  # def install
  #   # ENV.deparallelize  # if your formula fails when building in parallel
  #   # Remove unrecognized options if warned by configure
  #   # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
  #   # system "./configure", *std_configure_args, "--disable-silent-rules"
  #   sbin.install "naive"
  #   # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  # end

  def caveats
    <<~EOS
    Create naiveproxy configure file on `$HOME/.naiveproxy/config.json`

    {
      "listen": "socks://127.0.0.1:1080",
      "proxy": "https://user:pass@example.com"
    }

    To start the service, run:
      brew services start naiveproxy
    EOS
  end

  service do
    run [opt_sbin/"naive", "$HOME/.naiveproxy/config.json"]
  end


  test do
    system "#{sbin}/naive", "--version"
  end
end
