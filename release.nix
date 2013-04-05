/* Build instructions for the continuous integration system Hydra. */

{ autoconfArchiveSrc ? { outPath = ./.; revCount = 0; gitTag = "dirty"; }
, officialRelease ? false
}:

let
  pkgs = import <nixpkgs> { };
  version = autoconfArchiveSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "autoconf-archive-tarball";
    src = autoconfArchiveSrc;
    inherit version versionSuffix officialRelease;
    dontBuild = false;
    buildInputs = with pkgs; [
      git perl texinfo5 python lzip htmlTidy
      (texLiveAggregationFun { paths = [ texLive texLiveCMSuper texinfo5 ]; })
    ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    buildPhase = ''
      make -j$NIX_BUILD_CORES maintainer-all all
      make web-manual && bash fix-website.sh
    '';
    distPhase = ''
      make distcheck
      mkdir $out/tarballs
      mv -v autoconf-archive-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "autoconf-archive";
      src = tarball;
    });

}
