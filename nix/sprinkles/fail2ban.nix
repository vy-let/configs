{ ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 5;

    # This appears to be getting automatically defined now?
    #
    # jails.sshd = ''
    #   enabled = true
    #   filter = sshd
    #   action = iptables[name=ssh, port=ssh, protocol=tcp]
    # '';
  };
}
