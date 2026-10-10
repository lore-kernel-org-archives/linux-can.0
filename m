Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEBD491589;
	Sat, 10 Oct 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640988; cv=none; b=kHw7UmJt3gUE12WA8tEnWSebD5V8wCqd4yFv9out1LnsozM32Vg8f4OChs8IVnfJdaLAXMwyq7C05Epi2rm72c6MwuUB2Pw1HZbS+RJE/xjga2pycJm034biLKAKc5GjjK2t0/IDChPaufy62mF54AEb1QcdLZPAo94BJ5z6s+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640988; c=relaxed/simple;
	bh=qggvPQxcDzvEOuiDCydvy615d4PAoOna+6c2TYmqAfA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izMtYv5HTrPpqjTBpbgZFBoEt1LFGIOESzkkvLAdjT7Sb5RIMeKcNKYoxxzMxYnsgjfD+n60TUfKXsVzIFKhBq4U3IXtNufqbUbP4M+mP2lRDglZxRV7Rb7XGtyBlD3oAfdTllo7K697GTDtBtJgdZs+/boETDQ9uvtgLAQSsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+OIlg0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+OIlg0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F271F00899;
	Sat, 10 Oct 2026 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640987;
	bh=lJCM6ItxUFXkobuyLb6qkYSaLoqavOepAX6IHlI2FzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U+OIlg0iEev5LtxF7lQ0gLOrCTVfo/UeLo2zbSQubmBUm4tIvitIK5pBR8kFTnplO
	 RHVoWBtWr8Jpb1lU2ZCTFv9naIH/Bn9lDsr2oM7TEhYBjBxw5O4I7PoB7jIhdYfq8D
	 7v9EtN5kyKBY7U6iceEHmOQZpZ+pGhVhdHToJRI/vl1y2oL2E5VImhIDJ2kJrk9iFU
	 o3YH3hcAlAhvJ/W81Q6Qbm3S8JFHmtCnDOQhzZ+m4QGXGeCweQ1E8RaZ1Jiy3b7zVt
	 dyfNPV1sj2Ho629q66+/8v17i4G0JPmHi8xjRA7Qn8iPF50l/H9ekh+VwK2A9WD+A8
	 VvP4in/byTouQ==
Subject: Re: [PATCH net-next 30/37] can: hi311x: drop hi3110_lock before
 free_irq() on open failure
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:06 +0000
Message-ID: <179164098630.434549.4478960548038882608@kernel.org>
In-Reply-To: <20261009134323.64064-31-mkl@pengutronix.de>
References: <20261009134323.64064-31-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The rollback in hi3110_open() (drivers/net/can/spi/hi311x.c,
  lines 789-794) sets priv->force_quit = 1 and drops hi3110_lock before…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the driver's
  own restart_work is never cancelled or flushed during shutdown.

--

can: hi311x: drop hi3110_lock before free_irq() on open failure

This patch changes the hi3110_open() error path. It now sets force_quit
and drops hi3110_lock before calling free_irq(), then takes the mutex
again for the remaining hardware cleanup. This avoids a deadlock against
the threaded IRQ handler, which takes hi3110_lock before it checks
force_quit.

Link: https://patch.msgid.link/20260820020631.316418-1-runyu.xiao@seu.edu.cn

> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index 076a3efa1bfff..927555b5d581e 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
>  	return 0;
>  
>   out_free_irq:
> +	priv->force_quit = 1;
> +	mutex_unlock(&priv->hi3110_lock);
>  	free_irq(spi->irq, priv);

[Severity: Medium]
Can this rollback turn the old deadlock into an IRQ storm when
hi3110_set_normal_mode() fails?

The IRQ is requested with IRQF_ONESHOT | IRQF_TRIGGER_HIGH. Before
hi3110_set_normal_mode() returns -EBUSY, it has already armed the chip:

drivers/net/can/spi/hi311x.c:hi3110_set_normal_mode() {
    hi3110_write(spi, HI3110_WRITE_INTE, HI3110_INT_BUSERR |
                 HI3110_INT_RXFIFO | HI3110_INT_TXCPLT);
    hi3110_write(spi, HI3110_WRITE_CTRL1, HI3110_CTRL1_TXEN);
    ...
    hi3110_write(spi, HI3110_WRITE_CTRL0, reg);
    mdelay(HI3110_OST_DELAY_MS);
    reg = hi3110_read(spi, HI3110_READ_CTRL0);
    if ((reg & HI3110_CTRL0_MODE_MASK) != reg)
        return -EBUSY;
    ...
}

A received frame or a bus error during the mdelay() window can assert
INT. Once force_quit is set, hi3110_can_ist() skips the whole
while (!priv->force_quit) loop. It never reads STATF, the FIFO or INTF,
but it still returns IRQ_HANDLED.

irq_finalize_oneshot() then unmasks the line, which is still asserted.
The interrupt fires again right away, so the SCHED_FIFO IRQ thread spins
until free_irq() finally shuts the line down.

If the IRQ thread was blocked on hi3110_lock, the new mutex_unlock()
wakes it. On the same CPU (always the case on UP), it can preempt the
opener, which holds RTNL, before the opener reaches free_irq().

The opener then only runs again through RT throttling or the fair
dl_server. That bounds the stall to about one RT period by default, but
the stall can be indefinite if those safeguards are disabled.

Would it be better to quiet the chip while still holding the mutex,
before force_quit is set and the lock is dropped? That could mirror
what hi3110_stop() does:

    hi3110_write(spi, HI3110_WRITE_CTRL1, 0x0);
    hi3110_write(spi, HI3110_WRITE_INTE, 0x0);
    hi3110_read(spi, HI3110_READ_INTF);

Another option is calling disable_irq_nosync() before mutex_unlock().

hi3110_stop() already uses the same force_quit then free_irq() ordering
while INTE is still enabled, so the same hazard exists there. In the
open() rollback path, though, it is new with this patch.

> +	mutex_lock(&priv->hi3110_lock);
>  	hi3110_hw_sleep(spi);
>   out_close:
>  	hi3110_power_enable(priv->transceiver, 0);

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce, but is
priv->restart_work ever cancelled or flushed on shutdown?

hi3110_do_set_mode() queues it for CAN_MODE_START:

drivers/net/can/spi/hi311x.c:hi3110_do_set_mode() {
    ...
    priv->restart_tx = 1;
    if (priv->can.restart_ms == 0)
        priv->after_suspend = HI3110_AFTER_SUSPEND_RESTART;
    queue_work(priv->wq, &priv->restart_work);
    ...
}

hi3110_stop() calls close_candev(), which only cancels the CAN core's
delayed restart_work. It never calls
cancel_work_sync(&priv->restart_work), and neither does the hi3110_open()
rollback.

If the work is still pending at ifdown or during a failed open(),
hi3110_restart_work_handler() can run after cleanup. It takes
hi3110_lock and calls hi3110_hw_reset(), hi3110_setup() and
hi3110_set_normal_mode(), which re-arms INTE, TXEN and normal mode. It
then clears force_quit and calls netif_wake_queue() on the downed
interface.

The controller would then be back on the bus while the interface is
administratively down.

The new unlocked window around free_irq() in hi3110_open() gives the
worker one more place to run. It does not seem to make things worse than
the existing post-stop case, because free_irq() still completes and the
rollback then calls hi3110_hw_sleep().

There is no use-after-free here, because hi3110_can_remove() runs
destroy_workqueue() before free_candev().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
