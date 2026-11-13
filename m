Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544266;
	b=cWPIv73wKeykJepgjnB5FU0PRmGP45bg2Sy77bCJM4KyfRStKDgGdSH2754GmlO8bkUJ
	 QBwUM/jPRlXBxzLkiftlLwkaQLkUZGaHbTCRsgzFygTf+vYkLp6gEDU5dYEBAPpBatzbf
	 hMXfB+SjPFumoyqBacyjazJVFOwYcGtr11HzPWwAoiOStFUSt53iFuwFKDCrCx3kmdLoh
	 d8lfHbS/8/1b5JItugtdisGdAZRVQ4X0h2pj/jdJ0jy1IWXrSBqTrDJEchdvQ+wpSAT1e
	 ZgycqgLXTbB4a+Ckdfq5w/0JuVmKEVgnw0YpbA+PoyCovTsaZiuUOhHY1mqUw/j/NMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544266;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uB1zoemPWKsLwfgPExjc+T+F3A0+s/oOWYcRuOobBoU=;
	b=jZBcDaHJfuz9sOGXzgU4khFlbQVWacM+5Hw0X3B3lW6G2/ScZ39GZIXeDQ/YuWy9enS0
	 9KvKW9YGfsNaLf8uabs8O2F5SckN+OtfmPUKPRayOhi/S+0GnLV1o/MYiDb2MAGzPd26c
	 HswmN0elNo201bMgZdOp4eyQF8Bb5XrW8+T0Pu3g/Qdj93+aNnIp6ObXmVa7WA2tlHgc6
	 x47zGa5l/oLPfiKxP+RGqGAFg/QSSgiZBylrQSLz3T4XjrHRoNC4RfYUGUbWHPvuD7PVo
	 NQFz/mBhg8Hib9IBi6csYeoysv7boy0KnY6BADSQcaoUM4o+3nV9UeUf+QCXVwu0q7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeDnIsAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD4606A32E
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeDnIsAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958D1F000C4;
	Fri, 13 Nov 2026 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794544266;
	bh=uB1zoemPWKsLwfgPExjc+T+F3A0+s/oOWYcRuOobBoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SeDnIsAhKFq029Yt/GVOFd6FKJ2o4zl3d0PSB9XGPNArv/SZYYj+tXDtnti1jc71M
	 7tPQJ8h5wNYaKnHKUEonb+6H8D4isoqMT2ToAlyB14WSm/8bxE0gDuTq8TBMZOJuco
	 c6NZhnYAMXtfs8p+EpmTUgQHuPNrfsrTvSCKlQdk+GmYbcALmdfFOD5d8tONRH45Wy
	 cMX8h81klymVvdv292Cv8ldJUEMRukA5a/DlT0jFtqMU3PtClb0knT42C/AtfIry6j
	 QGoqsGSowBtFWqFKGjaGXHaDqOhAHL1+T0rQhxj1cGpy2HA7vul0HXhh8wvJUjXh/u
	 OA0yeTRUtEvAw==
Subject:
 Re: [PATCH v4 3/6] can: raw: use a private mutex instead of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Fri, 13 Nov 2026 04:31:05 +0000
Message-ID: <179454426541.488853.15379643605511531742@kernel.org>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comment this patch adds to struct raw_sock, 'struct mutex
  conf_lock; /* protects bind, filters and sockopts */'…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the bug class
  the series is fixing is still reachable through CAN J1939 at the end…

--

can: raw: use a private mutex instead of lock_sock()

This commit replaces lock_sock() in CAN_RAW with a private mutex,
conf_lock, in struct raw_sock. Generic SOL_SOCKET options copy from user
space under sockopt_lock_sock(), and with this change they can no longer
block raw_notify() while it runs under RTNL. The new mutex serializes
bind, release, the filters and the CAN_RAW socket options.

> diff --git a/net/can/raw.c b/net/can/raw.c
> index f14270b56f521..641661ef4399d 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -103,6 +103,7 @@ struct raw_sock {
>  	struct can_filter dfilter; /* default/single filter */
>  	struct can_filter *filter; /* pointer to filter(s) */
>  	struct uniqframe __percpu *uniq;
> +	struct mutex conf_lock; /* protects bind, filters and sockopts */

[Severity: Low]
This isn't a bug, but is this comment accurate for the sockopts?

raw_getsockopt() reads CAN_RAW_ERR_FILTER, CAN_RAW_LOOPBACK,
CAN_RAW_RECV_OWN_MSGS, CAN_RAW_FD_FRAMES, CAN_RAW_XL_FRAMES and
CAN_RAW_JOIN_FILTERS without taking conf_lock. The CAN_RAW_XL_VCID_OPTS
case also copies the struct directly, without the lock:

net/can/raw.c:raw_getsockopt() {
    ...
	case CAN_RAW_XL_VCID_OPTS: {
		...
			if (copy_to_iter(&ro->raw_vcid_opts, len,
					 &opt->iter_out) != len)
				err = -EFAULT;
    ...
}

Meanwhile the writer updates the same struct while holding the mutex:

net/can/raw.c:raw_setsockopt_locked() {
    ...
	case CAN_RAW_XL_VCID_OPTS:
		memcpy(&ro->raw_vcid_opts, val, sizeof(ro->raw_vcid_opts));
    ...
}

So a concurrent getsockopt(CAN_RAW_XL_VCID_OPTS) can return a mix of old
and new values. raw_sendmsg() also reads the binding and option fields
without the lock.

These readers had no lock under lock_sock() either, so runtime behaviour
does not change. Could the comment say instead that the mutex serializes
the writers and the bind/notifier state? Another option is to take a
snapshot of the VCID options under the lock, as the CAN_RAW_FILTER case
already does.

>  };
>  
>  static LIST_HEAD(raw_notifier_list);

[ ... ]

> @@ -328,9 +329,9 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>  
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
> -		lock_sock(sk);
> +		mutex_lock(&ro->conf_lock);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
the same RTNL stall still looks reachable through CAN J1939 after this
series.

Later patches in the series ("can: isotp: use a private mutex instead of
lock_sock()" and "can: bcm: use a private mutex instead of lock_sock()")
convert isotp_notify() and bcm_notify(). Nothing in the series touches
net/can/j1939.

On NETDEV_UNREGISTER, j1939_netdev_notify() calls
j1939_sk_netdev_event_unregister() while RTNL is held, and that function
still takes the socket lock:

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
		sock_hold(sk);
		read_unlock_bh(&priv->j1939_socks_lock);
		...
		lock_sock(sk);
		if (jsk->state & J1939_SOCK_BOUND) {
    ...
}

sk_setsockopt() in net/core/sock.c holds sockopt_lock_sock(sk) while it
copies from user space. Examples are copy_bpf_fprog_from_user() for
SO_ATTACH_FILTER, copy_from_sockptr() for SO_LINGER, and SO_TXTIME. This
works on any PF_CAN socket, and neither can_create() nor the J1939 proto
does a capability check.

A possible sequence, with a vcan device created in the caller's own
user and net namespace:

socket(PF_CAN, SOCK_DGRAM, CAN_J1939); bind() to vcan0

thread A: setsockopt(SOL_SOCKET, SO_ATTACH_FILTER), optval in a
          stalling FUSE mapping
  sk_setsockopt()
    sockopt_lock_sock(sk)
    copy_bpf_fprog_from_user()      <- stalls

thread B: ip link del vcan0
  unregister_netdevice()            (RTNL held)
    j1939_netdev_notify(NETDEV_UNREGISTER)
      j1939_sk_netdev_event_unregister()
        lock_sock(sk)               <- blocks indefinitely

Moving the device to another namespace hits the same lock_sock().

The series sets out to close this RTNL stall for the CAN protocols.
Should J1939 also be converted to a private lock, so that an unprivileged
user can't hold RTNL indefinitely through this path?

>  		if (ro->dev != dev) {
> -			release_sock(sk);
> +			mutex_unlock(&ro->conf_lock);
>  			break;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-can-bcmlock-memcg-v4-0-5428607a608f%40hartkopp.net
