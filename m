Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196ED381B02
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029867; cv=none; b=OUGFGrXDmrj/43SOpLgFRd5hEuSEJFwyrm81m6o1NkBJ2p6D8irKSN1eDHrxm2wkVyGZ3u+ymnsxOSTFlggwm1fyzOZVaRvUjnp5jzt0uWIjtNL0P/ypJgqEvUjuLJRz7xAHiy3HNbzHj9A99zhjnR/D1ZPm/dHlml4mGU3rEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029867; c=relaxed/simple;
	bh=40eTf30ZNBZfv9xeIsawtlYbB0ZRwfcF+x62VfZuj3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9DixrFbMR3cAE40Yeqr0ccSbFxA2C1sOpTcGjBGr+WsOWmy01AMpVM8axA27GBUCGGX4T1Pu97hI4Hu6pmp3tD6rsbAWNpu27UgwVoR5XHq1jYEFiT1WrMOpQKw0jmAK+ld8qugtp8PPegerF7wlTYWAfr2v9ZNjeVC12YBl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/QvmgIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/QvmgIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF9B1F000E9;
	Tue, 14 Jul 2026 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029865;
	bh=yM0xBBtcvlMXp8BqmkwVqVr/MetbJcvIQylrz8dcrh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/QvmgIJVayn83SFuCw95qEk7DqFXRajmnlPO62kd7yI4MZ45JBSXBFiQHc7JS/GX
	 Lbt67LJyy4AgcZ6ngM+SQkx54IuYKe8oVLOwD6yHLfzENij5b36VbhbMACJrEC6CPB
	 Sfqpdy4R2rK/jXqkt+xTkYr7TFbAcZP6m/74nF0rqUv2Fscc+kOiPxGUgr+GbuMOhT
	 W7d6PErD/bJDX9OEkQypLEPYlPRrxBFH7IxktWmEPGsTj3S4FmGwTmgMKSwnBXuvK4
	 Jg+H/0mxXi9dAUAu37QmTAYa+KtbZ6vNQ8m4KjPFXaqck5S8AN1kTM+VRsTKBKmXjg
	 BG113DlW+N6tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v14-2-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-2-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:51:04 +0000
Message-Id: <20260714115105.5AF9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race when updating CAN frames locklessly allows transmission =
of torn or partially updated frames and incorrect RX filtering.
--

--- Patch [2]: [PATCH v14 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 23919fa17f26320455e758411c450420d522db0a
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition where bcm_sendmsg() reads bo->ifindex
and checks bo->bound locklessly while concurrent updates modify them,
preventing inconsistent socket bindings. It also ensures bcm_rx_setup()
returns an error when a requested device is concurrently removed instead of
silently failing.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(sock_net(sk), ifindex);
> -			if (!dev)
> -				return -ENODEV;
> +			if (!dev) {
> +				ret =3D -ENODEV;
> +				goto out_release;
> +			}
> =20
>  			if (dev->type !=3D ARPHRD_CAN) {
>  				dev_put(dev);
> -				return -ENODEV;
> +				ret =3D -ENODEV;
> +				goto out_release;
>  			}
> =20
>  			dev_put(dev);
>  		}
>  	}
> =20
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:
[Severity: High]
This isn't a bug introduced by this patch, but is there a data race when
updating CAN frames locklessly?

Looking at bcm_tx_setup(), it writes directly to op->frames using data from
userspace without holding any lock to synchronize with the timer:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Could the timer function bcm_can_tx() locklessly read op->frames and
transmit torn data if it races with bcm_tx_setup()?

net/can/bcm.c:bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);
    ...
}

Similarly, bcm_rx_setup() updates RX filters locklessly:

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
}

Does this allow the RX softirq handler to evaluate incoming CAN frames agai=
nst
partially written filters in bcm_rx_handler()?

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
    ...
}

Since memcpy_from_msg() can sleep on page faults, the data might be in a
partially written state for an extended period. Is it possible to copy the
data to a temporary buffer first, and then update op->frames under the
appropriate spinlocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D2
