git remote add github git@github.com:fifman/Data.git：添加远程仓库关联
git push -u github master：推送文件到远程仓库 -u不必要
git add -A：全部添加
git commit -m '提交注释'：提交
git pull github master：拉取文件到本地

# git-svn:

## fix `Can't locate SVN/Core.pm` problem

```bash
sudo mkdir /Library/Perl/5.18/auto
sudo ln -s /Applications/Xcode.app/Contents/Developer/Library/Perl/5.18/darwin-thread-multi-2level/SVN /Library/Perl/5.18/darwin-thread-multi-2level
sudo ln -s /Applications/Xcode.app/Contents/Developer/Library/Perl/5.18/darwin-thread-multi-2level/auto/SVN /Library/Perl/5.18/auto/
```

```bash
git config http.sslCAInfo /etc/ssl/certs/traefik.crt

GIT_SSL_CAINFO=/etc/ssl/certs/traefik.crt git clone https://gogs.msplat.io/fifman/goutils.git
```
