Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D92DCC13
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306763; cv=none; b=HArRc9pq5odK97zd7iBWp9V40YYYvCIBRc7twZ+5nNlmke06rbmlAkYCKSm5W/mm7ogOO+Bbw3jckY5Rwn7YlbfB2JmEWhl22FXrlYQfPRRZF4QHXSyFAskvzhVf/c+W51yhhbm3eKhWEC2vkQ8HkTRF+6GWkiwJylFAKjrveuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306763; c=relaxed/simple;
	bh=k3KeTOo5540U8fkLnPgTR6rBfq2gEg6cIwSz/yK6kFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2bXR1fm8W4wZy4n+M2/X6krqJfxFDKiwRVAa7NKw0NN7EyJx/sLurMc30TNNKFNHXzpdFOQuk0xyWILPbc1llCVrmzSgs3eFs9skK36frPksWEbRxDRebrw4/hn0ROunFDIrfmsb5B9MRzpIr7kE3bhL3HN42Q/C0f27+/SSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6jWaq1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6jWaq1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1D41F00A3D;
	Fri, 17 Jul 2026 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306762;
	bh=0mvxKzSfgt+z8p4FmdzeOdCAV7Mc+HYEtASDDrREFDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6jWaq1x7TdL6gb+QseLHjzbMBntTRK3Ddw+58JzBcWDGYiryrzOzP+ZQ9Kww2WkM
	 /xH2nypP7PEWYR6zmlLVNdc2s7bLGqAXHJ7F7xxWJ5RaYRrV+OG7A2Y64/RSlF6Mr4
	 UVJv4Tl8Gxai2oxRPiiiwwGrxAWtm2yTFHKlsgQAeQv+aGXN3SKXQVAylk7x7MHU69
	 CeeFsGiu1+yLpDEh7X/rYDSMJ/rjtZTwZTT0J+vrY+oeWaGtGATEq3tDS6GOCY67uI
	 Bx1dxp+cuGL6NdRZrId1evberPytCNta6wxMkQf0ELarNP48NBXLglp4GKJIN4TFPx
	 sh+JhtXaX0WDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 15/19] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260716155528.809908-16-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-16-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:01 +0000
Message-Id: <20260717164601.DA1D41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional update of `op->rx_stamp` and `op->rx_ifindex` corrup=
ts metadata for throttled or multiplexed CAN frames.
--

--- Patch [15]: [PATCH net 15/19] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit e05fd3b3c775fc8bd3bab9bce2bc9f1a23e5fc07
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This patch fixes a data race on op->rx_stamp and op->rx_ifindex in
bcm_rx_handler() by moving their assignments into the bcm_rx_update_lock
critical section. This ensures the CAN content and metadata are bundled
correctly without torn stores on 32-bit platforms. As a side effect,
RTR-request frames no longer update these fields since only the notification
path needs them.

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-10-562f7e3e42da@hartk=
opp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a53dba6ab8b89..f213a0b377915 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -836,6 +831,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;
> +

[Severity: High]
This is a pre-existing issue, but since the commit message states the goal
is to report the timestamp/ifindex of the very same frame whose content it
is delivering, does the unconditional assignment here still leave the
metadata vulnerable to being corrupted by subsequent frames?

If a CAN frame matches a BCM filter and is throttled, it is queued and the
throttle timer starts. Before the timer expires, if another CAN frame with
the same CAN ID arrives, it will unconditionally overwrite op->rx_stamp and
op->rx_ifindex here.

If this new frame is discarded by multiplex filters, won't
bcm_rx_thr_flush() end up sending the previously throttled frame to
userspace using the overwritten metadata of the discarded frame?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D15
