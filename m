Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623531;
	b=D+1cxBoxyw+IctbuYisogA0VprriTfkWYGVYMus2dqAZ1O+TrDhh8DHEhwvRFzSgyGR4
	 RbFs46GCg0R/t/Y9yssTE3eM/cVgWTtgyQ/vH5zPgjv6NVHyaKo7uH9rYU2AeDFjBMvKg
	 gIc357GIC7IAAB5KMyPyEJ5agRc83eTTEHZ9my3v+KtvFQAespnp8tHHS7THdLDppry1y
	 coPwExRxQJA6k9hRsTNs2JdZELJX8LFNXYEC6hLsA0Qy3v0Tbb/BoDFDN+gOFwVgmwOLG
	 f+RM47aEe3e2AAPGfIlXp3O/mweH5pgVxzgxHIXPBExE0GctDb7DSJEcLkxhb/3N70Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623531;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mvUD0LH5/vbrkHctU9jfMdrxC+x3LgPy1uBFG3aBrGw=;
	b=IuTMc1ZMeN0epiqtGsNcvxomYj/Oe2QipwHJXbI0T6VGKBSwjB0YW/Tq8EjDrOVuB1lv
	 sNBcrHajSfOyT9qnhVY8sIMdJ9SeAz0TJnDLOIzpV06HDV0b7nOFBn69klkF0V0QFn84n
	 S+78CejswOuSk+subZjorM+rnAnmpbusiIP0O/nt7HuJCDqxTu/1oJcOBL/fTeW5GaOXx
	 RrrgRE7g8lM8wEr/lELiZT1EHJr5XLjvFaVhWQAXlLM6pccDB49xi4Zsm3e2vtFPK3TIz
	 2YpWGPWQNMiEt/XQDzJMmp/FgpnfpgTVNzYERIskcdODis6yAA+sorwrsXS9WUcG+qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbl6In0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876A606A31E;
	Wed, 21 Oct 2026 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbl6In0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE521F000C3;
	Wed, 21 Oct 2026 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623531;
	bh=mvUD0LH5/vbrkHctU9jfMdrxC+x3LgPy1uBFG3aBrGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hbl6In0Dhu6z6MHnRnf+Q0K4zv7Wqn2HR+OJE/ZCMMOQ8iI3VghyrsaDY2vicMQML
	 nGHaSt+L9xWxOfErPbxqJfQvmOuAEhouaxB4LIY8LU0EtA7i5w33G5uP3Mp/1E28Bt
	 ul3fGQa8dYVIZCo0o+6WV6aRmGtsNtg7mkGaUJJSrAfgiMm1R2UtWjZMrTXAk0Axwk
	 UnKJVvd1OWV+ao+vBibzDq1uKgDOCz7Kp81n+tDYZz5c6mEvG+zeQ0asG8ZTWdU2Sq
	 He3yzIG68Yd8vJeosHk+eeQeBgL6W/YhoXAM5ALIdNkdDT8xiljdFK4Zpku4zRdsGl
	 eu1axQ6G7Sl6g==
Subject:
 Re: [PATCH v3 06/10] can: peak_usb: harden channel handling in PCAN-USB FD
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 22:58:50 +0000
Message-ID: <179262353017.3131.14386342745936674043@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v3-6-74d17c5a599e@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v3-6-74d17c5a599e@peak-system.fr>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, the adap_dev_free error path in
  peak_usb_create_dev() (drivers/net/can/usb/peak_usb/pcan_usb_core.c)…

Pre-existing issues:
- [Medium] When peak_usb_disconnect() runs while the adapter is still
  powered (probe failure or sysfs unbind), PCAN_USB_STATE_CONNECTED is…

--

can: peak_usb: harden channel handling in PCAN-USB FD

This commit checks the channel number in records from PCAN-USB FD devices
against the adapter's controller count. Records for an empty channel slot
are now rejected. It also clears the channel slot in pcan_usb_fd_free(),
stops RX on the sibling channels when a probe fails, and makes
peak_usb_disconnect() stop RX on all channels before it unregisters any
of them.

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
Does this error path leave the failing channel running on memory that
dev_free() has just released?

peak_usb_stop_rx() only walks dev->prev_siblings. So dev keeps
PCAN_USB_STATE_CONNECTED set, and its rx_submitted URBs are not poisoned.
On a single-channel adapter, or when channel 0 fails, prev_siblings is
NULL and nothing is stopped.

register_candev() runs before dev_init() and dev_set_bus(), so the
netdev may already be open when dev_set_bus(dev, 0) fails. In that case
pcan_usb_fd_free() finds no siblings and frees the shared objects:

pcan_usb_fd_free() {
    ...
	if (!dev->prev_siblings && !dev->next_siblings) {
		kfree(pdev->cmd_buffer_addr);
		kfree(pdev->usb_if);
	}
}

Only after that does the code fall through to:

lbl_unregister_candev:
	unregister_candev(netdev);

In the meantime, dev's RX completions can keep running
pcan_usb_fd_decode_buf() on the freed usb_if. The decoders read
usb_if->adapter and usb_if->dev[], and the timestamp decoding writes
cm_ignore_count and time_ref.

After that, unregister_candev()->peak_usb_ndo_stop()->pcan_usb_fd_stop()
does:

	if (pdev->usb_if->dev_opened_count == 1)
		pcan_usb_fd_set_options(dev, 0,
					PUCAN_OPTION_ERROR,
					PCAN_UFD_FLTEXT_CALIBRATION);
	pdev->usb_if->dev_opened_count--;

This reads and writes the freed usb_if. pcan_usb_fd_set_options() and
pcan_usb_fd_set_bus() also build commands in the freed cmd_buffer_addr.

The commit message says RX is stopped before the channel is freed, but
here that only covers the siblings.

A later patch in this series, "can: peak_usb: unregister the netdev
before dev_free() on probe failure", moves unregister_candev(netdev) in
front of dev_free(dev). With that change, ndo_stop kills
dev->rx_submitted while usb_if is still allocated. Could that ordering be
folded into this patch, so this commit is not left with the
use-after-free?

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

[Severity: Medium]
This is a pre-existing issue, and this patch did not introduce it.
peak_usb_disconnect() can run while the adapter is still powered, from a
probe failure or a sysfs unbind. CONNECTED is cleared before
unregister_candev(). Are the bus-off commands sent from ndo_stop dropped
in that case?

pcan_usb_fd_send_cmd() returns success without sending anything:

	/* usb device unregistered? */
	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
		return 0;

So two commands never reach the device: PUCAN_CMD_RESET_MODE from
peak_usb_ndo_stop()->pcan_usb_fd_set_bus(dev, 0), and the options-off
command from pcan_usb_fd_stop(). The CAN controller could then stay in
operational mode with no driver bound.

The old code already cleared CONNECTED just before each channel's
unregister_candev(), so the behavior is the same. This patch only clears
the bit on all channels up front.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e%40peak-system.fr
