Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152017;
	b=IY/WTjShrPMgz+KSPvNjQObUsko3tYF1RXmW3cbo7SbY5y81XkAAzQT7gq6Z+QlgQiv6
	 tHbnfxEuXwgwXtjI4uF+AX8B301g5ye5QnqaC998UP4b5r/lmPHC+A0S7g33e25XA8Ja9
	 HQQ9i2PsyTNqXiGW+WajAsvGIigcBtfDlbtSkOW8EXdQde0DgkRJPFfpCncwhutzDLWYM
	 nKyoY5t5lGg4fY9IcTwfy9VByq7StktGL+CfAmgo5FLebLOjspDuUv3bdggPRALd6tX0s
	 PgSQxkah63I1P8RD10pnQBXVc7Ek6gSMACP4vEwiTFwM+Pb3k9rLVY6teiujdhOd2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FM4PnIt7TEaKaVFQ2FVlYSSxOW8NEz98R2NH7kVhHtY=;
	b=JgrEXLEwFHyR0bCGhbV/JydkmAiT6BP+nl56Xd5BMifI2vtbGgX3/U+yTpuuyM3S3bWe
	 hVRmxKMrJtjCsHYxUp5EWWVZQdSmoumHzvIlGGiCRCw9QfSO6aE585b0ifIrwPyRsSkZ3
	 4y2Uw/dAvLdT60x1kTXJS7iGdLiIRtkzqXulPd8PzFMSe19nkLzRh9z/ubU8MQGf6MOC3
	 FyM2ogL27foHn3AqOfqb6s+dml/5rYIKLLRBtI6s5j+dBQUDoU8PGbltRTd24TfLb6XJ1
	 nn9Dkf2BWw3OGGGo9ci5cd5tVGt/nwwigHkLwjRXiNQTao8j4vxiLH7EbwgGH+TMTWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZpo389n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929D606A31C
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZpo389n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC11F0089F;
	Sun,  8 Nov 2026 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794152016;
	bh=FM4PnIt7TEaKaVFQ2FVlYSSxOW8NEz98R2NH7kVhHtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZpo389nYVcsyca48E0h7OmQ8w+fA5Ja2t9O/9DgulQpv8pl7mbQYXRKHi0OPrtdW
	 5wUawvUPyKYBm9OBK6nFrls4AnAzxG6px2cqAVk8hAU8KtRnWocRrYrjh7kELk/Bx1
	 28zre1tsj5Yx933UtSmHNlfqDq1Iy7cUmkPtI2ugG4CIwHEWdRofm7gsHBe+SsUYY5
	 +pjAeS+PuPeoHETD8xteKm8sxl4Fi/E475ueOnYwyeFtROUEHn6/lJGv9YgyrGKS7Z
	 v1ZfOB+KAqBlgZNLqBCqnT4sqZ0hvWjeFDZoAweg5K7L1k7MDSY7YmNfZ7SZTHYM9R
	 UFxrZ4WtkEsDg==
Message-ID: <sashiko-outbox-203833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop
 to avoid use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261107153319.3765325-1-hj351016@gmail.com>
References: <20261107153319.3765325-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 15:33:36 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: peak_usb: in-flight restart URB arms timer after
  pcan_usb_stop()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] can: peak_usb: incomplete restart_timer cleanup in
  peak_usb_create_dev() [1]
--

commit 711582c698eedc1cd7434111f52222eb7dcd4279
Author: Hyunjung Ko <hj351016@gmail.com>

can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-fr=
ee

This commit adds a dev_stop callback to pcan_usb that calls
timer_delete_sync() on pdev->restart_timer when the interface is stopped.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..4c131958b5aa6 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *de=
v)
>  	return pcan_usb_set_ext_vcc(dev, 0);
>  }
> =20
> +static int pcan_usb_stop(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev);
> +
> +	timer_delete_sync(&pdev->restart_timer);
> +	return 0;
> +}

[Severity: Medium]
Can an in-flight restart URB complete after pcan_usb_stop() and re-arm
pdev->restart_timer?

pcan_usb_restart_async() submits its bulk URB without anchoring it to
dev->tx_submitted, so peak_usb_unlink_all_urbs() does not kill it before
calling dev_stop().  In addition, pcan_usb_restart_pending() unconditionally
calls mod_timer(&pdev->restart_timer, ...) without checking urb->status or
PCAN_USB_STATE_STARTED:

CPU0                              CPU1
can_restart()
  ...
    pcan_usb_restart_async()
      usb_submit_urb(urb, ...)
peak_usb_ndo_stop()
  peak_usb_unlink_all_urbs(dev)
  pcan_usb_stop(dev)
    timer_delete_sync(&pdev->restart_timer)
                                  pcan_usb_restart_pending(urb)
                                    mod_timer(&pdev->restart_timer, ...)
  ...
  free_candev(netdev)
                                  pcan_usb_restart()
                                    peak_usb_restart_complete(&pdev->dev)
                                      <-- use-after-free

If the interface remains registered, pcan_usb_restart() marks a stopped
interface as CAN_STATE_ERROR_ACTIVE and wakes its queue; if the USB device
disconnects after peak_usb_ndo_stop() has cleared IFF_UP, unregister_candev=
()
does not call peak_usb_ndo_stop() again and free_candev() frees pdev while
restart_timer is still armed.

Anchoring the restart URB so peak_usb_unlink_all_urbs() kills it before
pcan_usb_stop(), or only arming restart_timer in pcan_usb_restart_pending()
when urb->status =3D=3D 0 and PCAN_USB_STATE_STARTED is set, would close th=
is
race.

> +
>  static int pcan_usb_init(struct peak_usb_device *dev)
>  {
>  	struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev);

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failed probe in
peak_usb_create_dev() free netdev while pdev->restart_timer is still armed
[1]?

peak_usb_create_dev() calls register_candev(netdev) before calling
dev->adapter->dev_init() (pcan_usb_init()) and dev->adapter->dev_set_bus():

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
	...
	err =3D register_candev(netdev);
	if (err) {
		...
		goto lbl_restore_intf_data;
	}
	...
	if (dev->adapter->dev_init) {
		err =3D dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
	}

	/* set bus off */
	if (dev->adapter->dev_set_bus) {
		err =3D dev->adapter->dev_set_bus(dev, 0);
		if (err)
			goto adap_dev_free;
	}
	...
adap_dev_free:
	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);
	...
lbl_free_candev:
	free_candev(netdev);
}

Because register_candev() publishes the netdev and drops rtnl_lock before
pcan_usb_init() or dev_set_bus() blocks on USB bulk transfers, another
context can open the device and trigger a bus-off restart via
pcan_usb_restart_async().  If pcan_usb_get_serial() fails in pcan_usb_init(=
),
or if an in-flight restart URB completes after unregister_candev(),
free_candev() frees pdev while restart_timer is pending, causing a
use-after-free when pcan_usb_restart() fires.

[1] https://sashiko.dev/#/bug/linux-c6d07ad0-7ac4-41cf-a567-927ba96a5e93

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107153319.3765=
325-1-hj351016@gmail.com?part=3D1
