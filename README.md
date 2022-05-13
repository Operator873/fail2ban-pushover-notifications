# fail2ban-pushover-notifications
A very simple method of implementing Pushover notifications via fail2ban

## Installation

1. Update `pushover.sh` with your Pushover tokens, else it won't work.
2. Add `pushover.log` and `pushover.sh` to your `/etc/fail2ban` folder. Ensure proper permissions are set for the script.
3. Add `pushover.conf` to `/etc/fail2ban/action.d/`
4. You must add the following to `/etc/fail2ban/jail.local`
```
action_ph = %(action_)s
            pushover[name="%(__name__)s", bantime="%(bantime)s"]
```

5. Then change your default action to the new action.    
`action = %(action_ph)s`

6. (optional) You can also override a jail action and keep the standard if you less push notifications.

```
[sshd]
action = %(action_)s
         pushover[name="%(__name__)s", bantime="%(bantime)s"]
```