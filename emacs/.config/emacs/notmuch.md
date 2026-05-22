# Notmuch installation and configuration guide


## Install necessary packages


```bash
brew install notmuch
brew install msmtp
# this was the only way I could get it to install
pip3 install lieer --break-system-packages
```

## Configure

I have multiple gmail accounts for work, personal, and church.  To
handle this, I have three folders under the top level `~/mail`
directory: `~/mail/personal` `~/mail/work` `~/mail/church`.

```treedir
mail
├── work
├── personal
└── church
```

### Notmuch

```bash
notmuch setup # answer the necessary prompts
```

### Lieer

Do this for each directory under `~/mail`.

This should open a browser oauth flow to authorize lieer to read your
mail.

```bash
cd ~/mail/personal
gmi init jonharder6@gmail.com
# repeat for other directories
```

### Index

```bash
notmuch new
```
