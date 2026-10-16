Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F43CF673
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144227; cv=none; b=EmwdOot0s7tZCoD8WLd2CyP/nPzOudx+4MppQyiHeDTNQ1H7JWhD05CgBgGaEUQDbKQu0V88OPsa+Y1njSbqZwSdOJH39dzUzK+3VABK9eKfojequ82BFM3RvODJOR5Ciqh9fiBtpoiNCTO8Hkd9KoGQ91Gv4sdWxTccva+mmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144227; c=relaxed/simple;
	bh=vYd3Ky1giYh2GRViQjpRSH3dhjjGdFYaNjlp07E9HuE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n4BuDbKG6Z9hhZR1T/pfXmOGukvdRes5VcH0xx47pN93AP6yIods33Jy7xK/YJv8S5AKZhtCd7451Crf6BYCOkmwrC7llyKTEdrLZyydTgu2e4v/mp76bLdf1DipdcVk7tn+pDCCEvfLNk4WizBKVKmIXf9wYx4Gw8zmpxQqR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keT3MeXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keT3MeXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163D51F000C4;
	Fri, 16 Oct 2026 09:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144226;
	bh=qMf5xhg46SpSGYUNZTRDq//HwB96RjXNohbVRPFI0Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keT3MeXAvs33YpQXBSzqcwJBQtm/xAY3p3WweaMmAWGZq4AoNcBWM5rFmUJY0W4O7
	 2lN++iAdTU6Mzm5W5QkulMmmZqfo2mfaRx3rLp8/EHPBMhr8DwOYMiZECtbrlUn94S
	 jKn9yoohTHrHuilk/huivVCjHFbynFgrkxytPyIFNtGTvVAxB2xPo1HkFkRigH0Bw9
	 915zPMJ7ad2PttNTY4rCH7xAClcUQdyn+8LQ3l6QMh0wLFblekZ8bRESOKUF1tc84Q
	 MkYrvpDcGBevgZEXJJPa1QK6jER5cV5yPP42AeoNV5Jp1P2egTog8nPh4mirHNKpr7
	 pUlaT1kekToYw==
Message-ID: <sashiko-outbox-174104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261016093525.327367-1-socketcan@hartkopp.net>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:50:25 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: isotp: silent bind() failure if can_rx_register() returns -=
ENOMEM
--

commit 95cbcd2505f7f236f0737cc7471505243facbfe5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: replace ARPHRD_CAN type checks with can_get_ml_priv()

This commit replaces explicit ARPHRD_CAN hardware type checks with
can_get_ml_priv() to prevent NULL pointer dereferences when a TUN/TAP
device is repurposed to mimic a CAN device.

Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index f5dc9d04bd686..6c28802c0605f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct s=
ockaddr_unsized *uaddr, int l
>  		err =3D -ENODEV;
>  		goto out;
>  	}
> -	if (dev->type !=3D ARPHRD_CAN) {
> +	if (!can_get_ml_priv(dev)) {
>  		err =3D -ENODEV;
>  		goto out_put_dev;
>  	}

[Severity: Medium]
A few lines lower in isotp_bind(), the return values of can_rx_register()
are ignored:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, "isotp", sk);

	/* no consecutive frame echo skb in flight */
	WRITE_ONCE(so->cfecho, 0);

	/* register for echo skb's */
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, "isotpe", sk);

If can_rx_register() fails (for example, returning -ENOMEM due to a failed
kmem_cache_alloc()), bind() will succeed but the socket is not fully
registered to receive CAN frames. This leads to a silent failure where
user-space believes the socket is successfully bound, but no traffic will
ever be received.

Could this regression be prevented by checking the return values and
propagating the error appropriately, or cleaning up any partial
registrations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093525.3273=
67-1-socketcan@hartkopp.net?part=3D1
