Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304330;
	b=rqUWlKjK7fMjbafna0ykegbxssS5mDRKSRqKsHxa7bm05dHNqxSkHAX54oBM46rTyyFf
	 3EC7F6CmLxc8B8QrTXX8vrARQCls4+7AQxCM2b8TvSZuy8QG3kuxtWadVnJFIavCxFXBg
	 5/mJyDJLUYYknu1F9XDCOZ2/SlhAyVHMnvHi2B3xd7ODDk7i7lMuPVlmC8OjygfhVAYpz
	 htyezzU8E3SBvmF6R6qOwzSdYdHfUrwaM6Jkl+bFgySVArcK+Y7nVziFYgSye+fLHawpn
	 mWZlD09gISYhaz0p7KP9jXpR8BCBFn5OHImJsv2s9SGjwE437Hozbzivnmq+wliWBcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304330;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZLxgvwGyvbXEkWfR68oMjSG1/4NuLSfmoIF/+Ge58LA=;
	b=J+Xs474y0SNr/gN5AyCmsd9jmZi6jWso6o5ZXXsvIDr2V2Lp4Q0SiksdwVLVprrI0/4N
	 1dRLP/xoq4OaUCnNS8bj3zQv4xrom0ipyQOp6FKaXPOlDz383qz1kYGqtlP56rHAKPAz0
	 3GHDbfyjgWtNqnD9JQHFGIRPVcZ+uorR+oOWAVVaO8jQRjXXyTqmWady53XQdrhctYi4/
	 41FnSGZ6u8dttSEX/OAV/M/7QKO0OxmBl2wOSu9w8cdaU2/WR1Huwbbw43S2hWca5clwS
	 QP+XlcdEQb1WdfVyoeYR6gH9JciaCA9ntA6GbJ0CZEGDCqeybP6R2LDZh0COkE/I+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYBDMboP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46226606A31C;
	Tue, 10 Nov 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYBDMboP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288D1F0089F;
	Tue, 10 Nov 2026 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304329;
	bh=ZLxgvwGyvbXEkWfR68oMjSG1/4NuLSfmoIF/+Ge58LA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IYBDMboPemWW67RTq0xHWDmfQFMyh+8anHQrjn3SK0Pwfbaz1xX5rFUOrLtY62093
	 RJ4R4mA8LvdccmeNOLEYTJiNzRtBjRgWxPnPWNE6HIhZERyw63GiDInJu8lsdosl3Q
	 wCX59uadjCz3zVPgz4LgRLx/C6XFj7B6BfDFVYLQwTM+sRlNIglvuTN6S+He1wbBCp
	 OTwOfHoqIJgkNVhE8K2lZ2FIaDS7BpXe87KRZZiNxvUDvviQ0bhPn9DrlKN4oR4+vl
	 pGiUnGWFJUk7r0Q4YElWZPxjnAzD/baJYRfWZsDkksKXbt4NyiEYAPl07gkmF27MQG
	 AldLvWSZM+t0Q==
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp state
 for mixed channels
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com,
 max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 ciprianmarian.costea@oss.nxp.com, kuba@kernel.org
Date: Tue, 10 Nov 2026 09:52:08 +0000
Message-ID: <179430432849.488853.15448419304798286866@kernel.org>
In-Reply-To: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is meant to stop RX timestamp conversion from using an
  uninitialized parent->tc when a non-TS channel is opened before a TS…
- [Low] gs_usb_probe() (drivers/net/can/usb/gs_usb.c) declares `bool
  ts_supported;` at line 1544 with no initializer.
- [Low] The comment on tc_lock in struct gs_usb
  (drivers/net/can/usb/gs_usb.c:335, `spinlock_t tc_lock; /* spinlock to…

--

can: gs_usb: fix hardware timestamp state for mixed channels

This patch moves the HW timestamp infrastructure setup into gs_usb_probe().
It runs there when at least one channel has GS_CAN_FEATURE_HW_TIMESTAMP set.
The patch also refcounts active timestamp channels in
gs_usb_timestamp_start()/gs_usb_timestamp_stop(), and calls them based on
each channel's feature flag instead of the number of active channels.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 6327069f63c95..0a1cd14c940cc 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -337,6 +337,7 @@ struct gs_usb {
>  
>  	unsigned int hf_size_rx;
>  	u8 active_channels;
> +	u8 active_timestamp_channels;
>  	u8 channel_cnt;

[Severity: Low]
This isn't a bug, but the comment on tc_lock in struct gs_usb still says:

	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */

gs_usb_timestamp_start() and gs_usb_timestamp_stop() now also take tc_lock
around active_timestamp_channels. The lock also doesn't make the counter
update atomic with timecounter_init(), because gs_usb_timestamp_read() drops
tc_lock for the USB transfer. In practice both writers run from
ndo_open/ndo_stop under RTNL.

Could the comment be updated to cover the counter, or to note that RTNL
serializes it?

[ ... ]

> @@ -988,10 +1006,10 @@ static int gs_can_open(struct net_device *netdev)
>  
>  	can_rx_offload_enable(&dev->offload);
>  
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_start(parent);

[Severity: High]
Can the RX path still use an uninitialized parent->tc here?

gs_usb_timestamp_init() no longer calls timecounter_init(), and parent is
allocated with kzalloc_flex(). So parent->tc.cc stays NULL from probe until
the first gs_usb_timestamp_start().

__dev_open() sets __LINK_STATE_START before it calls ndo_open. That means
netif_running() is already true for this channel while open_candev() and
can_rx_offload_enable() run, and both run before gs_usb_timestamp_start().

If a non-timestamp sibling channel is already open, the shared RX URBs on
parent->rx_submitted are in flight. gs_usb_receive_bulk_callback() only
checks the channel range, netif_device_present() and netif_running() before
it converts the timestamp:

gs_usb_receive_bulk_callback()
  gs_usb_rx_offload() / gs_usb_get_echo_skb()
    gs_usb_set_timestamp()
      gs_usb_skb_set_timestamp()
        timecounter_cyc2time(&parent->tc, timestamp)

If a frame for this channel completes in that window, timecounter_cyc2time()
dereferences tc->cc->mask while tc->cc is NULL. That happens in URB
completion context.

There is a second window just after tc->cc is set. gs_usb_timestamp_read()
drops tc_lock during the USB transfer:

	/* drop lock for synchronous USB transfer */
	spin_unlock_bh(&parent->tc_lock);
	err = gs_usb_get_timestamp(parent, &timestamp);
	spin_lock_bh(&parent->tc_lock);

A reader can then see cycle_last and nsec still at zero and produce a bogus
hardware timestamp.

A compliant firmware shouldn't send frames for a channel before
GS_USB_BREQ_MODE has started it. However, hf->channel is controlled by the
device. The v3 changelog mentions a guard that skipped RX timestamp
conversion and the delayed work while no timestamp channel was active. That
guard is no longer present in v4.

Would it make sense to restore a check in gs_usb_skb_set_timestamp(), or to
make parent->tc valid from probe?

[ ... ]

> @@ -1526,6 +1541,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	};
>  	struct gs_device_config dconf;
>  	unsigned int icount, i;
> +	bool ts_supported;
>  	int rc;

[Severity: Low]
Should ts_supported be initialized to false?

The only assignment is in the per-channel loop, and it only ever sets true:

		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
			ts_supported = true;

If no channel reports GS_CAN_FEATURE_HW_TIMESTAMP, the later check

	if (ts_supported)
		gs_usb_timestamp_init(parent);

reads uninitialized stack memory. KMSAN may report this as an uninit-value
use, and the compiler may emit a maybe-uninitialized warning.

>  
>  	rc = usb_find_common_endpoints(intf->cur_altsetting,
> @@ -1599,6 +1615,9 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->canch[i] = dev;
>  		parent->canch[i]->parent = parent;
>  
> +		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +			ts_supported = true;
> +

[ ... ]

> @@ -1616,6 +1635,9 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
>  	}
>  
> +	if (ts_supported)
> +		gs_usb_timestamp_init(parent);
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-gs_usb-fixes-v5-0-d52dd4940d46%40pengutronix.de
