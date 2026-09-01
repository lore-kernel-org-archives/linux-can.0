Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF83D091C
	for <linux-can@vger.kernel.org>; Tue,  1 Sep 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273811; cv=none; b=Jyp4G6t8kaCNg0a1bkm4KiRW/5KxBDvcfO+H+pecqzkOcq/okdhNvOnrZM1S3f8te5kP4wU1p4rAGZuMWKyBsSdVGyIX442rDesHXS9s0Duvv+6M/GI+jh1GcREe4wZMy2n/ruIfhB4V2MSRj9BjI8e/1e9gpnC/cr4uDJdTTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273811; c=relaxed/simple;
	bh=x53xu8YZhcbiumapdsCatlapt51RdqWKJfcTcWeIwYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFHb/zOdLkDWvShmr2F5yfdBlNg81pWqXdwwSIhvMlEkDOQ50jfYJ+DdfoQRIrHl0a2oc5x6iU7dPY7ZbJnIze+Ur82vP1BdHkCLFRUDoiqCb10eFuG7p4L7VL8hqSPfU+UGcY5PkHt7nwyAgw3tf1hDit1lNdaOciuB3NS9Hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz+qvxEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz+qvxEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDCB1F000E9;
	Tue,  1 Sep 2026 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273809;
	bh=S2iRQ7D4qRHP7iZdqpPUEWdZSl7JyLPMypptO/7Pi2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qz+qvxEf7K+vvx+fCuida6X5VWIEpSpoj8gLuYsAe9nYnWnwPiCl6/4OLI/rlVX8u
	 nFMwklvSAdgPJnUywiV0XeY0BFYIj+OczBhEgQ9N4ljSrO7fZogtXeFEIDEnzx0uqC
	 2wkRT/08GWDYOgSfjWAvR0AL0fMCVyr7WH4OSnTqwHKoIgmVaucp4VRsl6U1RKlpib
	 L7Ht+hN01XfI9DB3Yopb6KcQUHWfISVY172wn122hSuPcUacyw2y+gdfHqc6h7jiFT
	 +rqtiYlVLgcKT6A/13naq5i6zsa/SpsRfnYbubA2ipXYn7IwEsugHPRTlHPj6DQQkb
	 ybXJanWYPmuHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: usb: f81604: fix use-after-free on disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmktWmUgSG9uZyAoUGV0ZXIgSG9uZyk=?= <peter_hong@fintek.com.tw>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw>
References: <20260901-f81604-fix-v1-1-c55b5178f9f8@fintek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:43:29 +0000
Message-Id: <20260901144329.8BDCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect teardown order in `f81604_close()` calls `close_candev()=
` before killing URBs, leaving the device vulnerable to `restart_work` Use-=
After-Free and `echo_skb` Double-Free.
- [High] TX URBs are not anchored, causing them to leak and trigger a Use-A=
fter-Free on device disconnect.
- [High] Duplicate URB submission and memory leak during CAN bus-off recove=
ry.
- [High] Pending `clear_reg_work` is leaked if `f81604_open()` fails, leadi=
ng to a use-after-free upon device disconnect.
--

commit a9d42819f6aa6bc14b0da3547f398a4d371e4aab
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Subject: can: usb: f81604: fix use-after-free on disconnect

This commit unregisters the URBs before cancelling clear_reg_work. This
prevents an URB completion handler from scheduling work after
cancel_work_sync() has returned, which would otherwise result in a
use-after-free.

Closes: https://lore.kernel.org/all/20260824133009.CF85A1F00A3A@smtp.kernel=
.org/

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index 4c147b9d6d690..bb155b8769245 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
>  	f81604_set_reset_mode(priv);
> =20
>  	netif_stop_queue(netdev);
> -	cancel_work_sync(&priv->clear_reg_work);
>  	close_candev(netdev);

[Severity: High]
This isn't a bug introduced by this patch, but close_candev() is executed
while URBs are still active and capable of triggering concurrent callbacks.

Can this order result in a use-after-free or double-free?=20

If an active URB completes concurrently, could it trigger can_bus_off() (wh=
ich
reschedules restart_work AFTER it was cancelled in close_candev()) or access
an echo_skb that is currently being flushed?

> =20
>  	f81604_unregister_urbs(priv);
> +	cancel_work_sync(&priv->clear_reg_work);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but looking at f81604_start_xmit():

drivers/net/can/usb/f81604.c:f81604_start_xmit() {
[ ... ]
	write_urb =3D usb_alloc_urb(0, GFP_ATOMIC);
	if (!write_urb)
		goto nomem_urb;
[ ... ]
	ret =3D usb_submit_urb(write_urb, GFP_ATOMIC);
[ ... ]
}

The TX URB is created here but is never anchored to priv->urbs_anchor.

When the device is disconnected, f81604_disconnect() frees the netdev. Since
the TX URB is unanchored, f81604_close() does not kill it.

If the uncancelled TX URB completes asynchronously later, would it access t=
he
freed netdev pointer in f81604_write_bulk_callback()?

drivers/net/can/usb/f81604.c:f81604_write_bulk_callback() {
	struct net_device *netdev =3D urb->context;

	if (!netif_device_present(netdev))
		return;
[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak during CAN
bus-off recovery:

drivers/net/can/usb/f81604.c:f81604_set_mode() {
	switch (mode) {
	case CAN_MODE_START:
		ret =3D f81604_start(netdev);
[ ... ]
}

When the device enters CAN_STATE_BUS_OFF, the core schedules bus-off recove=
ry
which invokes f81604_set_mode(..., CAN_MODE_START).

This calls f81604_start() which unconditionally registers URBs:

drivers/net/can/usb/f81604.c:f81604_start() {
[ ... ]
	ret =3D f81604_register_urbs(priv);
	if (ret)
		return ret;
[ ... ]
}

Does this unconditionally allocate and submit a new set of RX and INT URBs
without killing or unregistering the previously active URBs?

[Severity: High]
This is a pre-existing issue, but there appears to be a leaked work struct =
if
f81604_open() fails:

drivers/net/can/usb/f81604.c:f81604_start() {
[ ... ]
	ret =3D f81604_register_urbs(priv);
	if (ret)
		return ret;

	ret =3D f81604_set_normal_mode(priv);
	if (ret) {
		f81604_unregister_urbs(priv);
		return ret;
	}
[ ... ]
}

If f81604_set_normal_mode() fails, the error path unregisters the URBs, but
does not cancel priv->clear_reg_work (which might have been scheduled if an
INT URB completed immediately).

Because the interface was never UP, ndo_stop (f81604_close()) is not called
when the device is unplugged:

drivers/net/can/usb/f81604.c:f81604_disconnect() {
[ ... ]
		unregister_netdev(priv->netdev[i]);
		free_candev(priv->netdev[i]);
[ ... ]
}

Will this cause a use-after-free when the pending clear_reg_work executes
and accesses the freed priv struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-f81604-fix=
-v1-1-c55b5178f9f8@fintek.com.tw?part=3D1
