ssh
```
ssh-keygen -t ed25519 -C "tushyagupta81@gmail.com"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub
echo "add this public key in github account settings"
read
```
