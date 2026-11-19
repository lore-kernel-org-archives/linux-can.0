Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071562;
	b=nV/MbdmfmcM7QxAcGKhdJ/XEJPAO54qFRfnUyzvnpEkd0rUlYUsPAB8SsoJEPU0y0zYm
	 HISqvmnqkMQLhcHxgrxG75AJoN9obRWP0rtr3HKMTaCxdo4BKLAQ6t327RvFzCuAOyOhH
	 n5NPiTy7vLTjpdEEdUquzLanHo7pKkaTlG5DIeGUBa47BqIDw1ku90EGhF9BaoEFY9BLr
	 m1Q8s3ZGUmATs0kt9sllKquLHPY36j+LwFffmJn0zm+5HjEX/4aa07Sm1M8MTbvmBHEzf
	 A3SyKBX4ACU3EoJM7ACa+YRB5yXRRAcf1+Ocz1xYEJqLiVeSpBmjRem+HYhdye5iOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071562;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Pckw9P1gnkf426p77cYnZKHlzm3P4KPT/8KkXyeJx84=;
	b=iX+iLTtF+TppnjwXijUDMYBfjKY0B9YZSZ3E+D67WfExBR11tCkF7ZAh5ov8y7TChLhV
	 mE2VkcTV77FiyOR+Z26d+w2C4G/xo4xVV4Ld1OdunArWl+dnQ/+LSb2GThg9Q1PFD6dXO
	 oci8kIzkz5us+DMlOGsbOYO/zaBLCMEx+mUU8U8U051KEpwDczWcufmjgRCeyI+azbnF0
	 noJo6lvO5BTe3I4S3wU0VxzyDEgvzmA+qV/D6hd9HEMn6s9nzMtg7NjXgzfHPxjhUEOrn
	 AnmtggqFVFcnaBmmvmXiUh5UVcvwD60qMKXUqFPPUfZmDJvtf0qQb98nOPtuuVDlHgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgghTX3n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D57606A32C
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgghTX3n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C391F000CD;
	Thu, 19 Nov 2026 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071562;
	bh=Pckw9P1gnkf426p77cYnZKHlzm3P4KPT/8KkXyeJx84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HgghTX3n8/rHFYIPqJ7bUw65vufYjTIs+fqwTu9fYwKXE3vEH2gm4XpMQmbG6cmPJ
	 xMxpxGn8epeigfvn5SHPVw93kR2LFz0eyIAC/H30Bi2j7wWw3tbRKIs2L0YoKmnIsg
	 ySHfz8DZ7I7jOm/oB3IUnxhhjuFE6AL02OsKykp/Ek61lMUfnH7rPktrDlA7m9q9nm
	 fHE7SmkIwSe7htMJm3oCoK624wbZolRHoQUkYnE8iduTfO6CXjddepziFnePzGE64q
	 aKCb0tzTunB5WT5lca3UKS+SH9qcgMfAafOr/1UBRhc4QOFcaoDpuh8YWTwg9T9t/B
	 OnU+mK9MLF4mA==
Subject:
 Re: [PATCH v6 3/8] can: raw: use a private mutex instead of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Thu, 19 Nov 2026 06:59:21 +0000
Message-ID: <179507156133.3132.786917973363273055@kernel.org>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-3-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-3-6826a6227d36@hartkopp.net>
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

- [Low] The comment this patch adds to struct raw_sock, `struct mutex
  conf_lock; /* protects bind, filters and setsockopt */`, says more…

Pre-existing issues:
- [High] This patch did not introduce this problem, and it is outside
  what the patch claims to fix, but the same RTNL stall is still…
- [Low] This patch did not introduce this problem.

--

can: raw: use a private mutex instead of lock_sock()

This patch replaces lock_sock() in CAN_RAW with a new conf_lock mutex in
struct raw_sock. Generic SOL_SOCKET options that touch user space while
holding the socket lock can then no longer stall raw_notify() while it
holds RTNL. The mutex serializes bind, release, the notifier, the filters
and the CAN_RAW socket options.

> diff --git a/net/can/raw.c b/net/can/raw.c
> index f14270b56f521..b69eaadc5e93a 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -103,6 +103,7 @@ struct raw_sock {
>  	struct can_filter dfilter; /* default/single filter */
>  	struct can_filter *filter; /* pointer to filter(s) */
>  	struct uniqframe __percpu *uniq;
> +	struct mutex conf_lock; /* protects bind, filters and setsockopt */

[Severity: Low]
Does this comment promise more than the code provides?

Only the CAN_RAW_FILTER branch of raw_getsockopt() takes conf_lock. Other
read-backs of state owned by setsockopt still run without it:

net/can/raw.c:raw_getsockopt() {
    ...
	case CAN_RAW_ERR_FILTER:
		if (len > sizeof(can_err_mask_t))
			len = sizeof(can_err_mask_t);
		val = &ro->err_mask;
		break;
    ...
			if (copy_to_iter(&ro->raw_vcid_opts, len,
					 &opt->iter_out) != len)
    ...
}

The loopback, recv_own_msgs, fd_frames, xl_frames and join_filters bits
are in the same situation. raw_setsockopt_locked() writes all of them
under the mutex, but these readers don't take it.

The error mask is a filter too. Could the comment list the paths that
actually take the lock (bind, release, the notifier, setsockopt and the
CAN_RAW_FILTER read-back)?

The commit message says ro->raw_vcid_opts will be handled in a
follow-up, but no later patch in this series seems to make that change.

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
>  		if (ro->dev != dev) {
> -			release_sock(sk);
> +			mutex_unlock(&ro->conf_lock);
>  			break;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but can CAN_J1939 sockets
still trigger the same RTNL stall?

The series converts raw, isotp ("can: isotp: use a private mutex instead
of lock_sock()") and bcm ("can: bcm: use a private mutex instead of
lock_sock()"). j1939 still calls lock_sock() from its netdevice notifier
while RTNL is held:

j1939_netdev_notify()   /* NETDEV_UNREGISTER, RTNL held */
  j1939_sk_netdev_event_unregister()
    lock_sock(sk)

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
		sock_hold(sk);
		read_unlock_bh(&priv->j1939_socks_lock);
		...
		lock_sock(sk);
		if (jsk->state & J1939_SOCK_BOUND) {
    ...
}

sk_setsockopt() still reads user memory while it holds
sockopt_lock_sock(sk). Examples are copy_from_sockptr(&ling, ...) for
SO_LINGER and copy_bpf_fprog_from_user() for SO_ATTACH_FILTER.

can_create() has no capability check for CAN_J1939. With user namespaces
and unprivileged FUSE enabled, an unprivileged user could:

  1. create a CAN_J1939 socket and bind it to a vcan device in their own
     network namespace
  2. call setsockopt(SOL_SOCKET, SO_LINGER) with optval in a FUSE backed
     mapping whose daemon never answers, so sk_setsockopt() sleeps in
     copy_from_sockptr() while holding the socket lock
  3. delete the vcan device

j1939_sk_netdev_event_unregister() would then block in lock_sock() with
RTNL held for as long as the copy stays stalled.

Does j1939 need the same conversion as raw, isotp and bcm?

[ ... ]

> @@ -831,7 +834,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>  		struct can_filter *filter = NULL;
>  		int err = 0;
>  
> -		lock_sock(sk);
> +		mutex_lock(&ro->conf_lock);
>  		if (ro->count > 0) {
>  			int fsize = ro->count * sizeof(struct can_filter);
>  

[ ... ]

> @@ -851,7 +854,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>  		} else {
>  			len = 0;
>  		}
> -		release_sock(sk);
> +		mutex_unlock(&ro->conf_lock);
>  
>  		if (filter) {
>  			if (copy_to_iter(filter, len, &opt->iter_out) != len)

[Severity: Low]
This is a pre-existing issue, but can lockless readers of the VCID state
see a concurrent setsockopt(CAN_RAW_XL_VCID_OPTS) only partly applied?

The writer updates several fields under conf_lock:

net/can/raw.c:raw_setsockopt_locked() {
    ...
	case CAN_RAW_XL_VCID_OPTS:
		memcpy(&ro->raw_vcid_opts, val, sizeof(ro->raw_vcid_opts));

		/* prepare 32 bit values for handling in hot path */
		ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
		ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
		ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
    ...
}

raw_getsockopt(CAN_RAW_XL_VCID_OPTS) copies ro->raw_vcid_opts to user
space without the lock.

raw_rcv() reads ro->raw_vcid_opts.flags, rx_vcid_shifted and
rx_vcid_mask_shifted in softirq context. raw_put_canxl_vcid() reads the
flags and tx_vcid_shifted. Neither takes the lock.

Could a frame then be filtered or tagged with the new flags but the old
VCID values, or could getsockopt return a torn copy?

The commit message defers this to a follow-up, and no later patch in the
series appears to change it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-can-bcmlock-memcg-v6-0-6826a6227d36%40hartkopp.net
