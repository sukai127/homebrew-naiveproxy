# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Naiveproxy < Formula
  desc "Make a fortune quietly"
  homepage "https://github.com/klzgrad/naiveproxy"
  url "https://github.com/klzgrad/naiveproxy/releases/download/v131.0.6778.86-1/naiveproxy-v131.0.6778.86-1-mac-arm64.tar.xz"
  version "v131.0.6778.86-1"
  sha256 "831b47e56debb2718f93b27876f0d6b06741b3d98cfe001cfc58d5e9dc638390"
  license "BSD-3-Clause"

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
    restart :on_failure
    log_path "#{ENV['HOMEBREW_PREFIX']}/var/log/naive.log"
    error_log_path "#{ENV['HOMEBREW_PREFIX']}/var/log/naive_error.log"
  end


  test do
    system "#{sbin}/naive", "--version"
  end
end
