Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499329;
	b=j7vm/d3Q4HDh32NOxWiudOMW3Xxr27+vbDQTOJAtP+d4H1VXRY5s8mujz0+5xjbBZ9Zb
	 CgtFPrWVhRiXeiQnyjZ+VwAOuQ1653NywFj/meGpozOOn1mVVjFOqlp/UcJkB6prIUJtb
	 c6TGfOW1IITh1QnpfzahEUhT8O+n4pG2wF7kH6AIhZrlsgfWXvFHiZcZIh4n3WxPnyWH/
	 MHZGkB9ctqENtTgeCovCd7i2OyRAO6AljA7Nrv7kcZsYll1DRvVGdXfjMvrTA4ePS13d7
	 0mKSBfyvsxU1TtnOZ5U1XkwQv2GqezcyoTRH6WBobQaE7Sj0/HU7Gd+bgQYTMUDNi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=buYvH/z8eKO5TNOcNGaLJ1kkawjS8FgN7VfGltfk1mM=;
	b=lMpd7CAuOPCamnO+Q9ENdZ7cTN1gsKM3sedtC4NHkyGZ2w3oAMcLYp4x5YpM+wcDNySS
	 9QYZQcLoNvVhcVnse0FZC693ivhIz5nBRhSkSXvib997X29EKCRVJcgH3B3c/rHhZtwcd
	 g/lF8uy6pC/Xo6DQwz6AwpQVQLAz4VfrhECxKNi7lMc8o7Usv8jxIdb/7GlLQJldqbBKE
	 UFW0meGuAI5n1FZzsdpEaF5P5T/5uwKW3fDFw0mGOLdhRYbb/J8EI9fGmpFkehw2S3Xay
	 l36kPg9/AMxhKqNFmDGnzsPZpZPKYiXOLSTiaHhUliRwiQQi6UZVu2cOuXuapv/Kwhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzGmvvBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36610606A326;
	Sun,  1 Nov 2026 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzGmvvBE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421911F000C1;
	Sun,  1 Nov 2026 02:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499328;
	bh=buYvH/z8eKO5TNOcNGaLJ1kkawjS8FgN7VfGltfk1mM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jzGmvvBEqvAr3ktsvE5B4keqHzN7TyH0rc9AzT7s+hP5v12tjxiYwoOjg0UtsrWxs
	 zSRGZBX47Bk3UuRqFalsW+sv24iFJrxRNg7VPYUOKU4pqf1IT0mGVU694e7FyICtj/
	 FLlkQTh5wFi6Q5gnYrfcKzHl0eHcZYVm2E6xTnqM7aGBGcISJgijKtxcP3YQrYNIqh
	 QNM2gcrOeaZ+ETTF6jhvGNK9MzEx2nKSViDawbLfbzHIqyPESFjDly8fho1M4t5LbK
	 2UI3JuS0WtV1kvm2LsgN0P6MJEWznv/QRcupsMQfLfVCuBbO8S6NxJZ5Zpt6/0w0iv
	 F3BodGemS0eow==
Subject:
 Re: [PATCH v7 06/13] can: peak_usb: harden channel handling in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristmd@gmail.com, kuba@kernel.org
Date: Sun, 01 Nov 2026 02:15:27 +0000
Message-ID: <179349932777.3127.4920937034375531815@kernel.org>
In-Reply-To:
 <20261030-canfd_check_channel_idx-v7-6-fc4a3faf3acf@peak-system.fr>
References:
 <20261030-canfd_check_channel_idx-v7-6-fc4a3faf3acf@peak-system.fr>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the adap_dev_free path, the new peak_usb_stop_rx(dev) call
  clears PCAN_USB_STATE_CONNECTED before unregister_candev() runs…

Pre-existing issues:
- [High] Asynchronous restart URBs can outlive the peak_usb_device they
  point to on the probe-error teardown path.
- [High] On the adap_dev_free error path of peak_usb_create_dev(),
  dev_free() (pcan_usb_fd_free()) frees the shared usb_if and…
- [High] peak_usb_create_dev() calls register_candev()
  (pcan_usb_core.c:1009) before dev_init() (1022).

--

can: peak_usb: harden channel handling in PCAN-USB FD

The PCAN-USB FD decoders now check record channel numbers against the
adapter's controller count. They also reject records whose usb_if->dev[]
slot is empty, and pcan_usb_fd_free() clears a channel's slot.

The patch also adds peak_usb_stop_rx(), which clears CONNECTED under RTNL
and poisons the RX anchors. It is called on the probe error path and in
peak_usb_disconnect() before channels are freed.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index a1b17e1e6fea6..f5c39b43b0fa1 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -574,6 +575,9 @@ static int peak_usb_ndo_open(struct net_device *netdev)
>  	struct peak_usb_device *dev = netdev_priv(netdev);
>  	int err;
>  
> +	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
> +		return -ENODEV;
> +

[Severity: High]
This is a pre-existing issue, but does this CONNECTED test close the
window where the netdev is visible before its private data is set up?

peak_usb_create_dev() sets CONNECTED and calls register_candev(). Only
after that does it call dev_init():

	set_bit(PCAN_USB_STATE_CONNECTED, &dev->state);
	...
	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);

Until pcan_usb_fd_init() runs, pdev->usb_if and pdev->cmd_buffer_addr are
still NULL. Can userspace configure or open the netdev in that window?
That would make pcan_usb_fd_start() dereference pdev->usb_if, or make the
bittiming command builders use the NULL cmd_buffer_addr.

The later commit "can: peak_usb: register the netdevs only once all
channels are set up" appears to fix this. It moves register_candev() into
peak_usb_probe(), after all channels are initialized.

>  	/* common open */
>  	err = open_candev(netdev);
>  	if (err)

[ ... ]

> @@ -1014,6 +1041,13 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	return 0;
>  
>  adap_dev_free:
> +	/* the whole interface is released when probing a channel fails:
> +	 * stop RX on this channel, which may already be open, and on the
> +	 * channels already created, since their RX URBs may carry records
> +	 * for this one.
> +	 */
> +	peak_usb_stop_rx(dev);

[Severity: Medium]
Does clearing CONNECTED here suppress the shutdown commands that ndo_stop
sends for a channel that is already open?

On this path the netdev is still registered and may be up. The later
unregister_candev() runs peak_usb_ndo_stop(), which calls dev_stop() and
dev_set_bus(dev, 0). With CONNECTED now clear, pcan_usb_fd_send_cmd()
returns early:

	/* usb device unregistered? */
	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;

Before this patch, CONNECTED was still set when ndo_stop ran here. Could
a probe failure now leave the controller bus-on, with calibration records
still streaming, while the device stays attached?

The later commit "can: peak_usb: register the netdevs only once all
channels are set up" removes peak_usb_stop_rx() from adap_dev_free, and
no netdev is registered on this path there.

peak_usb_disconnect() still clears CONNECTED before it unregisters an open
channel, but the old loop already did that before unregister_candev().

> +
>  	if (dev->adapter->dev_free)
>  		dev->adapter->dev_free(dev);
>  

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
dev_free() before unregister_candev() on this error path?

If the failing channel has no siblings, pcan_usb_fd_free() frees the
shared objects:

	kfree(pdev->cmd_buffer_addr);
	...
	kfree(pdev->usb_if);

The code then falls through to lbl_unregister_candev and calls
unregister_candev() on a netdev that is registered and possibly open.
Wouldn't peak_usb_ndo_stop() -> pcan_usb_fd_stop() then access the freed
usb_if?

	pdev->usb_if->dev_opened_count--;

pcan_usb_fd_set_bus() would also build its command in the freed
cmd_buffer_addr.

The later commit "can: peak_usb: register the netdevs only once all
channels are set up" also fixes this, because no netdev is registered
by the time adap_dev_free is reached.

[ ... ]

> @@ -1038,13 +1072,14 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  	struct peak_usb_device *dev;
>  	struct peak_usb_device *dev_prev_siblings;
>  
> -	/* unregister as many netdev devices as siblings */
> +	/* stop RX on all channels before unregistering and freeing them */
> +	peak_usb_stop_rx(usb_get_intfdata(intf));

[Severity: High]
This is a pre-existing issue, but can an asynchronous restart URB outlive
the peak_usb_device it points to on the probe error path?

peak_usb_set_mode(CAN_MODE_START) -> peak_usb_restart() ->
dev_restart_async() submits a URB with dev as its context, without
anchoring it. In pcan_usb_fd_restart_async():

	usb_fill_bulk_urb(urb, dev->udev,
			  usb_sndbulkpipe(dev->udev, fw_info->cmd_out_ep),
			  buf, pc - buf,
			  pcan_usb_pro_restart_complete, dev);

	/* and submit it. */
	return usb_submit_urb(urb, GFP_ATOMIC);

pcan_usb_pro_restart_async() does the same. pcan_usb.c passes pdev as the
context instead.

When peak_usb_probe() calls peak_usb_disconnect() after a probe failure,
the USB core has not disabled the interface. The commit message says so
too.

On that path, peak_usb_stop_rx() only poisons rx_submitted. Then
unregister_candev() -> peak_usb_ndo_stop() runs. There, close_candev()
only cancels restart_work, and peak_usb_unlink_all_urbs() only kills the
rx_submitted and tx_submitted anchors. Finally free_candev() frees the
netdev.

A restart URB can still be pending on the command endpoint, for example
if the device keeps NAKing it. Wouldn't its completion, when it finally
runs, do this on the freed netdev?

pcan_usb_pro_restart_complete()
    peak_usb_restart_complete(urb->context)
        dev->can.state = CAN_STATE_ERROR_ACTIVE;
        netif_wake_queue(dev->netdev);

The later commit "can: peak_usb: register the netdevs only once all
channels are set up" narrows the trigger. A later sibling's
register_candev() has to fail after channel 0 was registered, opened,
went bus-off and had a restart submitted. No patch in the series tracks
or kills restart URBs.

> +
>  	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf%40peak-system.fr
