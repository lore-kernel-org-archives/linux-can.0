Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17154396D2C
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446906; cv=none; b=aMkGY+ekKRuwWHlppXkazuoZhRCak+1GDwKAUscEMPx8DAlGr+x+rnbQWErGjY5Iu7Cu4JAfpMOZiaTpjq2S7FHExXHnPI4UgVhXnAswBoKjIbtc57ZW/k4MJ2vsNrH2VkuYL7HCPMNRtef7DITggbDGji1TdLJDZPWKjCulaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446906; c=relaxed/simple;
	bh=GxD4DtaQodP7yPhOPT5Q5lNKa6fAB+ZgzU9YCgWD0j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuyEDDt82ozllviDHyJRfcD6QfALNzs8SzbWom+Yb9y1ziv684VVyTgNtshDvxyT/0BvUJVES9CwWhmBcHpc5ZvF9VLBcAQrMWtTXMR0O/afLQNQonIt7QcbHtpdiaKClJDkhlTFsPOnBwvoW/kJ9cSZUrKrQFO4r0jdqDJ/NGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0PD-0002vh-69; Mon, 02 Mar 2026 11:21:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0PB-003MYz-0n;
	Mon, 02 Mar 2026 11:21:38 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 479214F5067;
	Mon, 02 Mar 2026 10:21:38 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:21:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
Message-ID: <20260302-gregarious-poetic-wasp-e73cee-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
 <20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22w6pxgedggtqmin"
Content-Disposition: inline
In-Reply-To: <20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--22w6pxgedggtqmin
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
MIME-Version: 1.0

The nipa/ai-review bot found these problems:

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3D873e6dfb-7d8e-4f4d-9=
8ef-a89fcedb701a

commit 6ea1c1c7064ff2b5c2a0434ec61d62fd3463fc12
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This commit addresses a KCSAN-detected data race in the CAN BCM protocol
by adding locking to protect simultaneous access to timer and filter values
during updates in bcm_rx_setup(). The race was benign functionally but is
resolved by introducing spin_lock_bh() protection.

Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE=
@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fd9fa072881e..0a3dc5500e14 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -125,6 +125,7 @@ struct bcm_op {
>  	struct sock *sk;
>  	struct net_device *rx_reg_dev;
>  	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
> +	spinlock_t bcm_rx_update_lock; /* protect update of filter data */
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The comment says this lock protects "update of filter data" but the lock
is also used to protect timer data updates (ival1, ival2, kt_ival1,
kt_ival2, kt_lastmsg) in the SETTIMER block later in bcm_rx_setup().

Should the comment be more accurate and say "protect update of filter and
timer data"?

Additionally, this lock differs from bcm_tx_lock in that it's only taken on
the writer side (bcm_rx_setup) while the reader-side softirq handlers
(bcm_rx_handler, bcm_rx_timeout_handler, bcm_rx_thr_handler) never acquire
this lock. The protection is asymmetric -- it provides KCSAN suppression
and local-CPU softirq exclusion through spin_lock_bh(), but doesn't
synchronize against readers on other CPUs.

Is this asymmetric locking strategy intentional, or should the comment
clarify the actual protection model?

>  };
>
>  struct bcm_sock {

[ ... ]

> @@ -1263,10 +1286,13 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  		if (op->flags & SETTIMER) {
>
>  			/* set timer value */
> +			spin_lock_bh(&op->bcm_rx_update_lock);
>  			op->ival1 =3D msg_head->ival1;
>  			op->ival2 =3D msg_head->ival2;
>  			op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
>  			op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
> +			op->kt_lastmsg =3D 0;
> +			spin_unlock_bh(&op->bcm_rx_update_lock);

This is where the lock also protects timer data, which confirms the comment
at the struct field declaration should mention timer data protection as wel=
l.

[ ... ]

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--22w6pxgedggtqmin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVkrwAKCRDMOmT6rpmt
0iWOAP9EYVW4VlvsvyCixVqTZuDMVIxdDXH7K2FPUgA4CG5RXgD+Kt4EdvbpukNo
CMqxJL720sMQqZCyoRli+bG9W3Bewg8=
=ggXz
-----END PGP SIGNATURE-----

--22w6pxgedggtqmin--
