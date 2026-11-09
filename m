Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190711;
	b=O+L+KidEjeWSgWBPP5x4tcbTTktew/jn+OVSC/VXWpqZepBR0ojI+s3SbHOPfGy0dKSL
	 uftffGwWGOXTZSzh+kd4gkFmetmAKtOz/Esi7/svXWiEfXms3ItkrW/S/2qo5nCfDKCDC
	 LaBmAPk1XTSgpx+Vy1LYDSbcmRqbFSCYsk9Ihiuvkwex5NzWQsK16XTgnwdX2ohKs08VM
	 e2g34bswyWQiS6LlHKIjg27R6hHgRC+KWRtPgOAcIba4FFJa5MikAvN4zPR2OM9anqAXJ
	 qTzhm1ixfbcMUiOVfEZSxFsuMHmxoOFMzDK86QYO6bZrLayq0rvgzpPh6EPbcxzwJRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190711;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1wD7sWQlcoJ4SeMDnHMtZXbb+DHHkoAGT90+ZMa42R0=;
	b=gAupFzsmk9hcuD0k1RvJ4vEpS1t7gWTF0iJo2lthmftxEjG985+r695Y1ysA3NreZMd4
	 w0OtIWQowjNgDah+BXb0Z5qzWA+lsOEGtZHtnRhGbBcZjbePaF0n7lkbCXO7ClfFdJCAI
	 nf6labr+ZCWxIv9kpg2qeUkPBUFbrTw2+qOcixJ4/jafy1MrAalT0KGpX06zopJBtfmmV
	 I+/WF/92jQWHNeXjf8MFnKTXvauZ27UagaLbNSFV73lUDaICnMpcC/C0wVQ7toIj05vPX
	 8xvdpGa7ImfSy5/x7ulwEQRYsMFqGIG7sF831N0B3uI2OeyRyHKH3itZZuu7uM4O2qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXu39kZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5E606A320
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXu39kZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4244A1F0089F;
	Mon,  9 Nov 2026 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190710;
	bh=1wD7sWQlcoJ4SeMDnHMtZXbb+DHHkoAGT90+ZMa42R0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iXu39kZ3T1LXkfa8tkK7+AhjcdUN9WsMfZhXKsqh9V4GBHhTt+0Ldd8SLVOkoU3tw
	 +OE+5PEELfKqeEgUy1O5sSG/2pfZTb7PksDkCjSYpHFKHF7HSyaOZYUVTGvxQnd1RM
	 Ch4yl+R8/mTDBFpMMwKeuW6GEXp7q7rvn+lZSsmvTgnFxk1bMOLbe6mVxIBUfew0bc
	 vOVE9Y1Tx5abt6+UoI9m8jpLp+pAelgqGULhILcaZsu6ouXjFG1sdot4byOVBd4K94
	 SylGSFY99EvLnk/t6KPPL2D6z+DAZINZryAAcuPHuX4Y9Z6k+p7/kJ/A2CIaozyhUR
	 zkdTZ24BxHewA==
Subject:
 Re: [PATCH 3/3] can: enable memcg accounting for user triggered allocations
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Mon, 09 Nov 2026 02:18:29 +0000
Message-ID: <179419070981.488853.12589743168030293362@kernel.org>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
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

- [Low] The patch says it accounts the j1939 objects that unprivileged
  users trigger and that live as long as the socket or a related object.
- [Low] The patch replaces memdup_sockptr() in raw_setsockopt()
  (CAN_RAW_FILTER) and j1939_sk_setsockopt() (SO_J1939_FILTER) with an…

--

can: enable memcg accounting for user triggered allocations

This commit adds memcg accounting to CAN allocations that unprivileged
users can trigger and that live for the lifetime of a socket or related
object. It covers socket structures, receivers, bcm_op frame arrays, raw
and j1939 filters, the isotp TX buffer and j1939_priv. memdup_sockptr()
is replaced with an explicit kmalloc() plus copy_from_sockptr() for the
filter copies.

Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index d9384cf0e356f..77adb817b36c8 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -128,7 +128,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
>  {
>  	struct j1939_priv *priv;
>  
> -	priv = kzalloc_obj(*priv);
> +	priv = kzalloc_obj(*priv, GFP_KERNEL_ACCOUNT);
>  	if (!priv)
>  		return NULL;
>  

[Severity: Low]
The commit message names j1939_priv as the j1939 object that bind()
creates. Is the local ECU, created on the same bind() path, meant to stay
unaccounted?

j1939_sk_bind()
  j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa)
    write_lock_bh(&priv->lock);
    j1939_ecu_create_locked(priv, name)
      ecu = kzalloc_obj(*ecu, gfp_any());

gfp_any() returns GFP_ATOMIC here because BH is disabled. The code is
still in task context, though, running on behalf of the process that
called bind(). So the softirq reasoning in the commit message ("can not
be attributed to a process") does not seem to apply to this call site.

The ECU holds a kref, a netdev_hold() tracker and an hrtimer. It stays
alive until the socket unbinds, rebinds or is released through
j1939_local_ecu_put().

Should this allocation get __GFP_ACCOUNT as well? If not, could the
commit message list it with the other deliberate exclusions?

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..c832465876049 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -716,9 +716,14 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
>  				return -EINVAL;
>  
>  			count = optlen / sizeof(*filters);
> -			filters = memdup_sockptr(optval, optlen);
> -			if (IS_ERR(filters))
> -				return PTR_ERR(filters);
> +			filters = kmalloc(optlen, GFP_KERNEL_ACCOUNT);

[Severity: Low]
memdup_sockptr() allocates with GFP_USER | __GFP_NOWARN:

include/linux/sockptr.h:memdup_sockptr_noprof() {
	void *p = kmalloc_track_caller_noprof(len, GFP_USER | __GFP_NOWARN);
	...
}

As well as adding __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT drops __GFP_HARDWALL
and __GFP_NOWARN. Was that intended?

Userspace controls optlen here, up to J1939_FILTER_MAX *
sizeof(struct j1939_filter), which is 16 KiB. That size becomes an
order-2 page allocation, so a failure can now print a warn_alloc()
splat.

The same change applies to the CAN_RAW_FILTER allocation in
raw_setsockopt(), where the size can reach 4 KiB.

Would GFP_USER | __GFP_ACCOUNT | __GFP_NOWARN keep the old behavior for
both call sites?

> +			if (!filters)
> +				return -ENOMEM;
> +
> +			if (copy_from_sockptr(filters, optval, optlen)) {
> +				kfree(filters);
> +				return -EFAULT;
> +			}
>  
>  			for (f = filters, c = count; c; f++, c--) {
>  				f->name &= f->name_mask;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd%40hartkopp.net
