# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "Make a fortune quietly"
  homepage "https://github.com/klzgrad/naiveproxy"
  url "https://github.com/klzgrad/naiveproxy/releases/download/v130.0.6723.40-5/naiveproxy-v130.0.6723.40-5-mac-arm64.tar.xz"
  version "v130.0.6723.40-5"
  sha256 "f5b2c010d13d97d57a7b2b222eab32d38cd6dad9dd6519bc9d1844e79119ba90"
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
    Create naiveproxy configure file on `#{ENV['HOME']}/.naiveproxy/config.json`
    {
      "listen": "socks://127.0.0.1:1080",
      "proxy": "https://user:pass@example.com"
    }
    To start the service, run:
      brew services start naiveproxy
    EOS
  end

  service do
    run [opt_sbin/"naive", "#{ENV['HOME']}/.naiveproxy/config.json"]
  end


  test do
    system "#{sbin}/naive", "--version"
  end
end
