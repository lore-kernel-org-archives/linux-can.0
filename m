Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FA448394
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832655; cv=none; b=riGacTXCxyeEXLFw0ta3eIod9LkL25Zj9HD9TuPqlJWu31VQzs4XOTIy0yIdTRCdlT1AvyIm4gRzsGB7XZ9I0GhWWGEHkXdS7R+KjdeQEYcO3LMjTYLPP4K2MamPUk0uipUryWEfOp1qGobde6L2nJBD8yDlGQDfZDSlN3FS12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832655; c=relaxed/simple;
	bh=prCAIEs4TuDktOt79oAseS1flBhsJbwDSIxpPsTkoOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6J9WgAxsoC0FF4hXQKvzqBZuHQ+7+PQ60gHbEeUM2khsdOQCTWj7BKuPrWNqXQj+I2iftJu+Gsh+rvQav4TWVkBbxg/mdcx4AaJ/rOreylZRW7a4kXaOku4Iw64yGIu1AFE2QOftyTwlmfzvXUyTUFC0VQN8WAnaUaMT1eITOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mym135aN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mym135aN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2671F000E9;
	Thu, 27 Aug 2026 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832653;
	bh=1K9TkxBpQR/ZuBIsERdb90lsjTZWNsC7MGt6mcb/yNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mym135aNCuExNyqj2tjYBPfv3cuhH0ztK7j6knCo8EJNdDGSoB/6NdCRLsNOsI7TW
	 LiTH/CK8QSQyaED0k4NDI3+uxV4CK1GcLLsV/79lLQbEIldtlNBCTZd1INlklt7ra7
	 pgLEbAW10lNTbC27W9wsFyw5lMs0Y3Efy6Y99dNgFdVQwRfy4x7X9u1yF8c+FzqYsb
	 6uNRFzb9Cauhw6bJp1KZ0XymVj3fFf1OqlR583CygVLRNrsc7L/LjozmITozXOZpIN
	 feY+PTn9wx9wiv4w1Un/gHH8pjEZ4gj52fzUD2O5WSnhlQ6a3+7O7i6bZ/tjgHVR/b
	 Zk48CAvz0ScIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec
 poll timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260826121036.2706424-12-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-12-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:53 +0000
Message-Id: <20260827121053.6D2671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing dma_rmb() when reading packets from coherent DMA memor=
y.
- [High] Incomplete timer teardown and missing state checks in ndo_stop (kv=
aser_pciefd_stop) causes a polling loop leak, state corruption, and potenti=
al spurious netif_rx calls when the interface is brought down.
--

commit d6148cc43f3a9adbcbc3d9812cbf816bc0ffca1f
Author: Fan Wu <fanwu01@zju.edu.cn>

can: kvaser_pciefd: fix use-after-free in bec poll timer

This commit addresses a use-after-free by switching to timer_shutdown_sync()
in kvaser_pciefd_remove() and kvaser_pciefd_teardown_can_ctrls(). It ensures
the bec_poll_timer callback completes before freeing the CAN device during
module removal or probe errors.

Link: https://patch.msgid.link/20260818063832.383829-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers=
/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> index d8c9bfb202304..a0597db720864 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c

[ ... ]

> @@ -1879,7 +1880,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pd=
ev)
>  		struct kvaser_pciefd_can *can =3D pcie->can[i];
> =20
>  		unregister_candev(can->can.dev);
> -		timer_delete(&can->bec_poll_timer);
> +		timer_shutdown_sync(&can->bec_poll_timer);

[Severity: High]
This is a pre-existing issue, but since you are fixing the timer teardown h=
ere,
does the timer also need to be synced during ndo_stop?

In kvaser_pciefd_stop(), the code uses the non-sync timer_delete:

	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
	timer_delete(&can->bec_poll_timer);
	can->can.state =3D CAN_STATE_STOPPED;

Because this does not wait for the callback to finish, couldn't a pending s=
tatus
request be issued to the hardware right as the interface is brought down?

Furthermore, if a status response arrives via the shared PCIe interrupt aft=
er
the interface is stopped, kvaser_pciefd_handle_status_packet() and
kvaser_pciefd_handle_status_resp() do not seem to check if the device was
intentionally stopped. They overwrite the state to an active state and
unconditionally re-arm the timer:

drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c:kvaser_pciefd_handle_sta=
tus_packet() {
    ...
	if (can->can.state !=3D CAN_STATE_BUS_OFF &&
	    can->can.state !=3D CAN_STATE_ERROR_ACTIVE) {
		mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
	}
    ...
}

Could this lead to an infinite polling loop leak and potential spurious
netif_rx calls on a stopped interface?

[Severity: Critical]
This is also a pre-existing issue, but I noticed a potential memory ordering
issue in kvaser_pciefd_read_packet().

When reading from the coherent DMA buffer:

drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c:kvaser_pciefd_read_packe=
t() {
    ...
	size =3D le32_to_cpu(buffer[pos++]);
	if (!size) {
		*start_pos =3D 0;
		return 0;
	}

	p->header[0] =3D le32_to_cpu(buffer[pos++]);
    ...
}

Is a dma_rmb() needed before reading the packet contents?=20

Without a read memory barrier, weakly ordered CPU architectures might
speculatively read the header and payload before the size read completes.
If the hardware is actively updating the buffer, couldn't the CPU see the
new size but process stale header or payload data that was speculatively
prefetched?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D11
