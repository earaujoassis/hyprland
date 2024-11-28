# References

Important references for setting up the Arch Linux environment and
hardening its security.

- Authentication of user sessions using U2F/FIDO2:
Yubico's [*pam-u2f*](https://developers.yubico.com/pam-u2f/) and
Arch Linux's [U2F documentation](https://wiki.archlinux.org/title/Universal_2nd_Factor#Authentication_for_user_sessions).

- Use package [yubikey-full-disk-encryption](https://archlinux.org/packages/extra/any/yubikey-full-disk-encryption/) to enroll Yubikey as decryption
key for LUKS volume. Documentation and full process available at: 
[github.com/agherzan/yubikey-full-disk-encryption](https://github.com/agherzan/yubikey-full-disk-encryption)
