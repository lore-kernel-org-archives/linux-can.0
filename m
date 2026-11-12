Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473457;
	b=NYPikPHcXKyEpshlt0BnS5mX6Rqa2p05LCZWY2rlfh7+SzdLZGannf7FsmBgjjSPJk8u
	 B2RU8ni1EQBNqY+7rWewDUMLsGHIioHo3K5Oe2hiv4SQ2MUKzAxgO4Qqhd8NKw2BFdWSv
	 /zfKCUspQ24CK0duzeVNr1gFE6aXQJyIQR0cEyIcFIc6rrhmmnGAiKOmBECmvpJrcUGL6
	 rdebL2plL0d4hiLI9PfLsM2Bt1Nu0JTc7oHnEXczpq5zNpryK0ghH+1nczIvqq66ATK6Y
	 zQ/+DMDdRsB9qoDGqUY481W+7AIDAVCIQ3GkqiSML6C/gvPiQhVOs0XwOc06i4ocLdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473457;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AEc/6gv1TlVByn9fvOKs5q5zvkFxKI+Tck+UXJ8LRp0=;
	b=G2buNBmNtkGWiLcDfGRIB1NBhsR1ey01IPruMo96qzGb68k/Vckg6eRuPnti8nRDI8zN
	 HwOxYKv39ZDxT4v0A6h6GYZfyPWUu21xjm2007Dktz00rjNiQkIhWKaRZj/VHcUXGv+FQ
	 g/xZ5tI6lVa6xHz+ARAyqLgxO5oP0lrjWbEPO1KGbEAv57LY6Y/G1aQRLDa7sa4rrOi1g
	 eTM+MbCsL8pT9pDf0WT2LiWMjCf4/oLQtQOu4bwR3y68DuCf/Iki1pjJeLItb5EQFhaXb
	 SldUhDshG3s1uIblRA1PBDDKkQp2GAtRijX9PnDbUPHHZQHxW3eaYKoruqgISw4Yhwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9UP0CTO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F5606A323
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9UP0CTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706DD1F00A05;
	Thu, 12 Nov 2026 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473456;
	bh=AEc/6gv1TlVByn9fvOKs5q5zvkFxKI+Tck+UXJ8LRp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L9UP0CTOxkuTnN3z44mQu3lgDN2qmD9jw3k69Xkq9QblExt0SeW4zPKOeCUhfevqC
	 vK6gtP48oCuqZhCpG4FGSwTIEfGlzo2MJGnf1ZtGQXZl27aXa8HtkX2frrU1KHO2v2
	 n4wnj4rdAQokAP/ICWLKHVSBt7DaO9ZVPImM2Lsn94YcQqu2wINyGCmPD4re15He/B
	 XEf8s2XZgokzcxfMiKXvvlysBGq+ZI4AVlzad0XJ4Ej1v6LXeMKoW3AxcFweSB92rj
	 nhRdjbKpUjWYnKaBXFooBC2bX1Xkg0+Iz0SVwZ+3KbdOyNT/7WALzAM8KX7GAfcjAu
	 6sLFpTCb+IfHw==
Subject: Re: [PATCH v11 3/3] can: j1939: fix "struct j1939_ecu" refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Thu, 12 Nov 2026 08:50:55 +0000
Message-ID: <179447345596.488853.5149629105846560226@kernel.org>
In-Reply-To: <49c2c9ce-01ec-480d-8f57-f1b6211121e7@I-love.SAKURA.ne.jp>
References: <49c2c9ce-01ec-480d-8f57-f1b6211121e7@I-love.SAKURA.ne.jp>
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

- [Low] The commit message does not mention the net/can/j1939/socket.c
  hunk at all.
- [Low] In j1939_ecu_unmap_all() (net/can/j1939/bus.c), the comment on
  the second j1939_ecu_put() reads "Drop the ref from default: above."…

--

can: j1939: fix "struct j1939_ecu" refcount leak

This patch fixes a j1939_ecu refcount leak. The leak happens when
j1939_ecu_timer_handler() remaps an ECU after j1939_ecu_unmap_all() has
already unmapped it. The patch cancels ecu->ac_timer in
j1939_ecu_unmap_all() and adds j1939_ecu_verify_get(), which stops
j1939_ecu_timer_start() and j1939_ecu_map_locked() from taking new refs
once the netdev is unregistered or priv->rx_kref has reached zero.

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> We might want to add "(READ_ONCE(priv->ndev->flags) & IFF_UP) &&" to
> j1939_ecu_verify_get() for (2) and (3) if we want j1939_ecu_unmap_all()
>  from j1939_netdev_notify(NETDEV_DOWN) path to behave like
> j1939_ecu_unmap_all() from j1939_netdev_notify(NETDEV_UNREGISTER) path,
> but that should be a different patch. This patch focuses on fixing
> j1939_ecu_unmap_all() from j1939_netdev_notify(NETDEV_UNREGISTER) path
> which is reported as
> "unregister_netdevice: waiting for vcan0 to become free. Usage count = 3"
> problem by syzbot.

[Severity: Low]
Is this description of the call path accurate? In j1939_netdev_notify(),
only the NETDEV_DOWN case calls j1939_ecu_unmap_all() directly:

net/can/j1939/main.c:j1939_netdev_notify() {
    ...
	case NETDEV_DOWN:
		j1939_cancel_active_session(priv, NULL);
		j1939_sk_netdev_event_netdown(priv);
		j1939_ecu_unmap_all(priv);
		break;
	case NETDEV_UNREGISTER:
		j1939_cancel_active_session(priv, NULL);
		j1939_sk_netdev_event_netdown(priv);
		j1939_sk_netdev_event_unregister(priv);
		break;
    ...
}

The NETDEV_UNREGISTER path reaches j1939_ecu_unmap_all() only indirectly,
and only when the last rx_kref is dropped:

j1939_sk_netdev_event_unregister()
  j1939_netdev_stop()
    kref_put_mutex(&priv->rx_kref, __j1939_rx_release, ...)
      __j1939_rx_release()
        j1939_ecu_unmap_all()

The commit message also doesn't mention the net/can/j1939/socket.c hunk.
That hunk changes the reg_state check in j1939_sk_bind() to use
READ_ONCE(). It also adds a long comment explaining why a bind() racing
with NETDEV_UNREGISTER needs no recheck. The new reg_state test in
j1939_ecu_verify_get() relies on that reasoning.

Could the changelog describe the indirect UNREGISTER path and the
j1939_sk_bind() change?

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index c6278d7cb1b1f..f444a1f33582b 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -130,8 +141,31 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>  
> +restart:
>  	write_lock_bh(&priv->lock);

[ ... ]

> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		if (!j1939_ecu_valid(ecu))
> +			continue;
> +		if (j1939_ecu_timer_cancel(ecu))
> +			continue;
> +		/* Get a ref, in order to call hrtimer_cancel() without priv->lock. */
> +		if (!j1939_ecu_get(ecu))
> +			continue;
> +		write_unlock_bh(&priv->lock);
> +		if (hrtimer_cancel(&ecu->ac_timer))
> +			/* Drop the ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +		/* Drop the ref from default: above. */
> +		j1939_ecu_put(ecu);

[Severity: Low]
This isn't a bug, but does "default: above" point to the right place?
j1939_ecu_unmap_all() has no default: label. The nearest one is the
"Currently executing" case in j1939_ecu_timer_cancel(), and that case
takes no reference:

	default: /* Currently executing. */
		/* Let the caller decide how to handle this situation. */
		return false;

The ref dropped here comes from the j1939_ecu_get(ecu) call a few lines
earlier in the same loop.

This file tracks get/put pairs through comments like this one. Could the
comment name that j1939_ecu_get() call instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/a1dd9760-7815-400a-a39c-a1a03cf8262e%40I-love.SAKURA.ne.jp
