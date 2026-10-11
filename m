Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D1B652E;
	Sun, 11 Oct 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694411; cv=none; b=GD1Ho+9sx+KDm+KJY95rBkmS8H1D37tts5cMx4XArRkxkRzqQw8bFUk2zXPbgvHX0UEPY47WNVeZQKCdOI1etFfDSwOaAs7//E9GKgzd7xY3mjPFOiamgTZ8QKWd6FC3beUigEqLvYuxmwqE0+fMavxXuoD77L0maMVdcdkrjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694411; c=relaxed/simple;
	bh=T1IdeGOzVUmyCu079hLAkly4QAuwId3NhgwQEODtFKY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tc44Ugs8pNjJwnFwMkV3nqvZ2nG/Hg1/9+g4tFpe3fzCeq6Czz8crL5aafwf2uLOiyXl/kzhvQbW+c9SeRj3Kgs8ruMBjlRGOKdDgo3ir09oZNPrYyxGxX54rJnZZXUiSWY+7wJ3cU7YmdDn0veU8zKduHCUTMpF5D3aW+qH/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ3F/ZOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ3F/ZOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6149F1F0089B;
	Sun, 11 Oct 2026 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791694409;
	bh=lAayhNW0wrjJpeuPnhG3OtyglEO0X3YXuhV9lnn/dwo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SJ3F/ZOJ/lSGE2dUgoV7WqK9NqsahiYeXfmXzUcZKFMiDGQmIzZoGK3jMZnmjVTci
	 xT6bsSRypKGPtTxM7uywjRWmoWu56jqISKN49KbE8n7Wedz9HA9meDvTnB0rlLAvEi
	 /WkjSS8EG9+oBMnVZIqTFvOlgz4Um1uZAclM+bzct6lLXY/hH0S98fVqxYoZfu6v6n
	 YXbyuAXHxgptcvWoIbf+dW6WJmcJ0QVbf3zsknzjU0ZUxNn+ZTbqv5uaPaYq7Bf3kh
	 C6QdHzoe81T6CYUch4FH1W6N+kUroHqThwvFAVyUtDCrGH3a17JWkffCy+a+hmjwtR
	 8CWHBpgXmvxBg==
Subject:
 Re: [PATCH v2 4/5] can: peak_usb: validate channel numbers in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 11 Oct 2026 04:53:28 +0000
Message-ID: <179169440890.1406898.17734946656779049604@kernel.org>
In-Reply-To:
 <20261009-canfd_check_channel_idx-v2-4-f7b772929791@peak-system.fr>
References:
 <20261009-canfd_check_channel_idx-v2-4-f7b772929791@peak-system.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 2 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `if (!dev) return -EINVAL;` guards in the four FD
  decoders are commented as rejecting "records targeting a valid channel…
- [Medium] The patch makes a change to the shared core teardown path that
  its commit message does not mention.
- [Medium] The new comments in peak_usb_disconnect() claim that after the
  usb_kill_anchored_urbs() loop "No decode_buf() callback can access…
- [Low] The commit message says the patch "prevents potential out-of-
  bounds accesses".
- [Low] The new `if (!dev)` checks in
  pcan_usb_fd_decode_canmsg/status/error/overrun exist for the case…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sibling
  PCAN-USB Pro driver has the same NULL-slot dereference that the patch…
- [High] This problem wasn't introduced by this patch, but the error path
  in peak_usb_create_dev() frees the shared FD interface object while…
- [Medium] This problem wasn't introduced by this patch, but
  peak_usb_create_dev() calls register_candev(netdev)…
- [Medium] This problem wasn't introduced by this patch, but when a
  decoder returns an error, peak_usb_read_bulk_callback()…

--

can: peak_usb: validate channel numbers in PCAN-USB FD

The patch replaces the ARRAY_SIZE(usb_if->dev) checks in the four
PCAN-USB FD decoders with a check against the adapter ctrl_count. It also
adds a NULL check on the usb_if->dev[] slot and returns -EINVAL instead
of -ENOMEM. Finally, it adds a loop to peak_usb_disconnect() that kills
all anchored RX URBs before any netdev is unregistered.

> This prevents potential out-of-bounds accesses when handling
> unexpected or corrupted messages received from PCAN-USB FD family
> devices.

[Severity: Low]
Is "out-of-bounds accesses" the right description? The commit in the
Fixes: tag (a6921dd524fe) already added ARRAY_SIZE(usb_if->dev) checks to
all four decoders, so the index could not go past the array.

ARRAY_SIZE(usb_if->dev) is PCAN_USB_MAX_CHANNEL, which is 2. The
pcan_usb_fd and pcan_usb_chip adapters use ctrl_count =
PCAN_USBFD_CHANNEL_COUNT, which is 1.

On those adapters a record with channel 1 passed the old check. It then
reached usb_if->dev[1], which is never assigned and so stays NULL from the
kzalloc. That NULL was dereferenced through dev->netdev or
container_of(dev, ...)->bec.

Would it be more accurate to describe this as a NULL pointer dereference?

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 55aad01cd8cac..751cd52cb5486 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -1038,7 +1038,17 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  	struct peak_usb_device *dev;
>  	struct peak_usb_device *dev_prev_siblings;
>  
> -	/* unregister as many netdev devices as siblings */
> +	/* First, kill all pending RX URBs. usb_kill_anchored_urbs() waits
> +	 * until all completion handlers have completed, ensuring that no
> +	 * decode_buf() callback can access usb_if->dev[] after this point.
> +	 */
> +	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings)
> +		usb_kill_anchored_urbs(&dev->rx_submitted);

[Severity: Medium]
The commit message only covers channel number validation in the PCAN-USB
FD decoders. Should this change to peak_usb_disconnect() go in its own
patch, or at least be described here?

peak_usb_disconnect() is the .disconnect callback of peak_usb_driver, so
this changes teardown for PCAN-USB, PCAN-USB Pro and all FD variants. The
Fixes: tag points at the range-check commit, which did not touch teardown
ordering.

It is also unclear which case the loop fixes. peak_usb_driver does not set
soft_unbind, so on a normal unbind the USB core already does this:

drivers/usb/core/driver.c:usb_unbind_interface() {
    ...
	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
		usb_disable_interface(udev, intf, false);

	driver->disconnect(intf);
    ...
}

That call flushes all URBs on the interface before ->disconnect runs. As
far as I can tell, the new loop only changes behaviour when
peak_usb_probe() calls peak_usb_disconnect() directly after
peak_usb_create_dev() fails:

peak_usb_probe() {
    ...
		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
		if (err) {
			/* deregister already created devices */
			peak_usb_disconnect(intf);
			break;
		}
    ...
}

> +
> +	/* All RX URBs have been drained before reaching this point. No
> +	 * decode_buf() callback can access usb_if->dev[] anymore, making it
> +	 * safe to unregister and free the associated netdevs.
> +	 */

[Severity: Medium]
Is this guarantee actually enforced? usb_kill_anchored_urbs() only blocks
resubmission while it is running.

The netdevs stay registered. PCAN_USB_STATE_CONNECTED is only cleared per
device, inside the second loop, and no lock is held across the two loops.
So a concurrent open can re-arm the RX URBs after the drain:

peak_usb_ndo_open()
  peak_usb_start()
    usb_submit_urb()

On a normal unbind those submissions fail, because the interface has
already been disabled. On the peak_usb_probe() failure path the endpoints
are still enabled.

Take a two-channel FD adapter where creating channel 1 failed after
dev_init. usb_if->dev[1] still points at the freed channel 1 device (see
the comment in pcan_usb_fd_decode_canmsg() below).

Suppose can0 is brought up between the first loop and
unregister_candev(can0). Could a channel=1 record then be decoded through
the freed device?

>  	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
>  		struct net_device *netdev = dev->netdev;
>  		char name[IFNAMSIZ];
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 82502594a4092..71ac6fdcd99be 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -536,10 +537,19 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
>  
> -	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware */
> +	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
> +		return -EINVAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but when a decoder returns an
error like this one, peak_usb_read_bulk_callback() dumps the whole RX
buffer:

peak_usb_read_bulk_callback() {
    ...
			err = dev->adapter->dev_decode_buf(dev, urb);
			if (err)
				pcan_dump_mem("received usb message",
					      urb->transfer_buffer,
					      urb->transfer_buffer_length);
    ...
}

transfer_buffer_length is the allocated size, PCAN_UFD_RX_BUFFER_SIZE
(2048 bytes) for FD, not urb->actual_length. peak_usb_start() allocates
these buffers with a plain kmalloc().

Can a device send a short transfer with a bad channel number on the first
completion of each URB? If so, stale heap contents past actual_length
would go to the kernel log through print_hex_dump(KERN_INFO, ...).

The dump is not rate limited, and every ndo_open allocates new buffers.

Would dumping only urb->actual_length bytes be enough?

>  
>  	dev = usb_if->dev[pucan_msg_get_channel(rm)];
> +
> +	/* This should never happen during normal operation. However, do not
> +	 * trust the device and reject records targeting a valid channel
> +	 * without an associated netdev.
> +	 */
> +	if (!dev)
> +		return -EINVAL;
> +
>  	netdev = dev->netdev;

[Severity: High]
Does this check cover a channel whose device has already been freed?
Nothing ever clears usb_if->dev[]. The only writer is in
pcan_usb_fd_init():

	pdev->usb_if->dev[dev->ctrl_idx] = dev;

pcan_usb_fd_free() does nothing for a channel that still has siblings:

	if (!dev->prev_siblings && !dev->next_siblings) {

Consider probe of a two-channel FD adapter such as PCAN-USB Pro FD or X6:

peak_usb_create_dev(0)              can0 brought up, RX URBs live
peak_usb_create_dev(1)
  register_candev(can1)
  pcan_usb_fd_init()                dev[1] = dev1
  dev_set_bus(dev1, 0) fails        device stalls or times out
  adap_dev_free:
    pcan_usb_fd_free(dev1)          no-op, prev_siblings is set
  unregister_candev(can1)
  free_candev(can1)                 dev1 freed, dev[1] still set

Until peak_usb_probe() reaches peak_usb_disconnect(), a channel=1 record
on one of can0's URBs passes both the ctrl_count check and the !dev
check.

pcan_usb_fd_decode_error() then writes device-supplied counters into the
freed object:

	pdev->bec.txerr = er->tx_err_cnt;
	pdev->bec.rxerr = er->rx_err_cnt;

pcan_usb_fd_decode_canmsg(), pcan_usb_fd_decode_status() and
pcan_usb_fd_decode_overrun() read dev->netdev from freed memory and use
it.

Should the slot be cleared, and sibling RX quiesced, before a channel that
was already published to usb_if->dev[] is freed?

[ ... ]

> @@ -605,10 +615,19 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
>  
> -	if (pucan_stmsg_get_channel(sm) >= ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware */
> +	if (pucan_stmsg_get_channel(sm) >= usb_if->adapter->ctrl_count)
> +		return -EINVAL;
>  
>  	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
> +
> +	/* This should never happen during normal operation. However, do not
> +	 * trust the device and reject records targeting a valid channel
> +	 * without an associated netdev.
> +	 */
> +	if (!dev)
> +		return -EINVAL;
> +
>  	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
>  	netdev = dev->netdev;

[Severity: Low]
The new NULL checks in pcan_usb_fd_decode_canmsg(),
pcan_usb_fd_decode_status(), pcan_usb_fd_decode_error() and
pcan_usb_fd_decode_overrun() target a sibling's RX completion that runs
while probe is publishing the slot in pcan_usb_fd_init().

Both sides use plain accesses: a plain store in process context and a
plain load in URB completion context. KCSAN would report this as a data
race.

Nothing orders the ctrlmode and ctrlmode_supported copies made in the
sibling branch of pcan_usb_fd_init() before the store either.
pcan_usb_fd_decode_canmsg() reads dev->can.ctrlmode.

The slot only ever goes from NULL to non-NULL, so the impact looks
limited. Should the store and loads use WRITE_ONCE()/smp_store_release()
and READ_ONCE()/smp_load_acquire()?

[ ... ]

> @@ -987,6 +1024,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
>  		if (!pdev->cmd_buffer_addr)
>  			goto err_out_1;
>  
> +		/* keep reference to the adapter device */
> +		pdev->usb_if->adapter = dev->adapter;
> +
>  		/* number of ts msgs to ignore before taking one into account */
>  		pdev->usb_if->cm_ignore_count = 5;

[Severity: Medium]
This is a pre-existing issue, but peak_usb_create_dev() calls
register_candev() before dev->adapter->dev_init(). The FD netdev is
therefore visible to userspace before pcan_usb_fd_init() has set
pdev->usb_if, pdev->cmd_buffer_addr and usb_if->dev[].

A bitrate change in that window goes through peak_usb_set_bittiming() to
pcan_usb_fd_set_bittiming_slow(). That function writes through
pcan_usb_fd_cmd_buffer(dev) while it is still NULL. pcan_usb_fd_send_cmd()
also dereferences pdev->usb_if->fw_info.

This patch adds a small sub-window of its own. usb_if is kzalloc'ed and
published, and cmd_buffer_addr is allocated, before usb_if->adapter is
assigned here. Every decoder now starts by dereferencing
usb_if->adapter->ctrl_count.

That sub-window is very hard to hit, because decoding requires
PCAN_USB_STATE_STARTED. Before the patch, the same window crashed on the
NULL dev[] slot instead.

Could usb_if->adapter be assigned right after the kzalloc? The root fix
would be to finish dev_init before register_candev().

[ ... ]

[Severity: High]
This is a pre-existing issue, but it is in the same probe teardown code.
The error path in peak_usb_create_dev() frees the shared FD state before
the netdev is unregistered:

peak_usb_create_dev() {
    ...
adap_dev_free:
	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);
    ...
}

For channel 0 of any FD adapter, pcan_usb_fd_free() sees no siblings. It
kfree()s pdev->cmd_buffer_addr and pdev->usb_if and does not clear either
pointer.

If can0 was opened between register_candev() and the failing
dev_set_bus(dev, 0), unregister_candev() closes it:

unregister_candev()
  peak_usb_ndo_stop()
    pcan_usb_fd_stop()
      pcan_usb_fd_set_options()          writes freed cmd_buffer_addr
      pdev->usb_if->dev_opened_count--   writes freed usb_if
    pcan_usb_fd_set_bus()                writes freed cmd_buffer_addr

pcan_usb_fd_send_cmd() also reads fw_info from the freed usb_if. Until
can0 is closed, its RX URBs keep decoding through the freed usb_if.

Should unregister_candev() run before dev_free here, in the same order
peak_usb_disconnect() uses?

[Severity: High]
This isn't a bug introduced by this patch, but the PCAN-USB Pro driver has
the same NULL slot dereference that this patch guards against in the FD
decoders. pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error() in
pcan_usb_pro.c only do this:

	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
		return -EINVAL;

	dev = usb_if->dev[ctrl_idx];
	netdev = dev->netdev;

pcan_usb_pro_init() sets usb_if->dev[1] only when channel 1 is created. By
then can0 is already registered and can be opened, and its RX URBs are
live on the shared PCAN_USBPRO_EP_MSGIN endpoint.

The device can widen that window by delaying its responses to can0's
dev_set_bus(0) and dev_get_can_channel_id calls.

Can a record with ctrl_idx == 1 arriving in that window cause a NULL
pointer dereference in URB completion context? Should the Pro decoders get
the same NULL check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-canfd_check_channel_idx-v2-0-f7b772929791%40peak-system.fr
