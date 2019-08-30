# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Fpart < Formula
  desc "Sort files and pack them into partitions"
  homepage "https://github.com/martymac/fpart"
  url "https://github.com/martymac/fpart/archive/fpart-1.1.0.tar.gz"
  sha256 "c29d29f7cf83d91c0b93b85050b2172ee1026540e180a53f2d6b390c4d036d1d"
  version "1.1.0"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system touch "${HOME}/.fpart-test"
    assert_empty `fpart -n 1 -y ".fpart-test" "${HOME}" 2>/dev/null | grep -q "0 (0): ${HOME}/.fpart-test"`.strip
  end
end
