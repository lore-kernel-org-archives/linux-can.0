Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3A72630
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532861; cv=none; b=C6IqdozrBgQBGIFCiXaY1tK7jP9A/quanKlu4lc8Oa0DO+xfl5l+mmoy7hEvBgGoOALySR+kjO4ZtyJJ7bXqHK/j9vRxEEDNwT97r3ogwMyIufnXqbaq+j9siaLQxHko4IuVJjHd3Xjq63njlFJgcFZw1TspkHK3aXChzCilG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532861; c=relaxed/simple;
	bh=nj9Q6n8JV1x10KM5LoEYcL9864FxJPaaDhORjKqEUFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kg211biU3b1U+6vUmu0iz75ykfY5FSVNXGaz4s2wfFnaZQZKDLOKZX8wfeZ8ItloPLc/eDGivWxFubR+VJRSomPXP6tPzAaeAs5IHcvoR8ngE1iYvK/I29Nv2pUF0cz7ZQ0MBaLOdfbWG6r6/PsRALGlQBQRVE6PdOy+gTI/yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAi90miA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAi90miA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1111F000E9;
	Wed,  8 Jul 2026 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532859;
	bh=1R19t2YAzdghZMNdzPebTUzxHYBWFcshIND05hdihMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAi90miAGYZKfGWc1Ac8TB059SHrUvRhf5FJhZzQtSBKBeMuoN+Pjf/vScbQRfd7E
	 x3Qzkp4VrgJ9hRx+UERInIwWQk6Ivy2kpSKafiU4MwuwcjH0vSx52OzkcRTB13SDOo
	 137fmnmvcw89TPVLfcS3U70NBsOV2sROwLoDlhPNyuWgCFYLgE1QZHi7qk83pUZ5ib
	 6srB4304neT9v1ydpsa0ivTR8vMWRAEJFn2k4KRkw6hCL/qt7wyHq1VqB6VQszzxFG
	 mRQ5vLhB505a7UJCEZQk/zu7KM/aHa1lNXzqyWZd7SJQ66iPVIsYx6cTTyyWkX9JgR
	 StSuHuzvitZkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v8-10-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-10-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:47:39 +0000
Message-Id: <20260708174739.7E1111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fails =
to fully resolve the issue it claims to fix: Metadata mismatch for delayed/=
throttled CAN frames. `op->rx_stamp` and `op->rx_ifindex` are overwritten b=
y subsequent frames, causing delayed frames to be delivered with incorrect =
timestamps and originator ifindexes.
--

--- Patch [10]: [PATCH v8 10/10] can: bcm: fix data race on rx_stamp/rx_ifi=
ndex in bcm_rx_handler() ---
commit 1903094034673eeaf05aa58b49f4d0ff45d06795
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit addresses data races and torn stores on rx_stamp and rx_ifindex
by moving their assignment inside the bcm_rx_update_lock section in
bcm_rx_handler(). It ensures CAN content and metadata are bundled correctly.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 66dd8789843b5..1986d33a7d279 100644
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
This isn't a bug introduced by this patch, but does this fully resolve the
metadata mismatch for delayed or throttled CAN frames?

Since op->rx_stamp and op->rx_ifindex are unconditionally updated here, will
they overwrite the metadata corresponding to pending throttled frames?

If an application configures a BCM socket with a throttle timer (kt_ival2 >=
 0)
and a frame is marked for delayed delivery, a subsequent frame arriving bef=
ore
the timer expires will overwrite this global metadata.

When the timer expires and the delayed frame is eventually flushed to user
space via bcm_send_to_user(), it will be sent with the clobbered
op->rx_ifindex rather than the interface it originally arrived on. Could th=
is
lead to the user application receiving an incorrect source interface and
potentially responding on the wrong CAN bus?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D10
