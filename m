Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623541;
	b=bx/OSTTESFd/l6rTcXEjVPKaFgVmFRJ7o0+YJo0d1myyxvPToONvkfmycH9KOXMe0JtU
	 r2Z0Gitijwp+Nep8Y2z+71XwQZqzJgMGYWpVpU+um445XGGGrJvlL+Hi1e0cfDJTxChmF
	 Bws4CZYWLfpYvofRKPerzt+ew0SssWx338+TEeY+d2BPsLazxdYvqpjiiJjKx3JEWrK5x
	 zQwUN9fi5OLRbj1b66XGoEAA+hw+8v5k3m2BV+uBHt8B5FE4OmSHMMWmHXOHYC4gl7fUt
	 V6J5vRP4DA3g05KMz4WGDTGUa28HFXn3kT6WsVJLWcvEe6wboCosMtHd+2WHOR0Q7iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623541;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bGFxZD6xNVodRu361F4ICxHoOfRqAEYXJii33uzdyvY=;
	b=uHMbRWkKt/+H5b5uiB5uLxpzMFEPiBvGLXbPDsuYFDdNUyvn5iUnfU+RsE8yjrBifvny
	 lem0yLeGEuKcuiz8Sr3ECKhOWNJIXQoIzHa11c+GtENZbCOYokj3oVS6gG3WrrgxA0FPf
	 YCrFYPkn/Hw8GNZRCY/zzMw51dFASeqfW8NcCDbHODZrYZ02iE/h7y4FTnt4QvYRAxDEq
	 YP/OhNykmhyJL2g2PWBi+Xso/oTkcrHo1Ggb7+T0jLi1b8DF6y0HlSo4B2oHeRTVKZh0j
	 oOyofsOEt889/fGutUIIfUfDkfMQQYC2SVZ9pyWSYPY7uUudp7oUvUzg/Fs2aM52MeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIXv+Zu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCB606A327;
	Wed, 21 Oct 2026 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzIXv+Zu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE61F000C6;
	Wed, 21 Oct 2026 22:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623534;
	bh=bGFxZD6xNVodRu361F4ICxHoOfRqAEYXJii33uzdyvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hzIXv+Zu1/8oGU9nyhzCDIejAAqX9ltT4VjZ6i36ttUTO7XeBlyY6kS2E00ny9trN
	 +naXuQmRnNKIEuRHfCQYL33YuTpVw6EG6aGTpSA19At3l1ECMPwuXmr0Oywana0mVM
	 Y9m4HCL+4AyD/rpXuzKNdefM7JQlyv+xzo0y7BVJ1rvpW7bZ7di9775GgKll67j2qD
	 8sBgtruRFhB1srkk7KbfuJGrT21vw1wVnV0Jnn7+1xIC0SLt+X5dJWDW+VLIVjK+K7
	 DnQarWZJQXXjp22lIGWXaPYOMMllZsBpA/C6X5gH0lruHBuHAJhY/mnJGcMtJ3MPfV
	 AGe2VUtCuQlgQ==
Subject: Re: [PATCH v3 09/10] can: peak_usb: unregister the netdev before
 dev_free() on probe failure
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 22:58:53 +0000
Message-ID: <179262353328.3131.14088207507034751765@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
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

Critical: 0 · High: 1 (2) · Medium: 0 (2) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the same close-after-free use-after-free is
  still reachable when dev_init() fails on PCAN-USB FD channel 0.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  peak_usb_create_dev() makes the netdev visible with register_candev()…
- [High] This problem wasn't introduced by this patch, but the PCAN-USB
  (pcan_usb.c) asynchronous restart is never drained before the device…
- [Medium] On PCAN-USB FD all channels share one command buffer
  (pdev->cmd_buffer_addr is copied from channel 0 in pcan_usb_fd_init()).
- [Medium] If the registered netdev is opened between dev_init() and
  probe's unconditional dev_set_bus(dev, 0) in peak_usb_create_dev(),…
- [Low] The comment above pcan_usb_pro_free() still says it is 'called
  when PCAN-USB Pro adapter is unplugged'.
- [Low] On PCAN-USB FD and Pro, the first channel's dev_init() sends
  drv_loaded(1) and sets the LED.

--

can: peak_usb: unregister the netdev before dev_free() on probe failure

This patch reorders the adap_dev_free error path in peak_usb_create_dev()
so that unregister_candev() runs before the adapter's dev_free() callback,
as peak_usb_disconnect() already does. The goal is to stop ndo_stop from
touching the shared interface object and the PCAN-USB FD command buffer
after dev_free() has released them when dev_set_bus(dev, 0) fails.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 4c08656e77681..981168fead927 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -1039,8 +1039,13 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	 */
>  	peak_usb_stop_rx(dev->prev_siblings);
>  
> +	/* as in peak_usb_disconnect(), unregister the netdev before calling
> +	 * dev_free(): closing it may still use what dev_free() releases.
> +	 */
> +	unregister_candev(netdev);
>  	if (dev->adapter->dev_free)
>  		dev->adapter->dev_free(dev);

[Severity: Low]
This is a pre-existing issue, but the comment above pcan_usb_pro_free() in
pcan_usb_pro.c still mentions only unplug:

/*
 * called when PCAN-USB Pro adapter is unplugged
 */
static void pcan_usb_pro_free(struct peak_usb_device *dev)

This probe failure path also reaches it, and it can kfree() the shared
pcan_usb_pro_interface here. The FD version, pcan_usb_fd_free(), already
says "called when the USB adapter is unplugged, or when probing a sibling
fails".

Could the Pro comment be updated to match?

> +	goto lbl_restore_intf_data;

[Severity: Low]
This isn't a bug introduced by this patch, but on PCAN-USB FD and Pro the
first channel's dev_init() has already told the firmware that the driver
is loaded:

pcan_usb_fd_init()
	err = pcan_usb_fd_drv_loaded(dev, 1);

pcan_usb_pro_init()
	err = pcan_usb_pro_drv_loaded(dev, 1);

Only dev_exit() sends the matching drv_loaded(0) and turns the LEDs off.
This path, the lbl_unregister_candev path and peak_usb_disconnect() never
call dev_exit().

After a failed probe, does the adapter stay connected in the "host driver
loaded" state with no driver bound?

>  
>  lbl_unregister_candev:
>  	unregister_candev(netdev);

[Severity: High]
This handles the dev_set_bus() failure. Can the same close-after-free
still happen when dev_init() fails on the first PCAN-USB FD channel?

That failure still ends up here:

peak_usb_create_dev() {
    ...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
	}
    ...
}

On its error path, pcan_usb_fd_init() frees both shared objects and leaves
the pointers set:

pcan_usb_fd_init() {
    ...
		err = pcan_usb_fd_drv_loaded(dev, 1);
		if (err) {
			...
			goto err_out_2;
		}
    ...
err_out_2:
	kfree(pdev->cmd_buffer_addr);
err_out_1:
	kfree(pdev->usb_if);
err_out:
	return err;
}

The netdev is registered before dev_init() runs, and the device can stall
the pcan_usb_fd_drv_loaded() request until it times out. If the interface
is brought up during that window, pcan_usb_fd_start() increments
usb_if->dev_opened_count. After the free, unregister_candev() here then
runs:

unregister_candev()
  peak_usb_ndo_stop()
    peak_usb_unlink_all_urbs()
    pcan_usb_fd_stop()
      if (pdev->usb_if->dev_opened_count == 1)
          pcan_usb_fd_set_options()  <- command built in freed cmd buffer
      pdev->usb_if->dev_opened_count--;
    pcan_usb_fd_set_bus(dev, 0)      <- freed cmd buffer written again

pcan_usb_fd_send_cmd() checks PCAN_USB_STATE_CONNECTED, but that bit is
still set for dev on this path, so the sends go ahead. The RX URBs
submitted by the open also keep decoding through the freed usb_if until
peak_usb_unlink_all_urbs() kills them.

The commit message describes this same scenario, and no later patch in
the series touches this path.

Would it be better to keep dev_init() from freeing state the netdev can
still reach? Another option is to register the netdev only after
dev_init() and dev_set_bus(dev, 0) succeed.

[Severity: High]
This isn't a bug introduced by this patch, but register_candev() runs
before dev_init() and dev_set_bus(dev, 0). What stops an open from racing
with the half-initialized device? The only check in peak_usb_ndo_open() is:

	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return -ENODEV;

That bit is already set before registration.

On PCAN-USB Pro, pcan_usb_pro_init() sets pdev->usb_if only at the very
end. Before that it sends two pcan_usb_pro_send_req() INFO requests and
calls pcan_usb_pro_drv_loaded(), and the device can stall each of them:

pcan_usb_pro_init() {
    ...
	pdev->usb_if = usb_if;
    ...
}

Suppose the bitrate is set and the interface brought up during that
window:

peak_usb_ndo_open()
  peak_usb_start()
    pcan_usb_pro_start()
      if (pdev->usb_if->dev_opened_count == 0)  <- usb_if still NULL

Would this be a NULL pointer oops?

FD has the same problem with a shorter window. pcan_usb_fd_set_bittiming_slow(),
pcan_usb_fd_start() and pcan_usb_fd_send_cmd() dereference
pcan_usb_fd_cmd_buffer(dev) and pdev->usb_if before pcan_usb_fd_init()
assigns them.

[Severity: Medium]
This is also pre-existing and comes from the same register-before-init
ordering. Suppose the netdev is opened after dev_init() but before this
probe-time call in peak_usb_create_dev():

	/* set bus off */
	if (dev->adapter->dev_set_bus) {
		err = dev->adapter->dev_set_bus(dev, 0);

This puts the controller back in reset mode (PUCAN_CMD_RESET_MODE on FD,
SETBUSACT 0 on Pro). If the command succeeds, probe returns 0 and the
netdev stays up: can.state is CAN_STATE_ERROR_ACTIVE,
PCAN_USB_STATE_STARTED is set and the TX queue is running.

Does that leave an interface that neither sends nor receives until it is
taken down and brought up again?

[Severity: Medium]
This is a pre-existing issue, but on PCAN-USB FD every channel shares one
command buffer, copied from channel 0 in pcan_usb_fd_init():

		pdev->cmd_buffer_addr = ppdev->cmd_buffer_addr;

While probe initializes channel N, it writes into that buffer without RTNL
or any other lock. The writes come from pcan_usb_fd_set_clock_domain() and
pcan_usb_fd_set_can_led(), and then from pcan_usb_fd_set_bus(dev, 0) in
peak_usb_create_dev().

Meanwhile, a sibling that is already registered can be opened, configured
or driven through ethtool under RTNL, and it writes the same buffer, for
example:

pcan_usb_fd_start()
  pcan_usb_fd_set_filter_std()

Can these commands interleave, so that the adapter receives a corrupted
command list?

[Severity: High]
This isn't a bug introduced by this patch either. On PCAN-USB (pcan_usb.c),
the asynchronous restart doesn't seem to be drained before free_candev(),
either on this error path or in peak_usb_disconnect().

pcan_usb_restart_async() submits an unanchored URB with pdev as its
context:

	usb_fill_bulk_urb(urb, dev->udev,
			usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
			buf, PCAN_USB_CMD_LEN,
			pcan_usb_restart_pending, pdev);

	return usb_submit_urb(urb, GFP_ATOMIC);

The completion arms a timer without checking urb->status:

pcan_usb_restart_pending()
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));

The timer callback then touches the device:

pcan_usb_restart()
  peak_usb_restart_complete(dev)
	dev->can.state = CAN_STATE_ERROR_ACTIVE;
	netif_wake_queue(dev->netdev);

Nothing in pcan_usb.c calls timer_delete() or timer_shutdown() on
restart_timer, and the adapter has no dev_stop or dev_free callback.
peak_usb_ndo_stop() only kills the RX and TX anchors, and close_candev()
only cancels the CAN core restart work.

Suppose a bus-off restart (restart-ms, or "ip link set canX type can
restart") is still in flight when the device is unplugged or probe fails.
Can the URB completion or the timer then run on the netdev private area
after free_candev() has freed it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e%40peak-system.fr
