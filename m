Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56B3DDAFC
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407395; cv=none; b=kwDmNfdC6NBZOZCs1gQDj+QVcy5AQCBPhAzq/SUJFu6nHKml8c6LyVfQHeF5E/OBcjNAqONz14X9im+lv8vOlz0hxKr6Yr5O5VR5o7mIN8+eUoGCyh6yu+8dp4P3xC1xn3HASaWHur5rZhCYHb3b/s0xTTmJnBGU/jLrGL7OXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407395; c=relaxed/simple;
	bh=qS2rCn2uhRXBxThKCGJY8DO+V4KygcKuDoGBVhEbRPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKjaifKgp/Csr3SCc0cX5mAwbnRQoNYbuiMcvObCyucROF0mfQ4kEEqwDU7+kNwEZVePvTLFtf+hcPG1nt1OvVB6HTZ/Fdd4tzI2nEA3Nu8pTYAGKUQaLwsDD6AgUuo5ILFQE39fjpx81qCGiBdUILJ97QhEoBtPNW1keWGq0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWRSCfoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWRSCfoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E6E1F00A3D;
	Thu, 30 Jul 2026 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407393;
	bh=g0pmJDzREEvHrkGBVDog9sTDWdS8T69999fEOJvqfMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWRSCfoUWSw/Y4s7XEsL8Bn2WL1f7svYiY53ngTNfgs3zKUicnF+qslEgkgoawVak
	 329qtdgnF3nu8AYPfPZ3Q4N7HAmk7ZCqd0fjqNL4je3M82rlxa01SWt/kJHwLLuHJU
	 nuEQU3kcFAf7T+onpIbRdr1n3zrj7IEbZhObpar8VkvRx4woyY82cNnAH7VHRsJgH3
	 OY8EoWvfTkXNsyFExnDuZ/IZSJF6rQ4SI09FaDNYXpSHrgdlorVLSZCllFaFzX7yBU
	 GfXD6uGLRddNfWZUJWnWkb1LHDTx7k9h3W0UwWgzRbBTHUAuvrFCouCfdbny+RpQ/0
	 bQsgYTot8dKzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 11/20] can: peak_usb: peak_usb_start(): fix double
 free of transfer buffer on URB submit error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260729102802.505168-12-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-12-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:53 +0000
Message-Id: <20260730102953.69E6E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in TX path if TX URBs were partially allo=
cated during device start.
- [Medium] In-flight TX URBs and their transfer buffers are permanently lea=
ked when the CAN interface is brought down.
--

--- Patch [11]: [PATCH net 11/20] can: peak_usb: peak_usb_start(): fix doub=
le free of transfer buffer on URB submit error ---
commit 0de6a57bc3019e9140f22ba4065f241bf08735cd
Author: Maoyi Xie <maoyixie.tju@gmail.com>

can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB =
submit error

This patch removes a redundant kfree() in the RX URB error path to prevent a
double-free. Because URB_FREE_BUFFER is set, usb_free_urb() already releases
the transfer buffer.

Closes: https://lore.kernel.org/linux-can/178159320216.2154888.169534517937=
88581739@maoyixie.com/T/#u
Link: https://patch.msgid.link/178163373110.2507866.216458825145756798@maoy=
ixie.com

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index c7933d1acc99a..55aad01cd8cac 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -470,7 +470,6 @@ static int peak_usb_start(struct peak_usb_device *dev)
>  				netif_device_detach(dev->netdev);
> =20
>  			usb_unanchor_urb(urb);
> -			kfree(buf);
>  			usb_free_urb(urb);
>  			break;
>  		}

[Severity: High]
This is a pre-existing issue, but does this code cause a NULL pointer
dereference when accessing urb->transfer_buffer?

If usb_alloc_urb() fails after the first allocation in peak_usb_start(), it
leaves unallocated contexts with urb =3D=3D NULL and
echo_index =3D=3D PCAN_USB_MAX_TX_URBS:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_start() {
    ...
	/* pre-alloc tx buffers and corresponding urbs */
	for (i =3D 0; i < PCAN_USB_MAX_TX_URBS; i++) {
        ...
		urb =3D usb_alloc_urb(0, GFP_KERNEL);
		if (!urb) {
			err =3D -ENOMEM;
			break;
		}
        ...
	}

	/* warn if we were not able to allocate enough tx contexts */
	if (i < PCAN_USB_MAX_TX_URBS) {
		if (i =3D=3D 0) {
			netdev_err(netdev, "couldn't setup any tx URB\n");
			goto err_tx;
		}
		netdev_warn(netdev, "tx performance may be slow\n");
	}
    ...
}

Since the network queue isn't stopped based on the successful allocation co=
unt,
can peak_usb_ndo_start_xmit() pick an unallocated context and dereference
a NULL urb pointer?

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_ndo_start_xmit() {
    ...
	for (i =3D 0; i < PCAN_USB_MAX_TX_URBS; i++)
		if (dev->tx_contexts[i].echo_index =3D=3D PCAN_USB_MAX_TX_URBS) {
			context =3D dev->tx_contexts + i;
			break;
		}

	if (!context) {
		/* should not occur except during restart */
		return NETDEV_TX_BUSY;
	}

	urb =3D context->urb;
	obuf =3D urb->transfer_buffer;
    ...
}


[Severity: Medium]
This is a pre-existing issue, but does this leak struct urb and
transfer_buffer allocations?

When the interface is brought down, peak_usb_unlink_all_urbs() skips calling
usb_free_urb() on in-flight TX URBs, assuming the USB core will free them:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_unlink_all_urbs() {
    ...
		if (!urb ||
		    dev->tx_contexts[i].echo_index !=3D PCAN_USB_MAX_TX_URBS) {
			/*
			 * this urb is already released or always submitted,
			 * let usb core free by itself
			 */
			continue;
		}
    ...
}

However, the driver holds a base reference from usb_alloc_urb(). When the
interface is brought back up, peak_usb_start() allocates new URBs and
overwrites the pointers, permanently leaking the previous allocations:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_start() {
    ...
		context =3D dev->tx_contexts + i;
		context->dev =3D dev;
		context->urb =3D urb;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D11
