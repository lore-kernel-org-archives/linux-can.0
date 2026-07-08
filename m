Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228032EDD70
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504175; cv=none; b=QuAgvifbKqAFuF4WjhDKhqgNaCKjgCVvpubQ6G/EB10pNEEyfE3OOu/vbrYdRUZG8ALUdz7DenKV+2Fd97X3T4gPVU9itWJcbQXnOWTQS0umebtcwQ8h8npzupJfqnR8YGA4znHE3AQgrW7feRs5yim6GAMaVjOoymnohAOnzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504175; c=relaxed/simple;
	bh=SzaNlb8jnO46v6Bm+uaNUgz6EhfAWaG2Zbdz7b6VUPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oRLgqGRgkX9Hm9Me4XCfdrnQcsHzNXY7/keiDUZmQFXozCWlatv9PgrGpgybThbwaWz2PdjDXevpBmdL9rNFlj+8pcTqDh3MFFtYXm+6ol09vtXuP4ULFUPQLT5P+MjIz/S/0UFFAYBhwmx8y8afFuGY66gKZS6T3cbHGXnYLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5ZJB/vV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5ZJB/vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7151C1F000E9;
	Wed,  8 Jul 2026 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783504173;
	bh=dcXpjqCGIgp8q5P5H4o2Xh6TbPeYhJNTalWwi79fIYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5ZJB/vVnnU+VWUc75VyMrl1mxf3gttH6IOVi8PA9Zm2VLUlrhXD22p4Gfo4/49l4
	 cBb0vHut71YKFDrlMtmMrDBF/4IKyOdBUTbx8scv1N9SiU5rYarO8j03gNgadiUR4e
	 J9X8NN4B5yHSBLBInqCa80llJ3QxOp3HQTthQ3bgvyO5YGzHXeGcYH+aXQSiKAOUVC
	 o0pEuDmjDV8UO9vSYl1uQ+pYnpmB97JvgcpDmoi92Hbgjldoomigy+VaiXlhLNSVx8
	 MKXiMf0ugmVuqBrT1UQ+6WezSMl9Km+XZOEWxolW8Jzc0SuNO6guCsKeMm0RPSbEKb
	 HyeXPLZE9R/Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v6-9-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-9-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:49:32 +0000
Message-Id: <20260708094933.7151C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignored CAN frames incorrectly overwrite the `rx_stamp` and `rx_if=
index` of pending throttled frames, leading to incorrect metadata delivery =
to userspace.
--

--- Patch [9]: [PATCH v6 9/9] can: bcm: fix data race on rx_stamp/rx_ifinde=
x in bcm_rx_handler() ---
commit 1f01914b41bcf86b5db9980430a19a39e9075e09
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit fixes a data race on op->rx_stamp and op->rx_ifindex by moving
their assignment inside the bcm_rx_update_lock critical section. It also
stops updating them for RTR-request frames.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 4bdca72f9327f..73e3a5fc4342f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -805,6 +800,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
> =20
>  	spin_lock_bh(&op->bcm_rx_update_lock);
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does unconditionally overwriting these
fields corrupt the metadata for pending throttled frames?

If a user configures a BCM socket with a filter (e.g., multiplex nframes > =
1),
bound to all interfaces (ifindex =3D=3D 0), with a throttle timer:

1. A frame arrives on vcan0, matches a mask, and is throttled.
   op->rx_ifindex becomes vcan0.
2. A subsequent frame arrives on vcan1 but does not match any multiplex mas=
k.

Since bcm_rx_handler() unconditionally updates op->rx_ifindex here before
applying the filters, doesn't it overwrite the metadata with vcan1 even
though the frame is ignored?

When the throttle timer expires, bcm_send_to_user() will use this corrupted
op->rx_ifindex to deliver the throttled frame from vcan0, making it appear =
as
if it came from vcan1.

Also, since the bcm_op struct only has one rx_stamp and rx_ifindex field,
doesn't this mean it structurally lacks the capacity to store independent
metadata per multiplex mask if multiple multiplexed frames are throttled
simultaneously?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D9
