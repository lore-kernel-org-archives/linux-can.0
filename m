Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640201;
	b=GxFokTK6CIh3hggSMVo8gqw3iWz4zrCJe1Zx8Nz0+0xRBnU5AG+hAukoNIcC2R7bdqE7
	 rhzl2RaLROJvWbnHw9Qk0zlBqNg3JSiMYYQBTqCUnpRDGubLRhWax4meln3GxT38lmqjT
	 JPrFEYaD7APXdisW8t2/ORnrjJGeu+gHCz6HawvaUxwbL9eAxghCRPNGuXan+a+lfKfQU
	 E8PFPudMExEigoKTi7ISSYxfVUzz8uIEGDacSG4FpOOILpfpBq2kKIqbbW9Dx7FufUfcx
	 fBXFTetzztZAmaFoEJVGnBjRbou2CzVMgjAjYlTqEjQz/sumrj1RuhhUHwxxC6NZMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640201;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xQrKEfVfLJ4GWPWqI9/8PFh1dCHBfo7e7Bd+x3ArwCg=;
	b=OvFznFJ4MywJAed6Qgt7kwTfJ5ettrD1DTPNuvFribBmFVahzKhiufth1rOjM2TyAvvv
	 pRQXIBtbrmDabTKoxYCNnCtPrHdA4iMd+dauEWN/NRnCnJMEWWOeiwJRJl6HjSqElpdye
	 KeVl57+lxVTF8EqHXnKoOCIqp81MTegp5AYVF+KBeiFQSq4bH0iOvzNLKbdD8IxH6LZ+g
	 qqes/8V8W59aTU0wmZByP8P4xruLUG38YgT0g/uBevvpS/FU3pZGZMXivZg070xE/EKE9
	 cVHZFA3bHosLnxlx04HZNi+YZyRg/g66NKcnAMFKuQCjzHh3kHHRhzoXPg10+Xeik/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LE2Bpa7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091E606A321;
	Thu, 22 Oct 2026 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LE2Bpa7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC61F000C1;
	Thu, 22 Oct 2026 03:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640201;
	bh=xQrKEfVfLJ4GWPWqI9/8PFh1dCHBfo7e7Bd+x3ArwCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LE2Bpa7OzmL8YvlhPF+5eUbuao3SNlzBFL1MHZ8CwZEYgqDZ5S4bOW+1gzC1+Aasr
	 ucnuz6KrRQNZ+LN34VVXHxPjaxz1VoXtS/6tQBQjihdd2c5sLLqz2E7PuKO/P1d5sl
	 8CzraNQ9EOE45Wfn2PXRNSqe7hgQoQzhv7p7rgwEH9HYQSGufHDNm0vzeFf2N0JRiE
	 7Mp6T5BSlrejWXF8x19Ku9Bo9FWJLbBkj4OxKq1JGlbdBow2FysCZQPPbbx4qbIfj4
	 Daur3Qo/Kkb5Bg91DwVHjapxD+8Wp8VmqEE/ztTXHSyIawW4YUJy3NjF+yBEm3a9Or
	 mVS4ZJ0m0LtrA==
Subject: Re: [PATCH v5 09/10] can: peak_usb: register the netdevs only once
 all channels are set up
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 03:36:40 +0000
Message-ID: <179264020017.3131.2617691177294766125@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v5-9-a62b35b867f0@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v5-9-a62b35b867f0@peak-system.fr>
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

- [Low] The patch moves register_candev() from peak_usb_create_dev() to
  the end of peak_usb_probe().
- [Low] peak_usb_disconnect() is now also the probe-failure cleanup for
  netdevs that were never registered.

Pre-existing issues:
- [High] Channel teardown never drains asynchronous restart URBs and
  never cancels the legacy PCAN-USB restart_timer before freeing the…
- [High] pcan_usb_pro_handle_canmsg() sets can_frame->len = rx->len &
  0x0f, a device-controlled value from 0 to 15.
- [Medium] pcan_usb_get_can_channel_id() declares 'u8
  args[PCAN_USB_CMD_ARGS_LEN];' with no initializer.
- [Medium] peak_usb_disconnect() calls peak_usb_stop_rx() first, which
  clears PCAN_USB_STATE_CONNECTED on every channel, and only then calls…
- [Low] Channel 0's dev_init() (pcan_usb_fd_init()/pcan_usb_pro_init())
  sends drv_loaded(1), sets the clock domain and sets the LEDs to their…

--

can: peak_usb: register the netdevs only once all channels are set up

This commit moves register_candev() from peak_usb_create_dev() into
peak_usb_probe(). The netdevs are now registered only after every channel
of the interface has been initialized. peak_usb_disconnect() unregisters
only the netdevs flagged with the new PCAN_USB_STATE_REGISTERED bit, and
PCAN-USB now logs a failed channel id read with dev_err().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 4c8cfed31634a..c7246465dcc7b 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -390,9 +390,12 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
>  	int err;
>  
>  	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
> +	/* explicit use of dev_xxx() instead of netdev_xxx() here: this is
> +	 * also called during probe, before the netdev is registered.
> +	 */
>  	if (err)
> -		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
> -
> +		dev_err(dev->netdev->dev.parent,
> +			"getting can channel id failure: %d\n", err);

[Severity: Low]
The comment says this also runs during probe, before the netdev is
registered. The helpers this function calls still log through
netdev_err(), though. Was the conversion meant to stop here?

pcan_usb_get_can_channel_id()->pcan_usb_wait_rsp() still does:

	if (err)
		netdev_err(dev->netdev,
			"waiting rsp f=0x%x n=0x%x failure: %d\n", f, n, err);

pcan_usb_send_cmd() does the same with "sending cmd ...". The same holds
for pcan_usb_fd_send_cmd() in pcan_usb_fd.c, and for
pcan_usb_pro_send_cmd(), pcan_usb_pro_wait_rsp() and
pcan_usb_pro_send_req() in pcan_usb_pro.c. All of them are reached from
dev_init(), dev_set_bus(dev, 0) and dev_get_can_channel_id() in
peak_usb_create_dev().

register_candev() now runs later, in peak_usb_probe(), so netdev->name
still holds the "can%d" template at this point. __netdev_printk() will
print these messages as "(unnamed net_device) (uninitialized)". On
PCAN-USB, a failed channel id read would now print an
"(unnamed net_device) (uninitialized): waiting rsp ..." line just before
the new dev_err() line.

Should those helpers be converted as well?

>  	else
>  		*can_ch_id = args[0];

[Severity: Medium]
This is a pre-existing issue, not introduced by this patch, but can
args[0] be read here without ever being initialized?

args[] has no initializer. When the device is no longer connected,
pcan_usb_wait_rsp() returns 0 without filling it:

	/* usb device unregistered? */
	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;

peak_usb_disconnect() clears PCAN_USB_STATE_CONNECTED through
peak_usb_stop_rx() before calling unregister_candev(), so the netdev is
still registered during that window. An ETHTOOL_GEEPROM request that lands
there would go through peak_usb_get_eeprom()->dev_get_can_channel_id().
It would copy the uninitialized stack byte to userspace and cache it in
dev->can_channel_id.

The probe-time call this patch keeps runs with CONNECTED set, so it is
not affected.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 4c08656e77681..a12ee6ec71e68 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -1073,7 +1055,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  		dev_prev_siblings = dev->prev_siblings;
>  		strscpy(name, netdev->name, IFNAMSIZ);
>  
> -		unregister_candev(netdev);
> +		if (test_bit(PCAN_USB_STATE_REGISTERED, &dev->state))
> +			unregister_candev(netdev);

[Severity: Low]
peak_usb_disconnect() now also cleans up netdevs that were never
registered. The PCAN_USB_STATE_REGISTERED test only guards
unregister_candev(). The name is still copied and printed for every
sibling:

		strscpy(name, netdev->name, IFNAMSIZ);
		...
		dev_info(&intf->dev, "%s removed\n", name);

alloc_candev() leaves the "can%d" template in netdev->name until
register_netdevice() expands it. Will each unregistered channel then log
a literal "can%d removed"? That would happen when peak_usb_create_dev()
fails, or when register_candev() fails partway through the loop in
peak_usb_probe().

[Severity: Medium]
This isn't a bug introduced by this patch, but does the bus-off command
sent on close ever reach the device on this path?

peak_usb_disconnect() starts with:

	/* stop RX on all channels before unregistering and freeing them */
	peak_usb_stop_rx(usb_get_intfdata(intf));

This clears PCAN_USB_STATE_CONNECTED on every channel. For an opened
channel, unregister_candev() then calls peak_usb_ndo_stop(), which sends
dev_stop() and dev_set_bus(dev, 0).

Once CONNECTED is clear, pcan_usb_send_cmd(), pcan_usb_wait_rsp(),
pcan_usb_fd_send_cmd(), pcan_usb_pro_send_cmd() and
pcan_usb_pro_send_req() all return 0 without sending anything. Even so,
ndo_stop still sets dev->can.state = CAN_STATE_STOPPED.

The adapter can stay attached here: on a sysfs unbind, or on the probe
error path when a later register_candev() fails after an earlier sibling
was registered and opened. Wouldn't its CAN controller then stay bus-on
with no driver bound?

>  
>  		kfree(dev->cmd_buf);
>  		dev->next_siblings = NULL;

[ ... ]

> @@ -1108,13 +1092,40 @@ static int peak_usb_probe(struct usb_interface *intf,
>  
>  	for (i = 0; i < peak_usb_adapter->ctrl_count; i++) {
>  		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
> +		if (err)
> +			goto lbl_disconnect;
> +	}
> +

[ ... ]

> +	for (; dev; dev = dev->next_siblings) {
> +		err = register_candev(dev->netdev);
>  		if (err) {
> -			/* deregister already created devices */
> -			peak_usb_disconnect(intf);
> -			break;
> +			dev_err(&intf->dev, "couldn't register CAN device: %d\n",
> +				err);
> +			goto lbl_disconnect;
>  		}

[Severity: Low]
This is a pre-existing issue, but the hardware state set by dev_init()
does not seem to be undone on this path.

On PCAN-USB FD and Pro, channel 0's dev_init() (pcan_usb_fd_init() /
pcan_usb_pro_init()) sends drv_loaded(1) and sets the clock domain and
the LEDs. peak_usb_disconnect() only calls dev_free(), which frees memory
and sends no command.

The matching drv_loaded(0) and LED shutdown are in dev_exit()
(pcan_usb_fd_exit() / pcan_usb_pro_exit()). dev_exit() is only called
from peak_usb_do_device_exit() at module unload.

Is it intended that a failed probe leaves the adapter in its "driver
loaded" firmware state? With this patch, a register_candev() failure,
including for channel 0 on a single-channel adapter, also reaches this
teardown after the firmware has been initialized. A normal sysfs unbind
leaves the adapter in the same state.

> +		set_bit(PCAN_USB_STATE_REGISTERED, &dev->state);

[ ... ]

> +	return 0;
> +
> +lbl_disconnect:
> +	/* unregister (if needed) and free already created devices */
> +	peak_usb_disconnect(intf);
> +
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this teardown lead to
a use-after-free? Neither this error path nor peak_usb_disconnect()
drains the asynchronous restart URBs or cancels the PCAN-USB
restart_timer before free_candev().

On PCAN-USB, the restart URB completion always arms the timer, whatever
the URB status:

static void pcan_usb_restart_pending(struct urb *urb)
{
	struct pcan_usb *pdev = urb->context;

	/* the PCAN-USB needs time to restart */
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
	...
}

Nothing in the driver calls timer_delete_sync() or timer_shutdown_sync()
on restart_timer. On unplug or unbind, the endpoint flush completes the
URB with -ESHUTDOWN, which arms the timer. peak_usb_disconnect() then
frees the netdev, and the timer_list lives in that netdev's private area.
Up to 10ms later, this would run on freed memory:

pcan_usb_restart()
  peak_usb_restart_complete(dev)
    netif_wake_queue(dev->netdev)

On Pro and FD, pcan_usb_pro_restart_async() and
pcan_usb_fd_restart_async() submit unanchored URBs with the channel
pointer as urb->context. On this probe error path the USB core has not
disabled the interface.

Suppose register_candev() fails for a later channel while an earlier,
registered and opened channel has a restart in flight. Could
pcan_usb_pro_restart_complete()->peak_usb_restart_complete(urb->context)
then run after free_candev()?

[Severity: High]
This is a pre-existing issue in pcan_usb_pro.c and is not related to the
code changed here. Can pcan_usb_pro_handle_canmsg() copy past the end of
the record and past can_frame->data[]?

	can_frame->len = rx->len & 0x0f;
	...
		memcpy(can_frame->data, rx->data, can_frame->len);

The length comes from the device, ranges from 0 to 15, and is not checked
against CAN_MAX_DLEN or the payload size of the record type.
pcan_usb_pro_decode_buf() only checks the fixed record size:

		if (rec_ptr + sizeof_rec > msg_end) {

RXMSG0 records (12 bytes, no payload) and RXMSG4 records (16 bytes) both
reach the same handler:

	[PCAN_USBPRO_RXMSG4] = sizeof(struct pcan_usb_pro_rxmsg) - 4,
	[PCAN_USBPRO_RXMSG0] = sizeof(struct pcan_usb_pro_rxmsg) - 8,

A broken or malicious adapter could send such a record with a large
length nibble. The memcpy would then read beyond the record:

- into stale bytes of the non-zeroed kmalloc() RX buffer allocated in
  peak_usb_start(), or
- past the end of that buffer, when the record sits at its end.

With len > 8 it would also write up to 7 bytes past can_frame->data[8].
Frames with len <= 8 that carry this data go to CAN_RAW readers through
netif_rx().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0%40peak-system.fr
