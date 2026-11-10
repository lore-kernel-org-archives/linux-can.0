Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342458;
	b=FTqlpsFqrwEbNwx8BE6Y99WQ7qhrCnpFUoo7cqg/68rZ/1zaqUm/AXjJ9ZLcQl1hIaUs
	 Vo5afZ9I6LSiAbOSnk2sG2IsW1RaOKqglZkj6odEQaxZf5BaX+f602nEJ8PorpMDHUN1c
	 3QaAFqgXDNRxSSWKDvZm17+jxNmStWkRx/N3VeO2VwcLbT/0bByIPx2V3dJrrCsGJERzM
	 4v3n9GBVLosqNhtTobJUrFL6W8efMq6n08O3f+gsrjig/GEHFehoptwgoqdT07tEhEr2Q
	 YPgJ/iY87j2z9u6wKInDLxxDEBFO7oZH8DyW//Oo/BH7oHuajjepYg6qGitMyARcpuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342458;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZQA9tz59isIsGx9GAfU1V+Se4E2UpyC3qIrvYAEQaA0=;
	b=g7Y2lgWDIv/4JAHiv/JD9vBOEYfM+IDKiJYOwXg3ejpcJ54v1KLP03zo2IzhUwBxeWM2
	 P/YDGI3FWHWvhPel2MOcnsPJUlhsZ/Bm0qfjwR2IHoI2sKjDm/V1s4bvkcjtVOhkTxR1y
	 +sL1cQRQiOhvPg8nxlr/YCJyUILX83MN7dO2/ZMNBgm27Qta1a4fIye6iMtU0pPPkE0SH
	 1G1xmD7xowWXcQUdbwghkS32NMwnubmXknVd48lo/gDxwp7LT5Pc155BmeieDXIvcEosN
	 nwhuwc9dWTq0g/kGgcHLZYuPN8kx7WoIGcLDZXXIWpu5/B8D9nTgI60xeepB0turTRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYGEYbq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E87606A31C;
	Tue, 10 Nov 2026 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYGEYbq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2531F0089F;
	Tue, 10 Nov 2026 20:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342457;
	bh=ZQA9tz59isIsGx9GAfU1V+Se4E2UpyC3qIrvYAEQaA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hYGEYbq7uJ8fAPQma3wots1MIA3E4N5aMLGwm9Y6IPdLvzbrP5UUpI3Cz4BhtrI11
	 GnszauZEQaq9K8HrQelC6aflbLF+wNhD0DQb9d2sYA8/e/bFuIAR5bqPcWVORybY6z
	 fIy5n0mqIDMt2NDGJMf+LjywYWXrxWW1Jdt/ptKCsif3p5s81I1YAw+XOxC+8HO6Jq
	 HeM2MiqUx44+vKxJrTgb1Tgf4rVt28HY86qJRe/DVMU4NRQgOpFsEyjx4WU+dyIVvD
	 /Q2rZLft3gqI4Dw4tGtL6Y5nnnXtij7qNmjZHII8WE3geolzVnXHdgv9Fq8HAzG7z2
	 hFArq3jp5DoCg==
Subject:
 Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue
From: netdev-bot+sashiko@kernel.org
To: mike.looijmans@topic.nl
Cc: linux-can@vger.kernel.org, mani@kernel.org, mkl@pengutronix.de,
 thomas.kopp@microchip.com, mailhol@kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Tue, 10 Nov 2026 20:27:36 +0000
Message-ID: <179434245683.488853.8911871804310453120@kernel.org>
In-Reply-To: <20261109070605.9761-1-mike.looijmans@topic.nl>
References: <20261109070605.9761-1-mike.looijmans@topic.nl>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 2 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new netif_stop_queue() in mcp251xfd_handle_cerrif() (line
  1138) runs after the state that allows a restart has been published,…
- [Medium] The new netif_stop_queue() is a lockless bit set from the
  threaded IRQ handler.
- [Low] The patch fixes a hang that users can see: after bus-off, a
  sending process can block in send()/poll() until the interface is…
- [Low] The commit message does not explain why the hang happens.

Pre-existing issues:
- [Medium] mcp251xfd_chip_stop() (lines 755-764) ignores errors from
  mcp251xfd_chip_interrupts_disable(), mcp251xfd_chip_rx_int_disable()…
- [Low] If __mcp251xfd_get_berr_counter() fails in
  mcp251xfd_handle_cerrif(), priv->bec is not updated.
- [Low] This problem wasn't introduced by this patch, but in
  mcp251xfd_handle_cerrif() the non-bus-off branch leaks the error skb.

--

can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue

On bus-off, this patch keeps shutting the chip down even when the error
counter read fails, and logs an error instead of returning early. It also
stops the TX queue after can_bus_off() and relies on mcp251xfd_set_mode()
to wake it on restart. The goal is to fix a send()/poll() hang seen after
bus-off under heavy TX load.

> This fixes a hangup in either send() or poll() from userspace. To
> reproduce: I ran "cansequence can0 -p" to flood the system with packets.

[Severity: Low]
Should this have a Fixes: tag and Cc: stable? The bus-off block in
mcp251xfd_handle_cerrif() goes back to the original driver submission.
That includes the early return on a failed counter read and the missing
queue stop. The only later change was the rename in eb79a267c9b3:

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index f441f2265299e..9770416b24723 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1131,10 +1131,11 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
>  		 */
>  		err = __mcp251xfd_get_berr_counter(priv->ndev, &priv->bec);

[Severity: Low]
This isn't a bug introduced by this patch, but if
__mcp251xfd_get_berr_counter() fails here, priv->bec is not updated.

can_change_state() has already set priv->can.state to CAN_STATE_BUS_OFF.
That means mcp251xfd_get_berr_counter() returns the stale copy to
userspace:

	if (priv->can.state == CAN_STATE_BUS_OFF) {
		*bec = priv->bec;
		return 0;
	}

The old return err path gave the same result.

Could priv->bec be filled from the trec value already read at the top of
mcp251xfd_handle_cerrif(), instead of doing a second TREC read?

>  		if (err)
> -			return err;
> +			netdev_err(priv->ndev, "Failed to store BER counter\n");

[Severity: Low]
Would it be useful to print err in this message? Before, the error went
to the out_fail path in mcp251xfd_irq(), which printed the errno and
called mcp251xfd_dump(). Now the error code is lost.

The commit message doesn't say what this hunk fixes either. The old
return err leaked the error skb allocated by
mcp251xfd_alloc_can_err_skb(). It also left priv->can.state at
CAN_STATE_BUS_OFF (set by can_change_state()), with the carrier still on
and no restart scheduled.

For the netif_stop_queue() part, the only justification given is:

  After adding the netif_stop_queue call, I was unable to reproduce the
  problem.

Can the commit message explain the root cause? can_restart() assumes
nothing is being transmitted during bus-off:

	/* No synchronization needed because the device is bus-off and
	 * no messages can come in or go out.
	 */
	can_flush_echo_skb(dev);

This driver broke that assumption by leaving the TX queue running.

>  
>  		mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);

[Severity: Medium]
This is a pre-existing issue, but mcp251xfd_chip_stop() ignores errors
from mcp251xfd_chip_interrupts_disable(), mcp251xfd_chip_rx_int_disable()
and mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG). With
this patch it is now also called after a failed TREC read.

Suppose the TREC read and the MODE_CONFIG write both fail briefly, and
SPI recovers before the restart. Could the restart then reprogram the
FIFOs while the chip is still in Normal mode, causing TEF consistency
errors?

The other callers of mcp251xfd_chip_stop() use the same unchecked,
best-effort pattern. This only matters when both failures happen in that
order.

>  		can_bus_off(priv->ndev);
> +		netif_stop_queue(priv->ndev);

[Severity: High]
Can this netif_stop_queue() undo the wake from a restart that has
already finished?

By this point, mcp251xfd_chip_stop() has set CAN_STATE_BUS_OFF, and
can_bus_off() has scheduled restart_work if restart_ms is set. When
restart_ms is 0, a manual restart through can_restart_now() only needs
priv->state == CAN_STATE_BUS_OFF. Neither restart path is serialized
against the IRQ thread:

restart path
can_restart()
  mcp251xfd_set_mode()
    mcp251xfd_chip_start()     /* state = CAN_STATE_ERROR_ACTIVE */
    mcp251xfd_chip_interrupts_enable()
    netif_wake_queue(ndev);

IRQ thread
mcp251xfd_handle_cerrif()
  mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);
  can_bus_off(priv->ndev);
  netif_stop_queue(priv->ndev);   /* runs after the wake */

If the wake happens first, the chip runs in ERROR_ACTIVE with an empty TX
ring. mcp251xfd_handle_tefif() then never wakes the queue. A manual
can_restart_now() also returns -EBUSY, because the state is no longer
BUS_OFF.

Wouldn't the queue then stay stopped until ifdown/ifup? That is the hang
this patch is meant to fix.

Would stopping the queue before mcp251xfd_chip_stop() and can_bus_off()
avoid this?

[Severity: Medium]
Is this stop enough to keep the queue stopped during bus-off? Here,
netif_stop_queue() is a lockless bit set from the threaded IRQ handler.
It is not serialized against mcp251xfd_start_xmit(), and two other places
can clear the bit without checking for bus-off.

mcp251xfd_tx_busy() can restart the queue:

	netif_stop_queue(priv->ndev);

	/* Memory barrier before checking tx_free (head and tail) */
	smp_mb();

	if (mcp251xfd_get_tx_free(tx_ring) == 0) {
		...
		return true;
	}

	netif_start_queue(priv->ndev);

The IRQ loop handles TEF before CERRIF in the same pass. An xmit that saw
the advanced tail and was then delayed can call netif_start_queue() after
the bus-off stop.

mcp251xfd_tx_failure_drop() also calls netif_wake_queue()
unconditionally. It can be reached from a failing spi_async() in the
xmit path, or from tx_work through mcp251xfd_tx_obj_write_sync(). tx_work
is not cancelled on bus-off.

Either way, the queue runs again while the chip is in CONFIG mode. That
brings back the concurrency between can_put_echo_skb() and
can_flush_echo_skb() in can_restart(). An xmit that has already passed
the stopped check can also still write TX objects to the stopped chip.

Would these windows close if netif_tx_disable() were called before
mcp251xfd_chip_stop(), and the wake in mcp251xfd_tx_failure_drop() were
made bus-off aware (or tx_work cancelled)?

>  	}
>  
>  	if (!skb)

[Severity: Low]
This isn't a bug introduced by this patch, but further down in
mcp251xfd_handle_cerrif() the non-bus-off branch has a similar early
return:

	if (new_state != CAN_STATE_BUS_OFF) {
		struct can_berr_counter bec;

		err = mcp251xfd_get_berr_counter(priv->ndev, &bec);
		if (err)
			return err;

Does this return leak the skb from mcp251xfd_alloc_can_err_skb()? On
this path the skb is neither freed nor queued to rx_offload. The IRQ
handler then goes to out_fail, so at most one skb leaks per fatal SPI
error. This code dates back to 55e5b97f003e.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109070605.9761-1-mike.looijmans%40topic.nl
