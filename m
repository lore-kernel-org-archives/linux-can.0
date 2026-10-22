Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628966;
	b=A7qT6Fu5Bt8SvmApTGBBzvg+mN83x7nYjcL5KDWtfnKNR6TajhBmzdLVl3ykuZ+RodSv
	 diQTg+RhgkkqKRDyhDIWWqdzEX1T6mmonYwGD/uxNwo1cIoP7c+zYq9oyzIg3xlMze17s
	 7ZqO2e29FNizuK5k7OQn2B9+6KyS8/it31HwB4MvEm8kXQzKu+46k6TDbYH/x59mT1dkE
	 tQyn2ujuc3GKgM/vhniIMIe9BARzJqvZtY4BIKGSoDHEiGrCioSuqUMssFivyvncu3bD7
	 /bQKUYg8MH3OKn+pzY8AFQH948KBtZIWlMOgx0OzOeHHRc9GKAr1XVhA1KDoqiMgGow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628966;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PG5RbR1n+cbxO8hZGR07lGQHqOdeSb6gc0bQh0IK4CA=;
	b=lHcuQwqo4Gvqo2yyT4DYuxS+4m9+peVi4HQ3TmCDmFcQlM3hUaZyh/z4W4QUugGCnwf7
	 u88ngn5UNnGJ7r8AEsW8iJD1EJu4d2rVnL9KXqwx+FBciVQKCK8IxJj0q/B13OBh1H+XW
	 8UBFLvdUm75XSUzU1so2hXoQBBpk9KQZ/KPzubmZyGCi7wYP8C/NEd9Pg30+Zgo9xXrJt
	 rhgqnjtMvjWCfl4gTkgYFtb8zS74v2DdNgltL5XZ0eThBxmaEjdGiEclfgv+rpnEG48xE
	 GkVTjnzJ+sCRm7HMq3TjfYBbbZhXDbaliXYGX4Z4moTYOofFeDz/U34iHLIMqgCesTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZOQdrQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113ED606A319;
	Thu, 22 Oct 2026 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZOQdrQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A741F000C1;
	Thu, 22 Oct 2026 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628965;
	bh=PG5RbR1n+cbxO8hZGR07lGQHqOdeSb6gc0bQh0IK4CA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BZOQdrQ3bAhmrSZpRwebQq2UaCIsK8WvNXDldoaqTwDbZffXILca7prCNe2ybpbg8
	 vzKIW8ueW7MMjHG0t6xlB1YXpjkWv49mayQR221/ib1Ub93pF0JVxEDmbp9NsPU96n
	 lTJHRvd51ef7t8gQwdJv25QE6QVcagY7S2+XmzuZM6kndyuGY9+LqKeH1T/hN+1ubc
	 Gfb3B772F3xV5y14yLFbCk96qY0mqdp7lXZU6BXbYHJGTQnRlaudUPBREzWy4vFffN
	 W6GIKLWM/M46c4X7GW3Kx/VaHr5x2ycaCdcnVZwFWjMlpB+MoWcAuOFi/ddFGTyAVI
	 Su4W3ZAitqAZA==
Subject:
 Re: [PATCH v4 06/10] can: peak_usb: harden channel handling in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 00:29:24 +0000
Message-ID: <179262896455.3131.9030339642297311595@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v4-6-bfbde81f8bab@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v4-6-bfbde81f8bab@peak-system.fr>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At the target commit, peak_usb_create_dev() calls
  register_candev() before dev_init() and dev_set_bus().

Pre-existing issues:
- [High] This is the same NULL-slot dereference this commit fixes for
  PCAN-USB FD, but in the sibling PCAN-USB Pro driver, which the commit…
- [High] Asynchronous restart URBs are not tracked, so one can outlive a
  channel freed on the probe-rollback path.
- [Low] On the probe-failure path the device is still attached.

--

can: peak_usb: harden channel handling in PCAN-USB FD

This patch makes the PCAN-USB FD decoders check the record's channel
number against the adapter's controller count and reject records for
empty channel slots. It also clears a channel's slot in pcan_usb_fd_free().
It adds peak_usb_stop_rx(), which stops RX on the siblings already created
when a channel probe fails, and on all channels in peak_usb_disconnect().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index a1b17e1e6fea6..4c08656e77681 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -904,6 +907,22 @@ int pcan_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info
>  	return 0;
>  }
>  
> +/*
> + * stop RX on dev and on all its previous siblings: clearing CONNECTED makes
> + * peak_usb_ndo_open() fail, then poisoning the RX anchors waits for running
> + * completion handlers and makes any later submission on them fail.
> + */
> +static void peak_usb_stop_rx(struct peak_usb_device *dev)
> +{
> +	struct peak_usb_device *d;
> +
> +	for (d = dev; d; d = d->prev_siblings)
> +		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);

[Severity: Low]
This is a pre-existing issue, but the adapter is still attached on the
probe failure path. Once CONNECTED is cleared here, pcan_usb_fd_send_cmd()
returns success without sending anything:

pcan_usb_fd_send_cmd() {
	...
	/* usb device unregistered? */
	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;
	...
}

Later, peak_usb_disconnect()->unregister_candev()->peak_usb_ndo_stop() sends
the calibration-off command (through pcan_usb_fd_stop()) and the bus-off
command (through dev_set_bus(dev, 0)). Are both of these dropped silently?

If so, a channel 0 that was already opened stays bus-on. Meanwhile the
driver sets dev->can.state to CAN_STATE_STOPPED and decrements
dev_opened_count.

Before this patch, peak_usb_disconnect() cleared CONNECTED just before
unregister_candev() for each channel, so these commands were already being
dropped the same way.

> +
> +	for (d = dev; d; d = d->prev_siblings)
> +		usb_poison_anchored_urbs(&d->rx_submitted);
> +}
> +

[ ... ]

> @@ -1014,6 +1033,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	return 0;
>  
>  adap_dev_free:
> +	/* the whole interface is released when probing a channel fails:
> +	 * stop RX on the channels already created, since their RX URBs may
> +	 * carry records for this one.
> +	 */
> +	peak_usb_stop_rx(dev->prev_siblings);
> +
>  	if (dev->adapter->dev_free)
>  		dev->adapter->dev_free(dev);
>  

[Severity: High]
At this commit, peak_usb_create_dev() still calls register_candev() before
dev_init() and dev_set_bus():

	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);
	...
	if (dev->adapter->dev_set_bus) {
		err = dev->adapter->dev_set_bus(dev, 0);
		if (err)
			goto adap_dev_free;
	}

If dev_set_bus() fails, the netdev of the failing channel may already be
open, with its own RX URBs in flight. peak_usb_stop_rx(dev->prev_siblings)
stops only the earlier siblings, not dev.

For channel 0, dev_free() is pcan_usb_fd_free(). It frees pdev->usb_if and
pdev->cmd_buffer_addr, because no siblings exist yet. Then:

lbl_unregister_candev:
	unregister_candev(netdev);
	  peak_usb_ndo_stop()
	    peak_usb_unlink_all_urbs()
	    pcan_usb_fd_stop()
	      pdev->usb_if->dev_opened_count--;

Could this channel's RX completions, which are still running and decode
through pdev->usb_if, touch the freed usb_if? pcan_usb_fd_stop() above
would touch it too. Does this path need peak_usb_stop_rx(dev), so that the
failing channel itself is stopped as well?

The order of dev_free() before unregister_candev() predates this patch. A
later patch in this series, "can: peak_usb: register the netdev only once
the channel is set up", moves register_candev() after dev_init(),
dev_set_bus() and dev_get_can_channel_id(). It also drops
unregister_candev() from the error path, and its commit message describes
this use-after-free.

> @@ -1038,13 +1063,14 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  	struct peak_usb_device *dev;
>  	struct peak_usb_device *dev_prev_siblings;
>  
> -	/* unregister as many netdev devices as siblings */
> +	/* stop RX on all channels before unregistering and freeing them */
> +	peak_usb_stop_rx(usb_get_intfdata(intf));
> +
>  	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
>  		struct net_device *netdev = dev->netdev;
>  		char name[IFNAMSIZ];
>  
>  		dev_prev_siblings = dev->prev_siblings;
> -		clear_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
>  		strscpy(name, netdev->name, IFNAMSIZ);
>  
>  		unregister_candev(netdev);

[Severity: High]
This isn't a bug introduced by this patch, but this path is now being
hardened for the probe error case. Can an asynchronous restart URB outlive
the peak_usb_device freed here?

pcan_usb_fd_restart_async() submits the restart URB with dev as its
context. It does not anchor the URB or take a reference on dev.
pcan_usb_pro_restart_async() works the same way:

	usb_fill_bulk_urb(urb, dev->udev,
			  usb_sndbulkpipe(dev->udev, fw_info->cmd_out_ep),
			  buf, pc - buf,
			  pcan_usb_pro_restart_complete, dev);

	/* and submit it. */
	return usb_submit_urb(urb, GFP_ATOMIC);

On a two-channel adapter, can0 can be up while channel 1 is being probed,
with a restart pending from restart-ms or from a manual restart. If the
channel 1 probe then fails:

peak_usb_probe()
  peak_usb_disconnect()
    peak_usb_stop_rx()              poisons rx_submitted only
    unregister_candev()
      peak_usb_ndo_stop()
        close_candev()              cancels restart_work only
        peak_usb_unlink_all_urbs()  kills rx_submitted and tx_submitted
    free_candev()

The USB core has not disabled the interface on this path. When the restart
URB completes later:

pcan_usb_pro_restart_complete()
  peak_usb_restart_complete(urb->context)
    dev->can.state = CAN_STATE_ERROR_ACTIVE;
    netif_wake_queue(dev->netdev);

Would this write to the freed dev and its net_device?

[ ... ]

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 15d275d6a1277..eee5b5eaa247d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -536,10 +537,16 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
>  
> -	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware */
> +	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
> +		return -EINVAL;
> +
> +	dev = READ_ONCE(usb_if->dev[pucan_msg_get_channel(rm)]);
> +
> +	/* reject records for a channel that is not (or no longer) set up */
> +	if (!dev)
> +		return -EINVAL;
>  
> -	dev = usb_if->dev[pucan_msg_get_channel(rm)];
>  	netdev = dev->netdev;
>  

[Severity: High]
This is a pre-existing issue, but the sibling PCAN-USB Pro driver has the
same NULL slot dereference, and this patch doesn't change it. In
pcan_usb_pro.c, pcan_usb_pro_handle_canmsg() only checks the table size:

	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
		return -EINVAL;

	dev = usb_if->dev[ctrl_idx];
	netdev = dev->netdev;

pcan_usb_pro_handle_error() does the same thing. The channel 1 slot stays
NULL until pcan_usb_pro_init() runs for that channel:

	usb_if->dev[dev->ctrl_idx] = dev;

By then, channel 0's RX URBs on the shared bulk-in endpoint may already be
running. pcan_usb_pro_free() never clears the slot either.

Can a channel 1 record that arrives in that window cause a NULL
dereference in URB completion context?

A later patch in this series, "can: peak_usb: reject records for unset
channels in PCAN-USB Pro", adds the READ_ONCE() and the NULL slot check to
both handlers. It also publishes the slot with smp_store_release() in
pcan_usb_pro_init() and clears it with WRITE_ONCE() in pcan_usb_pro_free().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab%40peak-system.fr
