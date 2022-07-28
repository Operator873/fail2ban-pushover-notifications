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

## After thoughts
It's worth saying that the Pushover priority levels probably should be changed to match what you want.

As is, thanks to overseas activity, there is a lot of fraudulent ssh attempts happening everywhere now. So the Pushover notification can become quite noisy at times. If such is the case, to avoid alert fatigue, I'd open `pushover.sh` and change [Line 17](https://github.com/Operator873/fail2ban-pushover-notifications/blob/da49fe787770c4ba08ca9cdda4efa9b89cc86c1d/pushover.sh#L17) to `PUSHOVER_PRIORITY=-1` and [Line 22](https://github.com/Operator873/fail2ban-pushover-notifications/blob/da49fe787770c4ba08ca9cdda4efa9b89cc86c1d/pushover.sh#L22) to `PUSHOVER_PRIORITY=-2` to lower the noise level.

In the future, I may try to add the ability to specify different priorities based on jail configuration.
