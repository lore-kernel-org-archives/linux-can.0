Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224269;
	b=pJ6RC82lCqaQPnpYTld9RnKmx0aPJzrYRfHHqit1lAvnbOX2Ihp1rYWqqenEF68De41O
	 smPbhcBIFg0jSbPlHd+wpg823V65D0Qe1Vc7cho87fNJ9RQ0n6fPJZj797QXfNEDVsVLh
	 NwlOOfivTyY1Sxm7GwDJbDG+3Mz0mumdiUXWsOOjEurM8F631hHy6AAaLiQXtV6NU/iO9
	 /i2GoupS36OOmhaDDYnVp+H7OdEAb1jrb1m1q7mBYdZZE5t9cmLTUiPDhwzDnzSIY1Ige
	 xnJLiENqn+DqDKGqdYBj7sySjR/N1OiEQECZIAVewZuhEDtEk2JXY17BWB5rFq+IxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224269;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aMxhIa7lXQyxfwIiK+zGkya8pNmYJvDP3o6kzE68WvI=;
	b=TT+ZkP/w6+c4XcR8C8wuvst/BUy9yO4KV+6tOnW6Z3t+uRMegDg4TQJJt8tvhb7eCVMX
	 fyyIjzY7wPVcbdJbjk8wyWJjnivpxuCLNXUjB/Cjmzz+fRNYjYizEbyVYdnIHP0UXYP1i
	 mTu/OaAm588fBjz9gnxzMultllCh5SPYmR7djyVRf+nmNkvgJ0fsTN2rcvwbU9ZPt84LA
	 t7tzpOXRB6KFsRKwwOuEY5L2gtl3V3fltHroQIvuPH4Zxu4vw46aIWBj+jxMXOFyRF+Q2
	 njWI3kf2F2VwudlrmlWHKTRzKHT7+yQU/geERgJ68FIx2w/wtIWQL3lraquaHSgl80w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DnmABkj/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA4606A33B;
	Mon,  9 Nov 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnmABkj/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C461F008A4;
	Mon,  9 Nov 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224269;
	bh=aMxhIa7lXQyxfwIiK+zGkya8pNmYJvDP3o6kzE68WvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DnmABkj//LtEV0R2jiDnjf5V24G97jaD0ET4J0UjAI3mKB70PfsDCG9Kel0U4zhJu
	 HqNu2ZDdggwLcDLYKQDjmAFJyuUE741HQTvL0QdGfwC3gapZuRU8RgHkunqQz624IT
	 WllZplI2d1KS6f7AmSDx5EIEEdcpvb516z6FSVxP0B4SOHEhSQm2BDJ/ZnqvFMHSXe
	 07EGueehYd63kfBqmjllXZ5bEs/uiqk00XwKhg4vjQH6dpU9NRhw1m5he5p9rJiJIc
	 nZjOTUzgujytN0lZxpfODtNduAtI/8YCW7D+OohEkUoL/rSG23zt8H4Yd5UyuZ/c8n
	 8TaPuW1MjiCqQ==
Subject: Re: [PATCH net v8 06/10] can: rockchip_canfd: cancel bus-off restart
 before closing the device
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 09 Nov 2026 11:37:47 +0000
Message-ID: <179422426766.994134.12668762855530226358@kernel.org>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-6-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-6-3e7a23fd9eae@qq.com>
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

- [Low] rkcanfd_stop() (drivers/net/can/rockchip/rockchip_canfd-
  core.c:761) now calls close_candev_cancel_restart_sync().

Pre-existing issues:
- [High] At this commit, the bus-off restart path re-initializes a
  delayed_work that may still be pending or running.
- [High] At this commit, rkcanfd_open() enables RX offload with
  can_rx_offload_enable(&priv->offload) (rockchip_canfd-core.c:737).

--

can: rockchip_canfd: cancel bus-off restart before closing the device

This patch calls close_candev_cancel_restart_sync() at the start of
rkcanfd_stop(). A running bus-off restart is then cancelled while the IRQ,
RX offload and controller clocks are still available. close_candev() stays
after IRQ teardown for the final cancellation and the echo cleanup.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
> index 1cae86973da5a..59a79fe057e66 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -758,6 +758,7 @@ static int rkcanfd_stop(struct net_device *ndev)
>  {
>  	struct rkcanfd_priv *priv = netdev_priv(ndev);
>  
> +	close_candev_cancel_restart_sync(ndev);

[Severity: Low]
Will this build on a stable tree when it is picked up on its own?

close_candev_cancel_restart_sync() is a static inline helper. It is added
to include/linux/can/dev.h by the preceding commit "can: dev: add
close_candev_cancel_restart_sync()":

include/linux/can/dev.h:
static inline void close_candev_cancel_restart_sync(struct net_device *dev)
{
	struct can_priv *priv = netdev_priv(dev);

	cancel_delayed_work_sync(&priv->restart_work);
}

That helper commit has no Fixes: tag and no Cc: stable. This patch has
both, but the commit message does not say it depends on the helper. If
stable or AUTOSEL tooling cherry-picks this patch alone, the build fails
with an implicit declaration of close_candev_cancel_restart_sync().

Other stable-tagged patches in this series do name their prerequisites,
for example "Backports must include the preceding TX serialization
fix..." and "Backports require can_put_echo_skb() to consume...".

Could this patch get a similar note, or a "Cc: stable@vger.kernel.org #
<ver>: <prereq>" annotation? Another option is to call
cancel_delayed_work_sync(&priv->can.restart_work) directly here.

>  	netif_stop_queue(ndev);
>  
>  	rkcanfd_chip_interrupts_disable(priv);

[Severity: High]
This isn't a bug introduced by this patch, but the bus-off restart path
nearby looks like it can re-initialize the timestamp delayed_work while
that work is still pending or running.

rkcanfd_handle_state_error_int() runs in hardirq context. It calls
rkcanfd_chip_stop()->rkcanfd_timestamp_stop(), which uses only the non-sync
cancel:

drivers/net/can/rockchip/rockchip_canfd-timestamp.c:
void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv)
{
	cancel_delayed_work(&priv->timestamp);
}

If rkcanfd_timestamp_work() is already running on another CPU, it can
re-arm itself after that cancel returns:

rkcanfd_timestamp_work() {
	...
	timecounter_read(&priv->tc);

	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
}

Later the restart runs this path:

can_restart_work()
  rkcanfd_set_mode(CAN_MODE_START)
    rkcanfd_chip_start()
      rkcanfd_timestamp_init()
        INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);

Can that INIT_DELAYED_WORK() run on a timer that is still enqueued, and
corrupt the timer base list or drop the pending bit?

There is also a lock-free timecounter_init(&priv->tc, ...) in
rkcanfd_timestamp_start(). It can race with timecounter_read() in the
worker and with timecounter_cyc2time() in the IRQ path.

Later patches in this series appear to fix this:

- INIT_DELAYED_WORK() moves to rkcanfd_timestamp_work_init(), called once
  at probe ("can: rockchip_canfd: serialize TX with bus-off and restart").
- rkcanfd_set_mode() calls rkcanfd_timestamp_stop_sync() before
  rkcanfd_chip_start().
- A timestamp_active flag under timestamp_lock stops the worker from
  re-arming ("can: rockchip_canfd: prevent timestamp work from rearming
  after bus-off").
- The timecounter accesses are serialized by timestamp_lock ("can:
  rockchip_canfd: serialize timecounter timestamp conversion").

[Severity: High]
This is a pre-existing issue, but rkcanfd_open() at this commit does not
undo can_rx_offload_enable() when request_irq() fails:

rkcanfd_open() {
	...
	rkcanfd_chip_start(priv);
	can_rx_offload_enable(&priv->offload);

	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
	if (err)
		goto out_rkcanfd_chip_stop;
	...
out_rkcanfd_chip_stop:
	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
	pm_runtime_put(ndev->dev.parent);
out_close_candev:
	close_candev(ndev);
	return err;
}

Because ndo_open() failed, ndo_stop() is never called, so NAPI stays
enabled. Will the next "ip link set canX up" call napi_enable() on a NAPI
that is already enabled, and hit this check in napi_enable_locked()?

	BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));

The next patch in the series, "can: rockchip_canfd: disable RX offload on
open failure", seems to fix this. It adds can_rx_offload_disable() to the
out_rkcanfd_chip_stop path.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae%40qq.com
