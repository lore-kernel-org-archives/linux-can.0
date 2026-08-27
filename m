Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC03F105E;
	Thu, 27 Aug 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859852; cv=none; b=relmwNT5MVHIiF7I7K30kq+G+eruwYzHlFMQIk5JrwMV2KzVEM+1pa4kRjJbdo1ZO2+c4Tv5+VsGwp7zpcL5+d5hT59PdwNVl1kdW6Yumnb4qsv8OW90N/gTg0UWdSTluR+iMF19lzfJTYOO1XrBZe5LVKnku2aDrDmDZ49G6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859852; c=relaxed/simple;
	bh=vth3qTAeDmjgEF3tK+3zhddF/nyfxvOHd9P+4ecyujI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/MatLLWH5vJw7PQyCBF/JUk2w0/CmWnQtNqXlNpTV1NsParmno8X07cJ8WCvOLKvTP2ebKZ0k07HsV1FsWcjdj/S0LKEgxOOn932TRq+tIzOe0J/l/E4aYJ3DXBDpCcj4BgrOLHL1HKuSxdlr+m4Omay3fDVWwfJvmIFZNBJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxS9cCAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxS9cCAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688301F000E9;
	Thu, 27 Aug 2026 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859850;
	bh=Oo3RvhMBNE+iKya/grTAmR8nALOBEurSiP3LnvgMo8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxS9cCAVtHZ78XEkD+ntCQEENiI8brKKObrWBzKxpfaoVd9c4Yyd2C+IUGIanf0B3
	 ETENyW471FDgTEh/pLzJZo8ESpdQ8raAimvFmBnXpYFRRcjh1nhgl3KdPPHQRz74bw
	 PI8hOHkYmAB37SXXfQKUOh4ftnseXnVsoXFRYxrG7wwdcMj7WiSUci02Km5bsdIXip
	 I7Hm93M2KH3Z0vDmRWz6uEMPrtFF+AHG1jl6S9FnFO0dKayKgnjWLlz+vF8S8o+E3s
	 KmWbXl0TzSQ+Z3NA3Il9FrNzUTiidMnOZ+z0Qqg+3CEzvO7kYqDQ5J5drShb/r5KB0
	 KjvVw1q6D3gSw==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	blbllhy@gmail.com,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net 07/14] can: rockchip_canfd: serialize TX state and command writes
Date: Thu, 27 Aug 2026 12:44:09 -0700
Message-ID: <20260827194409.4023765-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826121036.2706424-8-mkl@pengutronix.de>
References: <20260826121036.2706424-8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
can: rockchip_canfd: serialize TX state and command writes

This adds a new spinlock priv->tx_lock to the rockchip_canfd driver and uses
it to serialize tx_head, tx_tail and the echo skb ring between the transmit
path and the RX/completion path.  The same lock is also taken around the
erratum 12 MODE/CMD/MODE register sequence, and lockdep_assert_held() is
added to the helpers that now require it.

Link: https://patch.msgid.link/tencent_AF224EFBC9343DD238C80824AC8CA805480A@qq.com

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> index 24e87daa1df00..59420233c9184 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> @@ -100,14 +100,25 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
>  	const struct canfd_frame *cfd_nominal;
>  	const struct sk_buff *skb;
>  	unsigned int tx_tail;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +
> +	if (!rkcanfd_get_tx_pending(priv))
> +		goto out_unlock;
>  
>  	tx_tail = rkcanfd_get_tx_tail(priv);
>  	skb = priv->can.echo_skb[tx_tail];
>  	if (!skb) {
> +		const unsigned int tx_head_unmasked = priv->tx_head;
> +		const unsigned int tx_tail_unmasked = priv->tx_tail;
> +
> +		spin_unlock_irqrestore(&priv->tx_lock, flags);
> +
>  		netdev_err(priv->ndev,
>  			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
>  			   __func__, tx_tail,
> -			   priv->tx_head, priv->tx_tail);
> +			   tx_head_unmasked, tx_tail_unmasked);
>  
>  		return -ENOMSG;
>  	}

[ ... ]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> index fc338ea865feb..b367341dd0aeb 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

> @@ -60,6 +71,8 @@ void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
>  	const unsigned int tx_tail = rkcanfd_get_tx_tail(priv);
>  	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_tail);
>  
> +	lockdep_assert_held(&priv->tx_lock);
> +
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
>  }

[ ... ]

> @@ -88,10 +102,13 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		return NETDEV_TX_BUSY;
>  	}
>  
> +	spin_lock_irqsave(&priv->tx_lock, flags);
>  	tx_head = rkcanfd_get_tx_head(priv);
>  	frame_len = can_skb_get_frame_len(skb);
>  	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
>  	if (err) {
> +		spin_unlock_irqrestore(&priv->tx_lock, flags);
> +
>  		ndev->stats.tx_dropped++;
>  		return NETDEV_TX_OK;
>  	}

[Severity: Low]
The last paragraph of the changelog says:

    "Install the echo skb before loading the hardware TX buffer so
     an echo setup failure cannot desynchronize the hardware and software TX
     state."

Is that part of this change?  In the hunk above, the can_put_echo_skb()
call and its error return are unmodified context; only the two
spin_lock_irqsave()/spin_unlock_irqrestore() lines are added.  That
reordering came from the preceding commit 4a223c132464 ("can:
rockchip_canfd: prevent TX stall on echo skb failure"), which itself
depends on the can_put_echo_skb() ownership change that landed later in the
same series as "can: dev: can_put_echo_skb(): free skb on invalid echo
index".

The same applies to rkcanfd_xmit_retry() above: selecting the retry slot
with tx_tail instead of tx_head comes from 0b345ad5c3d3 ("can:
rockchip_canfd: retry the outstanding TX buffer"), and this patch only adds
lockdep_assert_held() there.

Since this commit carries Cc: stable and two Fixes: tags, could the message
name those prerequisites so a backport into a tree without 4a223c132464 and
0b345ad5c3d3 is not attempted as a standalone cherry-pick?

> @@ -136,6 +153,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
>  
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);

[Severity: High]
Does tx_lock really make the erratum 12 sequence atomic against all MODE
writers?  The protected sequence is:

  rkcanfd_start_xmit_write_cmd()
      rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default | RKCANFD_REG_MODE_SPACE_RX_MODE);
      rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
      rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);

Two other RKCANFD_REG_MODE writers in rockchip_canfd-core.c do not take
tx_lock:

  rkcanfd_chip_set_reset_mode()
      reset_control_assert(priv->reset);
      udelay(2);
      reset_control_deassert(priv->reset);
      rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);

  rkcanfd_chip_set_work_mode()
      rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);

rkcanfd_chip_set_reset_mode() is reachable from hard interrupt context:

  rkcanfd_irq() -> rkcanfd_handle_state_error_int() ->
    rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF) -> __rkcanfd_chip_stop() ->
      rkcanfd_chip_set_reset_mode()

spin_lock_irqsave() masks interrupts only on the local CPU, so on SMP that
handler can run on another CPU between the three writes above.  If
MODE = 0x0 lands between the SPACE_RX_MODE write and the CMD write, does CMD
not then execute with SPACE_RX_MODE cleared, which is exactly the erratum 12
bypass that Fixes: 83f9bd6bf39d is meant to close?

If the reset lands just before the trailing restore instead, the transmit
path writes MODE = priv->reg_mode_default (which includes
RKCANFD_REG_MODE_WORK_MODE) after the bus-off handler reset the controller
and after rkcanfd_chip_interrupts_disable() masked all interrupts.  Can that
leave the hardware running in work mode while priv->can.state is
CAN_STATE_BUS_OFF, with no interrupt left to recover the interface?

Can the two paths really overlap?  can_bus_off() only calls
netif_carrier_off() and schedules restart_work, and the TX queue is
deactivated asynchronously through linkwatch, so a frame already queued in
the qdisc can still enter rkcanfd_start_xmit() on another CPU while the
bus-off interrupt resets the chip.

Would it make sense to have these MODE writers take tx_lock as well, or to
document why they are exempt?

[ ... ]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
> index 95bea9bfd8a2f..2dc3a41afe32d 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h

[ ... ]

> @@ -474,6 +475,7 @@ struct rkcanfd_priv {
>  	struct can_rx_offload offload;
>  	struct net_device *ndev;
>  
> +	spinlock_t tx_lock; /* protects tx_head, tx_tail and echo_skb */
>  	void __iomem *regs;
>  	unsigned int tx_head;
>  	unsigned int tx_tail;

[Severity: Medium]
The new comment states that tx_lock protects tx_head, tx_tail and echo_skb,
and the patch enforces that with lockdep_assert_held() in
rkcanfd_tx_tail_is_eff(), rkcanfd_xmit_retry() and
rkcanfd_handle_tx_done_one().  Should rkcanfd_chip_fifo_setup() in
rockchip_canfd-core.c take the lock too?  It writes both counters with no
lock held:

	WRITE_ONCE(priv->tx_head, 0);
	WRITE_ONCE(priv->tx_tail, 0);
	netdev_reset_queue(priv->ndev);

It runs on the bus-off restart and "ip link ... type can restart" path:

  can_restart() -> netif_carrier_on() -> priv->do_set_mode(CAN_MODE_START)
    -> rkcanfd_set_mode() -> rkcanfd_chip_start() -> rkcanfd_chip_fifo_setup()

can_restart() turns the carrier on before calling do_set_mode(), and carrier
changes only queue linkwatch work, so dev_activate() can re-arm the qdisc
while rkcanfd_chip_fifo_setup() is still zeroing the counters.

Can this interleave?

CPU0 rkcanfd_start_xmit() (holds tx_lock)
    tx_head = rkcanfd_get_tx_head();          /* N */
    can_put_echo_skb(skb, ndev, tx_head, frame_len);
    ... hardware TX buffer writes ...
    WRITE_ONCE(priv->tx_head, N + 1);

CPU1 rkcanfd_chip_fifo_setup()
    WRITE_ONCE(priv->tx_head, 0);
    WRITE_ONCE(priv->tx_tail, 0);
    netdev_reset_queue(priv->ndev);

Afterwards the head/tail pair describes neither the echo ring nor the
hardware FIFO, which looks like it can produce the "echo_skb[%u]=NULL"
errors and a stopped TX queue with no completion left to wake it.  The same
restart path also frees echo skbs through can_flush_echo_skb() without
tx_lock, and netdev_reset_queue() there races netdev_sent_queue() in the
transmit path.

Two smaller inconsistencies with the documented rule: the diagnostic in
rkcanfd_rxstx_filter() is now taken from a locked snapshot, while the
identical one in rkcanfd_start_xmit() still reads both fields unlocked:

		netdev_info(priv->ndev,
			    "Stopping tx-queue (tx_head=0x%08x, tx_tail=0x%08x, tx_pending=%d)\n",
			    priv->tx_head, priv->tx_tail,
			    rkcanfd_get_tx_pending(priv));

and rkcanfd_handle_rx_int_one() still gates entry into the now
lock-protected rkcanfd_rxstx_filter() on an unlocked
rkcanfd_get_tx_pending().  Were both left out on purpose?
