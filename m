Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708039CD1B
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049351; cv=none; b=mC+fvP419WnLMXVOIhaijtvYZgQgdo0RVE1Frz7UCUsqC/dUH/ZqFmc4c2Fs7efKtHGbivmCFex/hlpKt7TGmOx6h5Szms+PXEpUop3cX+mxqsiwSBZ43xCkSKHAuLN6jfvxqcD2QlzCe9FRavunPb65m1iPeMTMidxpjdrts8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049351; c=relaxed/simple;
	bh=Mac9Ofmpxvw3KP2zY01yDLufpxxD/boBrGGGKltSnFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAwliMXRYh+k+x+42AOu18ISbh8gI0IiLrLLp//MuAFraCXI6MKE0xQjPl88nQiMxrYnYvSuHKgd6y9OmhCdAh/eqeb5aXgYZdJt+QHIWj5+bTrFqFyRgh+b0HIs8NhSUBC15yTO4U+/G4dZOd4h6A1aGfhgbAqXjghg4Pd2XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EglhuWtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EglhuWtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331C1F000E9;
	Tue, 14 Jul 2026 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049350;
	bh=NjXn18Qvi4UrjkyJ0iI0eWMA6UGo7OF9XdLcMYnQmTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EglhuWtVasFlE6ZPv261GukHZ5buFkL2Rm/h50FQtJ7dxvwM24NnQ99JettjE7mw+
	 PtKh8Y9O3oGfUe3jAOZfvA2jxK5eFUbFJgFiSWAy1tyPxN6UIc99by5jwWsl3K6a1I
	 jruXKujnhr9/BikqPZ6Mx51/rhseAdHoXH01csKCKtJuqRbRfQyHB7GAjcQdqySbCv
	 E/wgHbxsU7Xg4tqmRDV3LxGDOAcpoe7RpyWvR0+v/NSedcVWLId23559xBu5Zd0g5E
	 xtMaGB3FoL9hJN1fn71baFwFnOheEnzwFSr8897KyP3A1UdysgLJXFRAeS3bNH2O7Y
	 qi17Nzk/43Oig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/11] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-10-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:15:49 +0000
Message-Id: <20260714171549.E331C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmatched or multiplexed frames overwrite global metadata (rx_stam=
p/rx_ifindex), corrupting subsequent throttled frame notifications.
--

--- Patch [10]: [PATCH v15 10/11] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit 192a4832f1f8f3051e71e66a1a0dc3b893e46cc8
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit addresses a data race on op->rx_stamp and op->rx_ifindex in
bcm_rx_handler(). It moves the assignment of these fields into the same
spin_lock_bh() critical section as the content comparison, preventing torn
stores on 32-bit platforms and ensuring CAN frame metadata is correctly
bundled when processing concurrently on different CPUs.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

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
This isn't a bug introduced by this patch, but do unmatched or multiplexed
frames overwrite global metadata here in bcm_rx_handler(), corrupting subse=
quent
throttled frame notifications?

Since the assignments to op->rx_stamp and op->rx_ifindex happen uncondition=
ally
before the multiplex filter checks, a frame that matches the CAN ID but fai=
ls
the multiplex mask check will still update the metadata.

If a previous frame matched a multiplex mask and was queued for throttle
delivery, could it be flushed to userspace with the timestamp and ifindex o=
f the
dropped frame instead?

Additionally, if an operation tracks multiple indices (nframes > 1), would
concurrently throttled frames sharing the single global op->rx_stamp inevit=
ably
overwrite each other's metadata?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,
>  				       traffic_flags);
>  		goto rx_starttimer;
>  	}
> =20
>  	if (op->nframes =3D=3D 1) {
>  		/* simple compare with index 0 */
>  		bcm_rx_cmp_to_index(op, 0, rxframe, traffic_flags);
>  		goto rx_starttimer;
>  	}
> =20
>  	if (op->nframes > 1) {
>  		/*
>  		 * multiplex compare
>  		 *
>  		 * find the first multiplex mask that fits.
>  		 * Remark: The MUX-mask is stored in index 0 - but only the
>  		 * first 64 bits of the frame data[] are relevant (CAN FD)
>  		 */
> =20
>  		for (i =3D 1; i < op->nframes; i++) {
>  			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
>  			    (get_u64(op->frames, 0) &
>  			     get_u64(op->frames + op->cfsiz * i, 0))) {
>  				bcm_rx_cmp_to_index(op, i, rxframe,
>  						    traffic_flags);
>  				break;
>  			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D10
