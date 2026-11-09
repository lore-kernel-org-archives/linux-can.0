Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224268;
	b=mSd0ZYLA0bd1KBLm/xstT2iAZHhWeYY8Z8J1e+iyTAHNfnLT3tkkpp+k8H+ZBi8mliQt
	 BwOKYAQ4o6eU0LnJdvz9yOJf94/wL5ealWmygqEo/Cz6cdQ6kVnU0yFoPQVvnw876MFvU
	 sTez0XQLEfgZVlLFN++9ElSBTluVH0SL2IUr81k08TRned3c0FuWp44F55rUhzTpN/ZpQ
	 Imt9kcfbFw+VcrW/fZbzm1o1zCRfu5O7RKp2tW16H5AheKrnYtQOgw1IECjQRr0BZYq1n
	 NMR/+FKsXRMm53ZgYhY767L9HbBP09tJPoSz/uwsdjtVLReJ+GXlk1WZZPIUY9/6ogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g19ZXvNnkn2obHkdge3oaq3g+AUBSSyUKe6un7hL9ys=;
	b=DG5EDAeLQz0S2OetC+DHdo1B3qfpeVMwjnPc9CUiZHw1rIX6oM2P9oS137XuLREdMxAZ
	 ryQjPYVP5oFp/d7RUlUp7fsI6S2MIkhQPPyRmQG+7gcyRDgeVMMdags5L6o6KHnkijTRk
	 RlT1xZ1FPfd3NOhShvDmG87h8u1i0+Cz0Z6hJYsDzOfxaILhjiEldh8r1ymRYz7H+Z/1Z
	 2zlfI5QW1HaLCe/VyXn7Icl3D+OWM5/cMurLF6XGeFyr3J5TCSEnezqNdH/MwsbvP8fNA
	 zA4ZcTVB7yP28qVBsg0IAfr45bFUfzE+pRJQAJ/QVz1bYuv8XrvJs3Ag9yPikb2mK5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fZu1V5R/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6760606D803;
	Mon,  9 Nov 2026 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZu1V5R/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7A1F008A1;
	Mon,  9 Nov 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224267;
	bh=g19ZXvNnkn2obHkdge3oaq3g+AUBSSyUKe6un7hL9ys=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fZu1V5R/s3CQiVSGy7tButKcUR97J3pmNfeedej4tfSzJZabvF056n74Sq9uViF30
	 zjZFModnbhM0qUCzMvqPul+28JmeLyOmTrWinWK2JtgwZyB/yzlIh7ZWbwws+rIT9s
	 ZRcC0XJWUHASMxXbJaBOHzF9GuNWhL+LMw54OWw2aoe3IGxrD/iOOa3199f/CCLZnh
	 37w05nKMzJ33NH2FYEhFXcgE/7z7qDgV8zzJZeN/rpY0/lIP0tLCTEKyTXH4a89G7a
	 yNX+NiW8TDt7+hWIuSENUx3yEu7QDneICAtoOdfo6WPxfRZ8qxXG1ER+ZpaGNhWqKl
	 fn/JKWIMBAAzQ==
Subject: Re: [PATCH net v8 04/10] can: dev: check netif_running() before
 bus-off recovery
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
Date: Mon, 09 Nov 2026 11:37:46 +0000
Message-ID: <179422426604.994134.9949552464194864721@kernel.org>
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-4-3e7a23fd9eae@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-4-3e7a23fd9eae@qq.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new netif_running() checks in can_bus_off() and
  can_restart() (drivers/net/can/dev/dev.c) are lockless test_bit()…

--

can: dev: check netif_running() before bus-off recovery

This adds netif_running() checks to can_restart() and can_bus_off(), so
bus-off recovery is not queued or started once the interface has begun
closing. The documentation now says recovery is skipped when the
interface is down.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e%40qq.com

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..a893a49a33813 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
>  	if (!priv->do_set_mode)
>  		return -EOPNOTSUPP;
>  
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +
>  	if (netif_carrier_ok(dev))
>  		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
>  

[ ... ]

>  void can_bus_off(struct net_device *dev)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
> +	bool restart;
>  
> -	if (priv->restart_ms)
> +	restart = priv->restart_ms && netif_running(dev);
> +	if (restart)
>  		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
>  			    priv->restart_ms);
>  	else
> @@ -273,7 +280,7 @@ void can_bus_off(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -	if (priv->restart_ms)
> +	if (restart)
>  		schedule_delayed_work(&priv->restart_work,
>  				      msecs_to_jiffies(priv->restart_ms));
>  }

[Severity: High]
Do these lockless netif_running() reads actually prevent what the commit
message describes?

  "Recovery can therefore be queued or started after the interface has
  begun closing, potentially re-enabling hardware while the driver is
  tearing it down."

Both checks are plain test_bit() reads of __LINK_STATE_START.
__dev_close_many() clears that bit under RTNL. Neither the restart
worker nor the IRQ producers take RTNL, so nothing orders the reads
against the clear.

For the worker, can_restart_work() can pass the new check just before
the bit is cleared:

CPU1 (restart worker)
can_restart_work()
  can_restart()
    netif_running() returns true

CPU2 (ip link set down)
__dev_close_many()
  clear_bit(__LINK_STATE_START, &dev->state)
  flexcan_close()
    flexcan_chip_interrupts_disable()
    free_irq()
    flexcan_chip_stop_disable_on_error()
    flexcan_transceiver_disable()

CPU1
    can_flush_echo_skb()
    netif_carrier_on()
    priv->do_set_mode(dev, CAN_MODE_START)

CPU2
    close_candev()
      cancel_delayed_work_sync()

flexcan_close() only waits for the worker in close_candev(), and by then
the hardware is already down. Can the restart callback still re-enable a
controller while it is being shut down?

For producers, can_bus_off() reads the running state and calls
schedule_delayed_work() later. Nothing makes those two steps atomic.
hi3110_stop() calls close_candev() before it quiesces the IRQ thread:

drivers/net/can/spi/hi311x.c:hi3110_stop() {
    ...
	close_candev(net);

	priv->force_quit = 1;
	free_irq(spi->irq, priv);
    ...
}

hi3110_can_ist()->can_bus_off() can see running == true and then be
preempted. Meanwhile close clears the bit, and cancel_delayed_work_sync()
finds nothing pending. The IRQ thread then queues restart_work.
free_irq() waits for the IRQ thread, but it does not cancel the queued
work.

What happens to that stale work afterwards?

On a quick reopen, open_candev() only turns the carrier back on. It does
not cancel restart_work, so the stale work passes netif_running() again.
can_restart() has no priv->state == CAN_STATE_BUS_OFF check, so it calls
can_flush_echo_skb() while the TX path is live:

	/* No synchronization needed because the device is bus-off and
	 * no messages can come in or go out.
	 */
	can_flush_echo_skb(dev);

Could this free echo_skb[] entries while can_put_echo_skb() or
can_get_echo_skb() is using them? It would also call
do_set_mode(CAN_MODE_START) on a controller that is not bus-off.

On removal, free_candev() is just free_netdev(), and nothing cancels
restart_work after the last close. Would can_restart_work() then
dereference priv->dev from a freed can_priv, before the new check runs?

These stale-work consequences existed before this patch. The commit
message's HI3110 notes acknowledge the window. The later "can: dev: add
close_candev_cancel_restart_sync()" in the series only wraps the same
cancel_delayed_work_sync(). The netif_running() gate makes the windows
smaller but does not close them, which is the flag-as-gate-guard
pattern.

Would it be more robust to call disable_delayed_work_sync() in
close_candev() and enable_delayed_work() in open_candev()? Failing that,
the work could be cancelled in open_candev() and free_candev(), with a
priv->state check in can_restart(). Either option would replace the
netif_running() checks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae%40qq.com
