Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD05345EAE
	for <linux-can@vger.kernel.org>; Thu, 20 Aug 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192423; cv=none; b=ftLXIHBXAzd20HKsVl/WO+al4iYMWOo7f0EzRz5K+BDrswAoDc0p//xJyswb/lstTaiqb46x12e4ObvI37Kn1Uhavu4HQHaRJZIaYYK22v8qP/jAG3Kb7Nk2juNqSUD5szjXlPCerec7Vkwcwv7VB4sj0KjMKp2jkWO3jpM5K+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192423; c=relaxed/simple;
	bh=8B50Wuj9kRFWD0XUf0BQOWRLRTpcl8InsLiJ5eJUzJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/wbMa7F2Jg7fHbYMmMPSBA4t3ltjEfQ+srO0phvPP4Z2Nsm/CUHMAxq0OjDdFMUcKgclzQ1Vfg5ukGUUkX/Cm1RzR6d3IlS9ETh9tIDbZZ8pBxLJfhBoNRtURB7RWreQGvLrQdt4Co4KWnbnNcicz74fWUygbtUzssWALb/79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaVJL5Jq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaVJL5Jq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B381F000E9;
	Thu, 20 Aug 2026 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787192421;
	bh=r5Je99qnoX3gECZoe+aar1uFM1WHB0c69PR55efisZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaVJL5JqVVzCu/EYAgHCwXm5J005wId/4ZACpHkdLcWbBibj0YgukJtjaZHwtpKaO
	 ggLBhWv6aIxTbnIJWrCLk1E4eQUx1of9WsXpagIyUd08qSrlNqSFMEkbGC/3R4UNJ6
	 HaVulFZAWRnqn2EeU1BkkwYLIeSRIX4bgrFSSnONk32OuVz+rkdO6HisGuIYu9UqAE
	 b/DekiNZthlmyx9JTHE+NwMGdQP78vJqet0ZpcIkTKVJ0kpeXWHWksQjYbsmwF4hzc
	 FF53za+YWMQ4IZMfq+xQTQrxXxU2RxhOQW+ICf5narSAJCzvVvQ0BhSbppjNqDayyi
	 5VEB7AeXmp57w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: hi311x: drop hi3110_lock before free_irq() on open
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260820020631.316418-1-runyu.xiao@seu.edu.cn>
References: <20260820020631.316418-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 02:20:20 +0000
Message-Id: <20260820022021.70B381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `hi3110_clean` due to a missing lock in `h=
i3110_do_set_mode` can lead to a double-free (use-after-free) of `priv->tx_=
skb`.
- [High] The driver fails to cancel pending works in `hi3110_stop` and `hi3=
110_can_remove`, allowing deferred I/O on stopped or powered-off hardware.
--

--- Patch [1]: [PATCH] can: hi311x: drop hi3110_lock before free_irq() on o=
pen failure ---
commit d2d3a5df6413395872456083be56586448f72c40
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: hi311x: drop hi3110_lock before free_irq() on open failure

hi3110_open() requests a threaded IRQ and then performs hardware setup
while holding priv->hi3110_lock. The patch fixes a deadlock by dropping
the lock before free_irq() in the open rollback path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index ae90e6716de5b..2be851e8907d0 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this lead to a double-free of
priv->tx_skb?

If hi3110_do_set_mode() is called (e.g. via netlink for manual bus-off
recovery), it unconditionally calls hi3110_clean() without acquiring
priv->hi3110_lock:

drivers/net/can/spi/hi311x.c:hi3110_do_set_mode() {
	...
	case CAN_MODE_START:
		hi3110_clean(net);
	...
}

Concurrently, hi3110_tx_work_handler() can access and free priv->tx_skb
under the lock:

drivers/net/can/spi/hi311x.c:hi3110_tx_work_handler() {
	...
	frame =3D (struct can_frame *)priv->tx_skb->data;
	...
}

Since hi3110_clean() frees priv->tx_skb unconditionally without the lock,
could both threads attempt to process and free the exact same sk_buff
simultaneously?

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of running
deferred I/O on stopped or powered-off hardware?

In hi3110_stop(), the device state is torn down without cancelling
pending works like priv->restart_work and priv->tx_work:

drivers/net/can/spi/hi311x.c:hi3110_stop() {
	struct hi3110_priv *priv =3D netdev_priv(net);
	...
}

Furthermore, during driver unbind, hi3110_can_remove() disables hardware
power before destroying the workqueue:

drivers/net/can/spi/hi311x.c:hi3110_can_remove() {
	...
	unregister_candev(net);

	hi3110_power_enable(priv->power, 0);

	destroy_workqueue(priv->wq);
	...
}

Since destroy_workqueue() flushes pending works, could this cause the works
to execute on powered-off hardware and unregistered netdevs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820020631.3164=
18-1-runyu.xiao@seu.edu.cn?part=3D1
