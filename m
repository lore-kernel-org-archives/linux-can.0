Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF731DF25C
	for <linux-can@vger.kernel.org>; Sat, 18 Jul 2026 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353369; cv=none; b=O4LrfJoNbZ7tddVVRH1VZfL9A02i+t11aps8buq2hVOfacZEbj5XlBvOb6aG4+2P8ZePHBcEFWiACzaEJbj8Is0UhzuwQ/dpIpXIZVwD6k3OpUl8XIwE+L1RHYbwiO1dAIyysnubDgLukfqvOgYKpi5q/BpntFC/NIdnONfs2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353369; c=relaxed/simple;
	bh=Zc3HTb+eWELqDm5rbNioCJr+C5WFH0IKg+BuqQ8gyn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxKfoWKKVHTItnt471xgCZ+v4+02PlCA5pWk9ibdJZ4KsGCuLUtPiV+ykETDeVp7DN2ZFJ8tl0fZy79JwujcR1KnoUu1k3bSBmz7gYWXAHjOUs5Nt/x/1PhE1xXpOtVSbNt+s/imSJwaLioIqxE5Fj4U7UqVIKD/e1yAvSkv8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWiZLpa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWiZLpa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C11F000E9;
	Sat, 18 Jul 2026 05:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784353367;
	bh=kCUD+yssuNCIJUlC0tReY70gnZymwkQJBBN9BriYVQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWiZLpa/C0zTOCKuE0EsLAboYTOzxQ5qohM9NvQhA0j0ZJ6yu2YQ8dWfvJxEo2Rvr
	 AH4tKkK1+RUBwACV4UzuZKXaOkNe1cjOkm7xdZPUIPSyWcyrPDrpMjtd0MKFUdpBs9
	 CWmZKFnuww8TBlqImOkTUUuAGtY1jCLFiTrP1CH3fOQIIH12sDS9VZ7CifgYUwk2BW
	 HUv57rzNCkfoEkCbfOXOEKSzRadMviTG2NaOXlZlPbKozO9HpSIpPZLrWs+6WOXnHE
	 y4TlKLX5ezw7MNyhTw1LCpEoVM6YQz2Opha0mLWQxwmtWUMXCsHjbYR4romA0BU8dB
	 MchqbhFtxAzTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can] can: gs_usb: fix hardware timestamp state for mixed
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
References: <20260718052815.2507496-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 05:42:46 +0000
Message-Id: <20260718054246.C49C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential deadlock due to using `spin_lock_bh` for `tc_lock` while=
 it is acquired in an URB completion handler.
- [High] A malicious or buggy USB device can cause a kernel panic by sendin=
g an RX URB for a channel that hasn't been fully initialized.
- [High] A malicious USB device can cause a kernel panic by sending an RX U=
RB for a timestamp-capable channel before the timecounter is initialized.
--

--- Patch [1]: [PATCH can] can: gs_usb: fix hardware timestamp state for mi=
xed channels ---
commit d94a7b828312e3ba70b37ab83b64617437b2e0cb
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

can: gs_usb: fix hardware timestamp state for mixed channels

The hardware timestamp state is shared by struct gs_usb, but gs_can_open()
and gs_can_close() tie its initialization and teardown to active_channels
and to the feature bits of the channel being opened or closed.

This is wrong for mixed-channel devices in both directions. If a
non-timestamp channel opens first, a later timestamp-capable channel does
not initialize the shared cyclecounter/timecounter because active_channels
is already non-zero. Timestamp RX then calls timecounter_cyc2time() with
parent->tc.cc unset.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc696..bf956fef0d196 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
[ ... ]
> @@ -480,19 +481,23 @@ static void gs_usb_timestamp_init(struct gs_usb *pa=
rent)
>  	cc->shift =3D 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
>  	cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
> =20
> -	spin_lock_init(&parent->tc_lock);
>  	spin_lock_bh(&parent->tc_lock);

[Severity: High]
This is a pre-existing issue, but is it possible for a deadlock to occur he=
re?

The lock tc_lock is acquired using spin_lock_bh() in process context=20
(gs_usb_timestamp_work). If a USB RX URB completion=20
(gs_usb_receive_bulk_callback) fires in hardirq context, it interrupts=20
the process context.=20

The URB callback then calls gs_usb_skb_set_timestamp(), which also tries=20
to acquire tc_lock using spin_lock_bh():

    gs_usb_skb_set_timestamp() {
        ...
        spin_lock_bh(&parent->tc_lock);
        ...
    }

Would this spin forever since the lock is already held by the interrupted=20
thread?

>  	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
>  	spin_unlock_bh(&parent->tc_lock);
> =20
[ ... ]
> @@ -980,10 +986,13 @@ static int gs_can_open(struct net_device *netdev)
> =20
>  	can_rx_offload_enable(&dev->offload);
> =20
> -	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +	if ((dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) &&
> +	    !parent->timestamp_started) {
> +		gs_usb_timestamp_init(parent);
> +		timestamp_started =3D true;
> +	}

[Severity: High]
This is a pre-existing issue, but could a malicious USB device cause a=20
kernel panic by sending an RX URB before the timecounter is initialized?

When opening a timestamp-capable channel while a non-timestamp channel is=20
already open and submitting RX URBs, the network stack sets=20
__LINK_STATE_START on the new channel before calling gs_can_open(). This=20
makes netif_running() return true immediately.

During the race window before gs_can_open() initializes the timestamp state=
=20
here, an RX frame for the new channel could be processed:

    gs_usb_skb_set_timestamp() {
        ...
        ns =3D timecounter_cyc2time(&parent->tc, timestamp);
        ...
    }

Since parent->tc.cc is still NULL, would this dereference a NULL pointer?

[ ... ]
> @@ -1577,6 +1585,8 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	parent->channel_cnt =3D icount;

[Severity: High]
This is a pre-existing issue, but could a malicious USB device trigger a NU=
LL=20
pointer dereference by sending an RX URB for a channel that hasn't been=20
fully initialized?

The count parent->channel_cnt is set to its maximum here, before the=20
underlying objects are fully allocated in the loop that follows.

If userspace brings up the first channel while the loop is still=20
initializing the remaining channels, RX URBs are submitted. A device=20
could immediately send an RX URB with a channel index that hasn't been=20
allocated yet.

The callback gs_usb_receive_bulk_callback() checks the channel:

    if (hf->channel >=3D parent->channel_cnt)
        ...

This check would pass, but the uninitialized array element is accessed:

    dev =3D parent->canch[hf->channel];
    netdev =3D dev->netdev;

Would this cause a panic when dereferencing dev?

> =20
>  	init_usb_anchor(&parent->rx_submitted);
> +	spin_lock_init(&parent->tc_lock);
> +	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> =20
>  	usb_set_intfdata(intf, parent);
>  	parent->udev =3D udev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718052815.2507=
496-1-shuangpeng.kernel@gmail.com?part=3D1
