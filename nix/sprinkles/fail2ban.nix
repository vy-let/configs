{ ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 5;

    jails.sshd = ''
      enabled = true
      filter = sshd
      action = iptables[name=ssh, port=ssh, protocol=tcp]
    '';
  };
}
