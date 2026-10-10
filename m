Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37622381AF4;
	Sat, 10 Oct 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640987; cv=none; b=R8uGrrp44fuzUdBQgOyb3kZQ8DECp+K8sRaBsSEk6v0YO1IalN9tsaLKaUvEhontptv2zSG9xneEVyP79kFupz48vyf4IBj2M1jTE4Blf1/mk0UeMrOLfXbkY2Ip2m9ESU3v34IoCxNlDAHIgePyEP7ycCiYBGUnzvikvt09eXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640987; c=relaxed/simple;
	bh=es79TXoawW+F1N/FRg5YauBC2p5mOCxCYb3/Hz6XO2c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1i1dOCfobhERAfk41zOy/GwHjH/KSsxalFoDTxh0JLprh264KmsgLMStjQVkymRI5sYsjQ6uaR6nPrnsNGvvuI24xHKzYQXO3iLwXW6JZryDePbbiMU3yCru5v+9fE095XDbziCR9BsEgF4eYYaOMkkvgG4MEGiHX3kFIk2uHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HATwK/QI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HATwK/QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C51F00898;
	Sat, 10 Oct 2026 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640986;
	bh=oubQDfOR44OlLpqw5alvLpPZA1BJGJ68oC4bs2Lq+lk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HATwK/QISyntihps8k3a6EdDpJDf1kcCjGtiQFacTjfbIgPFRN4dymeB+cSgTDV0o
	 GdAopuYEKVZgGotC6Bun7UvKz0VC3Sns/YDC+zEFSVjl0pNzU6bOUscw7xWrgNPaG7
	 O5wQ0tQJ7dVQ8MdpoWjF0t0m+8nsl9sy6j0aOpsdqoxvXYWOIft/n6dhJFURn9Y2nt
	 YBlWBX3cxe05C1fjpiDuf8khHUmzUiCB45ZtpgSiKjnvWKOFZ+W4AOSceVUiRHD3bO
	 9K4f2RW4RozkkAWiRVPSmdpCpbGMKATPI+YmjYX8cWQdE428jSJraAUk4pdMJhrJmm
	 I1wFkK5Vb4Dbg==
Subject: Re: [PATCH net-next 29/37] can: f81604: f81604_close(): fix
 use-after-free on disconnect
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:05 +0000
Message-ID: <179164098515.434549.1408950687154523342@kernel.org>
In-Reply-To: <20261009134323.64064-30-mkl@pengutronix.de>
References: <20261009134323.64064-30-mkl@pengutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers ndo_stop.
- [High] The fix reorders only one of the two works that the int URB
  completion handler can schedule.
- [Low] The patch fixes a use-after-free and carries 'Cc:
  stable@vger.kernel.org', but the commit message has no Fixes: tag.

Pre-existing issues:
- [High] Each bus-off restart submits a new set of URBs on top of the
  ones that are already running.
- [High] f81604_close() calls close_candev() -> can_flush_echo_skb()
  (line 1078) while URB completions can still use priv->echo_skb[0].
- [Medium] f81604_close() puts the controller into reset mode with IER
  off (f81604_set_reset_mode(), line 1075) before it stops the async…

--

can: f81604: f81604_close(): fix use-after-free on disconnect

This commit moves cancel_work_sync(&priv->clear_reg_work) in f81604_close()
to after f81604_unregister_urbs(). After that change, an URB completion
handler can no longer schedule clear_reg_work once the cancel has returned.
The goal is to stop the work from running after the netdev and private data
are freed.

Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel.org/
Link: https://patch.msgid.link/20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw

> Cc: stable@vger.kernel.org

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag next to the stable Cc?
The teardown order in f81604_close() looks unchanged since the driver was
added, so the tag would be:

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index 4c147b9d6d690..bb155b8769245 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
>  	f81604_set_reset_mode(priv);

[Severity: Medium]
This is a pre-existing issue, but can a bus-off restart running at the same
time undo this reset? can_restart_work()->can_restart() does not take RTNL.
The restart_work timer could fire while f81604_set_reset_mode() is doing
its control transfers:

can_restart()
  f81604_set_mode(CAN_MODE_START)
    f81604_start()
      f81604_set_normal_mode()
        clears MOD.RM, writes IER = IRQ_ALL & ~RI

In that case, cancel_delayed_work_sync() in close_candev() only waits for
the restart to finish. f81604_unregister_urbs() then kills the URBs the
restart submitted, but nothing puts the chip back into reset mode.

Would ndo_stop then return with the SJA1000 core still in operating mode on
the bus while the netdev is down?

>  
>  	netif_stop_queue(netdev);
> -	cancel_work_sync(&priv->clear_reg_work);
>  	close_candev(netdev);

[Severity: High]
This reorders clear_reg_work, but doesn't restart_work have the same
problem? close_candev() runs cancel_delayed_work_sync(&priv->restart_work)
here, but the int URB stays live until f81604_unregister_urbs() below.

Suppose an int URB completes in that window with F81604_SJA1000_IRQ_EI and
SR.BS set. f81604_handle_can_bus_errors() then does:

	if (data->sr & F81604_SJA1000_SR_BS)
		can_state = CAN_STATE_BUS_OFF;
	...
		if (can_state == CAN_STATE_BUS_OFF)
			can_bus_off(netdev);

If restart_ms is set, can_bus_off() re-arms the work:

	if (priv->restart_ms)
		schedule_delayed_work(&priv->restart_work,
				      msecs_to_jiffies(priv->restart_ms));

The interrupt report could be a buffered or in-flight one, or come from a
malicious device. It can also arrive if the IER-off write in
f81604_set_reset_mode() failed, because f81604_close() ignores its return
value.

Nothing cancels restart_work after that. When it fires,
can_restart()->f81604_set_mode()->f81604_start() puts the chip back into
normal mode, resubmits the URBs and wakes the queue on an interface that is
down.

If the device is unplugged before restart_ms expires,
f81604_disconnect()->unregister_netdev() skips ndo_stop because the device
is already down. free_candev() then frees can_priv while the restart_work
timer is still armed.

Would it be better to call f81604_unregister_urbs() before close_candev(),
as gs_usb and peak_usb do?

[Severity: High]
This is a pre-existing issue, but can close_candev()->can_flush_echo_skb()
race here with URB completions that use priv->echo_skb[0]?

The int URB is only killed later, by f81604_unregister_urbs(). The TX URBs
from f81604_start_xmit() are never anchored, so they are never killed or
waited for:

f81604_start_xmit()
	can_put_echo_skb(skb, netdev, 0, 0);

	ret = usb_submit_urb(write_urb, GFP_ATOMIC);

can_flush_echo_skb() checks and frees echo_skb[i] without a lock.
f81604_handle_tx() does the same through can_get_echo_skb() and
can_free_echo_skb(). f81604_write_bulk_callback() does it through
can_free_echo_skb() on error statuses. Both run in completion context.

If both sides see a non-NULL echo_skb[0], could the skb be freed twice? Or
could __can_get_echo_skb() read it after the flush has freed it?

Killing all URBs, including TX, before close_candev() looks like it would
avoid this.

>  
>  	f81604_unregister_urbs(priv);
> +	cancel_work_sync(&priv->clear_reg_work);

[Severity: High]
This covers ndo_stop, but can clear_reg_work still be left pending after a
failed open? In f81604_start(), the URBs are already live when
f81604_set_normal_mode() runs:

	ret = f81604_register_urbs(priv);
	if (ret)
		return ret;

	ret = f81604_set_normal_mode(priv);
	if (ret) {
		f81604_unregister_urbs(priv);
		return ret;
	}

The int URB may complete with error bits in isrc during
f81604_set_normal_mode(). If so, f81604_handle_can_bus_errors() calls
schedule_work(&priv->clear_reg_work).

If f81604_set_normal_mode() then fails (for example -ENODEV during
hot-unplug), the error path kills the URBs but does not cancel the work.
f81604_open() then only calls close_candev().

Since the open failed, IFF_UP is never set, so on disconnect:

f81604_disconnect()
  unregister_netdev()
    netif_close_many() skips ndo_stop for devices without IFF_UP
  free_candev()
    frees the netdev and the embedded f81604_port_priv

Could f81604_clear_reg_work() then run on the freed priv?

Would adding cancel_work_sync() to the f81604_start() error path, or
calling it unconditionally in f81604_disconnect() before free_candev(),
cover this case?

[Severity: High]
This is a pre-existing issue, but does each bus-off restart submit another
set of URBs on top of the ones already running?

can_restart()->f81604_set_mode() calls f81604_start(). f81604_start() then
calls f81604_register_urbs() without calling f81604_unregister_urbs()
first. The completion callbacks resubmit on success, so nothing kills the
open-time URBs at bus-off.

Each restart would then leave another F81604_MAX_RX_URBS bulk URBs plus an
int URB in flight, with their buffers, until ndo_stop.

Also, if f81604_set_normal_mode() fails during a restart, the error path
calls f81604_unregister_urbs(), which kills every anchored URB, including
the open-time set. Would the interface then stay up with no RX or int URBs
until the next down/up?

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
