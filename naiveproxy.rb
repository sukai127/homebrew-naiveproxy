# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "Make a fortune quietly"
  homepage "https://github.com/klzgrad/naiveproxy"
  url "https://github.com/klzgrad/naiveproxy/releases/download/v125.0.6422.35-1/naiveproxy-v125.0.6422.35-1-mac-x64.tar.xz"
  version "v125.0.6422.35-1"
  sha256 "6dc3acc9ba4c9d3fe40de51105b8111d2cd9dc72788c32c27fc2e9c0a0f2f26c"
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
