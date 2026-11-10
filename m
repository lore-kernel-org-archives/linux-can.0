Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283395;
	b=h419QA30kt4oRtJ7eIBV6SDJnBzMF/hKMVt2oakrmqL814ub8dbwdm86yCDV+Py8A8rY
	 hpnH2YZdOogknekKnGKvFwxM8BFIS8EDwRNNFb9vkzk7k++h4SdwYrkRiIJIO/AVJfW3U
	 GhdafK7KncpR5Tde2RZ4qRCyGwWtLWIo9tpUeNpWNws95enukXzbKntfBrQHBoHam34XB
	 YkfXkSbPvSDX67E5ybXpQ8rN1SBR/qYkNjHYP7JOVMfYXNrR1vyCsDi8BFI9zDn/hwiyH
	 R5cLg56AnNunWMz4LLqAc8gmfbLfnHkxhUx39e449AvIUEsLkTvpEjiPiVWc3y570xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZLpk/484REO22NGlVI1EKPyVBXVr/bZtmjPZAnw7jzU=;
	b=GRux4094IRue/oOIFwO+khB4v0n86Lm7lTLqrU7Q7/VIxZtSMJj9x55XwzkHpiiyuaUG
	 7rXTVmIh3ZepjPr/ielzBG9lW15q+jpnebedtBM1wcW1VJuybzs1iWUowSHke8SSdGXAq
	 MyNBMFTGL9OcdMmgYA1Sb/Ndn3ZLemvQewypF6L5WITP0NUFaIdn45F7s9HHBrt9FjtY1
	 mndEEtJydBaG7qpd/vZjVpkDKBTfioly23o37+wbYPEZqLxHjv2LO4MBQILcJWhjoSsh3
	 R19GZTujp28vf8lEPemBAXrH98M2yLWfSVs0walZaADMdtBUtWq93AbTp70Q2G7sMog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyRsVlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534F606A321
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyyRsVlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104081F0089F;
	Tue, 10 Nov 2026 04:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283395;
	bh=ZLpk/484REO22NGlVI1EKPyVBXVr/bZtmjPZAnw7jzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyyRsVlvAQ0rN7AHeFFPHg6ezdFrGUPM/bQKq4HkyVweKGT/qKDzHz/o6thBv9dsu
	 bVpOkHpmZw6oLNgn5KMNAxW8Cv+KcxZoluCmFznP7CTsLQFuTm51Gh114vZ3aV5FSi
	 b1UEU2pVHzYEJc6JQ8vtm25cmkzr4jy5NeoSIIKaynEopUBZdNGER5IwMCjZKXQY4+
	 eDMa189LfK7p2kbIFAsbmY45rBjRj5LqA2v5hLmA8X0pNkXWO78kLwsuhOcdqeqSpH
	 UK9kwY3wU6G6Qz1IdNmqXg8WT+l0apTCjshKK5dZUIOnFw0gPkv0n1JxjuFIS/R7l+
	 P1E7IyxemBePA==
Message-ID: <sashiko-outbox-206162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: pcan_usb_fd: check that the channel has
 a device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joas Antonio dos Santos" <joasantonio108@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110-pcan-usb-fd-nodev-v1-1-fc11effbfafa@gmail.com>
References: <20261110-pcan-usb-fd-nodev-v1-1-fc11effbfafa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:03:14 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] can: peak_usb: missing PCAN_USB_STATE_STARTED check in
  pcan_usb_fd_decode_buf() [1]
--

commit b1428d71020b5f4ac8a4435284c960096e6c1169
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

can: peak_usb: pcan_usb_fd: check that the channel has a device

This commit checks that the per-channel device pointer looked up in
usb_if->dev[] is non-NULL in the four pcan_usb_fd RX decoders before
dereferencing it.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 39f0740421c36..c42cac2126404 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -609,6 +612,9 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_=
fd_if *usb_if,
>  		return -ENOMEM;
> =20
>  	dev =3D usb_if->dev[pucan_stmsg_get_channel(sm)];
> +	if (!dev)
> +		return -ENODEV;
> +
>  	pdev =3D container_of(dev, struct pcan_usb_fd_device, dev);
>  	netdev =3D dev->netdev;

[Severity: Critical]
This problem wasn't introduced by this patch, but can these decoders still
process messages for a stopped channel [1] when a sibling channel on
the same adapter remains open?

On multi-channel adapters that share a bulk IN endpoint,
peak_usb_read_bulk_callback() checks PCAN_USB_STATE_STARTED only on
urb->context before calling pcan_usb_fd_decode_buf().  None of the four
decoders check whether the target channel looked up in usb_if->dev[] has
PCAN_USB_STATE_STARTED set.

If a PUCAN_BUS_BUSOFF status message is decoded for a channel that has
already been closed via peak_usb_ndo_stop(), pcan_usb_fd_decode_status()
calls can_bus_off() and re-arms dev->can.restart_work after close_candev()
canceled it.  That work can then restart the closed controller, or cause a
use-after-free if the USB device is disconnected and freed before the
delayed work runs.

[1] https://sashiko.dev/#/bug/linux-a0866161-9660-4bc4-9535-9260486564d9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-pcan-usb-f=
d-nodev-v1-1-fc11effbfafa@gmail.com?part=3D1
