Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025744;
	b=VB/TDieliJKGIXSsCfei5YGsslb+82tA73geENA9VSqiQdFzMcDKIZCMYjHVzKnEuQ2t
	 8yPSKpiQhpSWQR362WPZnAo+Zir55NEgPTBczVTcYthYtWv/gbD47y7bpUfLYROqFrUh7
	 pyumBVPY1x/m4Ed1MM6ZHb6LRc7SImHcP5jOEnVSiyvmVP7Zz5awEWSJu1XyFtniQMr5/
	 1LPvgYO8n+8pEhx9DrAcEst1f7HeIuLrnJHf5rnDhzD3EKC03XY+ETEieWXak6L76RW3Z
	 nsd7n9eMxaOFlQ4Rxh7nfAAB+Z89zZ1eP5Sz3u/7OF4uUS7gzddQvm9MwF97x15NQ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025744;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Xe/Oe8irhvXytfjKAhokcvwM4zojCbsivzTBjA8hWAE=;
	b=1t9gMW+WUIKod44hHxi4JtI2kfHw4eHQhFbueSMwHEQpcyToMDZNcgKGDwbwchDQkiWc
	 VdjPI5rfiJUJPthb4YjpR246iapSbmK79ojfvIWBJGTfk6EuUaV3tABjO6/w1nm6L9W9s
	 gHK1+HXIHOvJyNCGX/V3k55g16/Up3hH6pTO4Aj9wkXZsZjW30RxyBcB1FWIT9UxsaMYR
	 mCdnJcA6Xn3G8LpGuG6m+apgskSlnkpbUya+5KvCnMMIKmxZySi393MLItnGY2CMD0gaU
	 fXJZnH/2ytBAjMX8SehNgb1429tng7yLURvliH7U7kJNT9JLpv7VgSBX3olhY9hXHFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBDmfqdd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817D606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBDmfqdd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D71F008A1;
	Sat,  7 Nov 2026 04:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025743;
	bh=Xe/Oe8irhvXytfjKAhokcvwM4zojCbsivzTBjA8hWAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DBDmfqddZY1kcLnkZMbS11TAvgpA9k0XGfUVMUMOVa3QC4m8TpJRdfQG9fco8Zs69
	 jc7zCG3/vGFjPtmXWetSx0ebVvjcM/vAvAetknN8Fgk/Lg+sKTY5trEsSFTfpXiX1M
	 v6kEJxonleWoozYnM7dT1hMln7J7iwpmbWXZBWKgNwe1Sm34IMGp0JXX8s4Bs7RbEy
	 zZ16TCLILh7pCrIEoAURx+KhHGQ1vh/iOiwNjV42/UoOUuwcLAvmWg9OGIWq/BnnGX
	 0LaRUiral9KcAHeeKOD7VkfbI6Ka8nFGE9iC6OBmHb5ZbTike6yWrLlfI0OdaC5a8D
	 gpEAzUStjkG0A==
Subject: Re: [PATCH v8 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
 in j1939_ecu_map_locked()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sat, 07 Nov 2026 04:29:02 +0000
Message-ID: <179402574271.488853.5501782548576402373@kernel.org>
In-Reply-To: <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
References: <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
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

- [Low] Undisclosed backport dependency.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a two-
  CPU deadlock.

--

can: j1939: fix "struct j1939_ecu" refcount leak in j1939_ecu_map_locked()

This commit makes j1939_ecu_map_locked() drop the ECU reference it just
took, and makes j1939_ecu_create_locked() fail with -ENODEV, when the
netdev is no longer registered or __j1939_rx_release() has already run.
This keeps j1939_ecu_timer_handler() from re-mapping an ECU after
j1939_ecu_unmap_all() has finished.

> For now we don't cancel ecu->ac_timer from j1939_ecu_unmap_all(), for
> we can't safely call hrtimer_cancel() with priv->lock held. However,
> since ecu->ac_timer expires in 250ms, for now let's tolerate delaying
> completion of NETDEV_UNREGISTER event for less than one second.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Still,
the rule given here (hrtimer_cancel() is not safe with priv->lock held)
already seems to be broken in j1939_ac_process() in
net/can/j1939/address-claim.c.

j1939_ac_process() takes priv->lock for write. While still holding it, it
calls j1939_ecu_timer_cancel(), which calls hrtimer_cancel() on
ecu->ac_timer:

CPU0 (CAN RX softirq)
j1939_can_recv()->j1939_ac_recv()->j1939_ac_process()
    write_lock_bh(&priv->lock);
    ...
    /* cancel pending (previous) address claim */
    j1939_ecu_timer_cancel(ecu);
        hrtimer_cancel(&ecu->ac_timer);

The timer callback takes the same lock:

CPU1 (hrtimer softirq)
__run_hrtimer()->j1939_ecu_timer_handler()
    write_lock_bh(&priv->lock);

Say ac_timer expires on CPU1, and j1939_ecu_timer_handler() is already
spinning on priv->lock. At that moment CPU0 gets an ADDRESS_CLAIMED frame
with the same NAME but a different SA.

hrtimer_try_to_cancel() returns -1 while the callback is running, so
hrtimer_cancel() keeps retrying in hrtimer_cancel_wait_running(). On
!PREEMPT_RT that is cpu_relax(). On PREEMPT_RT it blocks on the softirq
expiry lock while the rwlock is held.

Can this leave both CPUs spinning forever with BH disabled? The trigger is
ADDRESS_CLAIMED frames, which any node on the bus or a local vcan sender can
send.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..77b6788060573 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -84,6 +84,15 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
>  	if (!j1939_ecu_get(ecu))
>  		return;
>  
> +	/* Drop the ref if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
> +	    !kref_read(&priv->rx_kref)) {
> +		j1939_ecu_put(ecu);
> +		return;
> +	}
> +

[Severity: Low]
This isn't a bug, but is there an undisclosed backport dependency here?

The context line "if (!j1939_ecu_get(ecu)) return;" comes from the earlier
patch "can: j1939: fix possibility of list corruption in
__j1939_ecu_release()". That patch turned j1939_ecu_get() into a
__must_check bool wrapper around kref_get_unless_zero(). It also moved the
call ahead of the ent->ecu check.

In the trees covered by the Fixes: tag, the code still looks like this:

static void j1939_ecu_get(struct j1939_ecu *ecu)
{
	kref_get(&ecu->kref);
}

and j1939_ecu_map_locked() calls it after the ent->ecu check. So this hunk
won't apply as-is.

The prerequisite has no Fixes: or Cc: stable tag, and this commit doesn't
mention it. Since this patch carries "Fixes: 9d71dd0c7009", stable tooling
will try to pick it up on its own.

Could the prerequisite get a Fixes:/Cc: stable tag, or could this commit
note the dependency? Either way, backporters would know whether to take
both patches or adapt this one by hand.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3d7e48fa-9af5-43e2-84f7-884e61f9d179%40I-love.SAKURA.ne.jp
