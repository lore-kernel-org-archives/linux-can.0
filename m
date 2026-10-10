Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C635AC1C;
	Sat, 10 Oct 2026 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614897; cv=none; b=rP48de1EBjA8/M88UqpcAHyUB+vj01ojPRMJoIooOpmk0qbiTyxBYNWq2Pi7xxWKvObjuvl6Gjj+QXfljGZa+p6hugMZvZqPHYSSfSc2G/3fOdTyefFEu85TJd7ZJucVCIU3HvZlRyzU17gZpiwaqck+SFHJCDapzhy2BBjoaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614897; c=relaxed/simple;
	bh=iA4WFORwLFrZmONIjKpMCL8CE3MLB7q2GA8c+J4Lh6E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SknH9o1MJ+9fZOkdPkLc9ILu+wNX+B2omovX5pIqMjZyxG4LRc2eyfnu9wTyAUeZ6IjHGc9cEJP04wtIgw3rJWyu/jfoxPajHPyLAOGgM11PXoTlKcCla9ckg+vuWywoLJGNYnFfRRdW/yKtkMbNh/P7V+NGQON0P/41ixkB59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpCmmVPD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpCmmVPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFE1F000FF;
	Sat, 10 Oct 2026 06:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614895;
	bh=uohb5mA7HLhXKpXSh3wTNg4ySGNQX6mCpKyKRXSdouA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OpCmmVPD7l7zgN5SC6CeBN/K4NVGIDELgZ/U3x2OzLcjhqKDrDilYoH+HXzPu4zH1
	 G6GJcBvCe58di8i38yL/YuxeK7TwlbO8MaGVgjkWwF8roeMxpPvSVowPFBUXUHbhAl
	 dGwfB6inTVINlQoseiA+RTZIdQMnnGrnNGXtYiagdWj/ELQo3aMSDzbtv6VVMwlsp5
	 lfV5cyp2RdNlz1Z2epZaYZXfn+s61LQe/TvuRpUxrAIa7GIIJApCJctizQZuRkTAne
	 A7gH3duAokyCWYulBD4PC1qSm82ovaRXdjsinxUrt9ntqTnWpQeViU4dBZF48jv1Rp
	 3x+ol4sNe+Nmg==
Subject:
 Re: [PATCH 4/5] can: peak_usb: validate channel numbers in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 s.grosjean@peak-system.fr, kuba@kernel.org
Date: Sat, 10 Oct 2026 06:48:14 +0000
Message-ID: <179161489475.1406898.15730503460636169751@kernel.org>
In-Reply-To:
 <20261008-canfd_check_channel_idx-v1-4-0a3bb82f4e09@peak-system.fr>
References:
 <20261008-canfd_check_channel_idx-v1-4-0a3bb82f4e09@peak-system.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check `channel >= usb_if->adapter->ctrl_count` only
  keeps the index inside dev[].
- [Low] The commit message for "can: peak_usb: validate channel numbers
  in PCAN-USB FD" says the patch "prevents potential out-of-bounds…

--

can: peak_usb: validate channel numbers in PCAN-USB FD

This patch changes the channel number check in the four PCAN-USB FD
decoders. The old bound was ARRAY_SIZE(usb_if->dev). The new bound is the
adapter's ctrl_count, read through an adapter pointer that is now stored in
struct pcan_usb_fd_if. Invalid channels now return -EINVAL instead of
-ENOMEM.

> Validate the channel number against the number of CAN controllers
> supported by the adapter before performing the lookup. Any message
> containing an invalid channel number is treated as malformed and the
> entire message buffer is discarded, as the device is considered to be
> providing untrusted data.

[ ... ]

> This prevents potential out-of-bounds accesses when handling
> unexpected or corrupted messages received from PCAN-USB FD family
> devices.

[Severity: Low]
Is "out-of-bounds" the right description here? This was the old check:

	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))

dev[] has PCAN_USB_MAX_CHANNEL (2) entries. No index outside dev[0..1]
could get past that check before this patch.

What this patch seems to fix is a NULL pointer dereference on the
single-channel adapters, PCAN-USB FD and PCAN-Chip USB. Both use
.ctrl_count = PCAN_USBFD_CHANNEL_COUNT (1). pcan_usb_fd_init() only fills
usb_if->dev[dev->ctrl_idx], and usb_if comes from kzalloc. On those
adapters dev[1] therefore stays NULL.

Before this patch, a device record with channel 1 passed the "< 2" check.
Then, in URB completion context:

  pcan_usb_fd_decode_canmsg(), _decode_status() and _decode_overrun()
      read dev->netdev
  pcan_usb_fd_decode_error()
      wrote pdev->bec through container_of(NULL)

Could the commit message name this device-triggered NULL dereference and
the affected adapters? There is no Cc: stable tag, so this matters for
backport decisions.

The "entire message buffer is discarded" wording also reads as if this
patch adds that behaviour. The goto fail path in pcan_usb_fd_decode_buf()
is unchanged. Records decoded before the bad one have already been passed
up via netif_rx(), and only the bad record and the ones after it are
dropped.

On the -EINVAL change: pcan_usb_fd_decode_error() and
pcan_usb_fd_decode_overrun() already returned -EINVAL before this patch.
peak_usb_read_bulk_callback() also ignores the returned error code.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 82502594a4092..ddbb2be1de0dd 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -536,8 +537,12 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
>  
> -	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware.
> +	 * Any channel below ctrl_count is guaranteed to have a valid
> +	 * entry in usb_if->dev[].
> +	 */
> +	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
> +		return -EINVAL;
>  
>  	dev = usb_if->dev[pucan_msg_get_channel(rm)];
>  	netdev = dev->netdev;

[Severity: High]
Does this guarantee hold? The ctrl_count check keeps the index inside
dev[], but nothing makes sure usb_if->dev[channel] points to a live
device.

On the 2-channel adapters (PCAN-USB Pro FD and PCAN-USB X6, ctrl_count =
PCAN_USBPROFD_CHANNEL_COUNT = 2), the new check is the same as the old
ARRAY_SIZE() check.

pcan_usb_fd_decode_status(), pcan_usb_fd_decode_error() and
pcan_usb_fd_decode_overrun() repeat the same comment and check.

The first case is a NULL entry during probe. peak_usb_probe() creates
channels one at a time, and peak_usb_create_dev() registers the netdev
before it calls dev_init():

peak_usb_create_dev()
    register_candev(netdev);
    ...
    dev->adapter->dev_init(dev);
        pcan_usb_fd_init()
            pdev->usb_if->dev[dev->ctrl_idx] = dev;

Once channel 0 is registered and initialised, can0 can be brought up while
dev[1] is still NULL. The window covers channel 0's dev_set_bus() and
dev_get_can_channel_id() bulk commands, which the device can stall for up
to 1000 ms each. It also covers register_candev() for can1.

Opening can0 submits RX URBs on the bulk-IN endpoint that both channels
share. pcan_usb_fd_decode_buf() routes each record by its own channel
field.

Could a channel-1 record then pass the "1 >= 2" test and dereference NULL
through dev->netdev here? The same would apply to dev->can.state in
pcan_usb_fd_decode_status() and to the write to pdev->bec in
pcan_usb_fd_decode_error().

The second case is a dangling entry when probe fails. If channel 1's
dev_set_bus() fails after dev_init(), peak_usb_create_dev() takes this
path:

adap_dev_free:
	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);

pcan_usb_fd_free() does nothing for a device that has prev_siblings set,
and it never clears usb_if->dev[1]:

static void pcan_usb_fd_free(struct peak_usb_device *dev)
{
	/* last device: can free shared objects now */
	if (!dev->prev_siblings && !dev->next_siblings) {

dev1 is then freed. peak_usb_probe() calls peak_usb_disconnect() directly,
without usb_disable_interface(), so can0's RX URBs are still live.

Can a channel-1 record arriving in that window reach freed memory? That
includes the write in pcan_usb_fd_decode_error().

Disconnects started by the USB core (unplug, sysfs unbind, rmmod) do not
seem to be affected. peak_usb_driver does not set soft_unbind, so
usb_unbind_interface() kills the URBs before ->disconnect().

The follow-up commit "can: peak_usb: harden PCAN-USB message validation"
only touches pcan_usb.c and does not cover this.

Would it be more complete to treat a NULL usb_if->dev[ch] as a malformed
message in each FD decoder? That would also cover the single-channel case
this patch targets.

Clearing the entry on per-channel teardown or failure would handle the
dangling case. The comment would also need to be corrected.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09%40peak-system.fr
