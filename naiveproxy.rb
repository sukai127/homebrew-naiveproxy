# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "Make a fortune quietly"
  homepage "https://github.com/klzgrad/naiveproxy"
  url "https://github.com/klzgrad/naiveproxy/releases/download/v111.0.5563.64-1/naiveproxy-v111.0.5563.64-1-mac-x64.tar.xz"
  sha256 "5aee1313980682c90449ed98fb4e3f900b8408eafa765b347bf55ae009c9e2b1"
  license ""

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    sbin.install "naive"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

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
    system "#{bin}/naive", "--version"
  end
end
