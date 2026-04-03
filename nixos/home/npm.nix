{ ... }:
{
  home.file.".npmrc".text = ''
    registry=https://evolv.jfrog.io/artifactory/api/npm/evolv-npm-dev/
    //evolv.jfrog.io/artifactory/api/npm/evolv-npm-dev/:_authToken=''${JFROG_NPM_TOKEN}
    always-auth=true
  '';
}
