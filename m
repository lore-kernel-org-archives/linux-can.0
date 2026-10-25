Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792958571;
	b=2AN6q94yaWK8hojAR+1Jv7ND3liJj8QBuv5rVbYrEYW04ZBbk8kbcNMYwFg3nvYLyd7G
	 +xVJ0ixwFlfserj/oIS5pjvEGPM6GjOUT3TxoSiw1T1DPBR5+1SBBkQGtMhxD3PQteCOo
	 iV20z2y5UN+ZDL+y5N8c+sS+k+heMt0Rf2o9zGmO7G+1hmg85hnEsYNjln589Q09TrTGi
	 /nzM6P7C7fBUYRt3ZuaNx2vKEw0RR3gL6RT8TN89OUyONxNivEiEGdNC4/86Qp+iv0Ij3
	 yQCdby00U4N6U3k6kVPTVoulFNpnXQdIkUAMmi7xEEf8WJZPg5SJKtprq01Ub6DTnZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958571;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VI7UPqyjuisAMNQViGgkTE73eApg9b2hJXG6nX7UoDI=;
	b=yZLVqHTm19wXaieoMb+4K4qpiCHcczVX47N2qHc02oSrHSnbBemLsHEpvQe6XRlzRl1q
	 2RQqBbjoImWlj2I53Ohx/zPctuo2aN8LetJy6zkrjbQ9oixNrr3YDdI0Z+kKcZBJNYd69
	 qbI8QMKUqNZkmLY5BPnJoBs0JnMif75oLWwDeycmELroznAqR0XbFuB07nHegBRHCeWQC
	 YZvyTkjNGzPDujGcRITak8qz0VVJLfKOqTr168bzfOT4meIFdIP/7jmle+FKZX20LvqRx
	 R464rpjfDvz8uPqiSVeq9X2BXxjEPZxWrFlNXRkGc867aDLddpEd106ZDgnvDEHOWFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IQwY4Jjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D1606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 20:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IQwY4Jjy
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7148C200ADF;
	Sun, 25 Oct 2026 21:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792958568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VI7UPqyjuisAMNQViGgkTE73eApg9b2hJXG6nX7UoDI=;
	b=IQwY4JjyIUaCzU0YRD9ga2BQmO1cI5Cw65TTeqHqoA8OvwB4O27AWfo5G0EnUCmxsp2N+2
	BFO5dbGIp3yYzF9uz/3uXcdC6sGNq1Fq8nQCcUyOdY8wwRX0xBF9Z+cD7C6ZXRK6mQB5sU
	wXzxAlYbANI2VO5ruCwld2Ua5ATS7JnpEQkxHLi+DKKmf1y0va98qfHaFP+ha6LEs0FeDC
	t4NV/zp9hllJus35v78g3o/RYIYdNaHYeVdJ/JLaiptwGBKcJbCRjkY+MMtTdeMdVtn+cU
	TRoMq0oYkGN95CBkrSNnd3JxF6UACuPLfDWUBGHQ8QOhrXbDoiwiUb+VmLM/yA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792958568; a=rsa-sha256;
	cv=none;
	b=IYc5dvuTueF8hmN9A4QttZoOQrAX3WVhqrKlMt/pbbmpC/in8MmUBN3iGmdd7aKw4uC7xG
	P7NSsfplEzvglcuPn3Ip8qdJz2l0m/LUjDc/9o6qT9YJESj52+naHLZrvmvsa+/q1HDMly
	q+SDjGq5yHBUF+OsKJT1HXLY45sO/nIlaibwLc65n1fp7j2Qc5B9cUYPfQIATYMWXakpOo
	XlDrcR969FGdGt0mq5OMsm4BRZIcSwzprnGf0X+760tZqlzsFRsTCWOQBw1xBIsVfmM+Vh
	HIFhjmzXkgRxJ2BqU8YIkKYUpmBJuf/TfVoos9/p9j8HP2+G64nyN433wSIgaA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792958568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VI7UPqyjuisAMNQViGgkTE73eApg9b2hJXG6nX7UoDI=;
	b=cIYF+FAQJcX33zMFpU2soCMRnNg6eo84y1HRexPlazCBQJoQKkViTvleJ89yABmevY/oc4
	XoWL5LBtIagGCRH0jVatDc8IqK9bgwao0KdA5MnG3ZNDaCwR3Q82OBS7KIxquFM4Ug/vo5
	H5GROeusWgF7Ypj9L1YeHEDSWtEYw6cmUEzcP90WtNKXntduBGqwgxlRPITYd35rnuXN8M
	edZmjJe6hdP5sWMCy8E9j+c414GQ4CklEFmUS8JWOmDlrVCsS/g+w6wsAoSBPnjhV9X6sK
	VjW+JTPn4rX6MnbRaKVyOgEQBxwBNf1r4hZv4Cyu8fFEILfuBJ1O/9h5kE/XgA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4Qa-001Awz-1C;
	Sun, 25 Oct 2026 21:02:48 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 291175D4227;
	Sun, 25 Oct 2026 20:02:48 +0000 (UTC)
Date: Sun, 25 Oct 2026 21:02:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-invincible-woodoo-bobcat-b71ffb-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
 <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
 <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
 <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
 <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>
 <20261025-eccentric-sweet-hedgehog-ff4c6b-mkl@pengutronix.de>
 <7e91a6f7-7922-4964-9f96-c8e9b9f2f5f3@hartkopp.net>
 <20261025-impartial-venomous-dingo-855e85-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyzxkvxe43v3e246"
Content-Disposition: inline
In-Reply-To: <20261025-impartial-venomous-dingo-855e85-mkl@pengutronix.de>


--yyzxkvxe43v3e246
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 25.10.2026 21:01:15, Marc Kleine-Budde wrote:
> On 25.10.2026 20:51:56, Oliver Hartkopp wrote:
> >
> >
> > On 25.10.26 20:43, Marc Kleine-Budde wrote:
> > > On 25.10.2026 20:22:30, Oliver Hartkopp wrote:
> > > > > > base-commit: linux-can-next/main
> > > >                  ^^^^^^^^^^^^^^^^^^^
> > > > My question was about the tree!
> > >
> > > linux-can-next/main is an older version of net-next/main, so this
> > > doesn't matter. Both don't have "can: raw: remove redundant NULL check
> > > before netdev_hold()" applied.
> > So it has to be
> >
> > base-commit: linux-can-next/testing
> > message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>
> No, please use:
>
> base-commit: net-next/main
> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>
> and check:
>
> | $ b4 prep --check-deps
> | Checking base-commit: net-next/main
> | Checking message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
> | Looking up 20260831052031.902699-1-ekffu200098@gmail.com
> | Breaking thread to remove parents of 20260831052031.902699-1-ekffu20009=
8@gmail.com
> | Testing if all patches can be applied to net-next/main
> | Looking up 20260831052031.902699-1-ekffu200098@gmail.com
> |   [PATCH] can: raw: remove redundant NULL check before netdev_hold()
> |   [PATCH v9 1/7] can: proc: reset pkg_stats atomics individually
> |   [PATCH v9 2/7] can: proc: skip stats calculation after reset in can_s=
tat_update()
> |   [PATCH v9 3/7] can: proc: remove pointers from CAN specific proc outp=
ut
> |   [PATCH v9 4/7] can: replace ARPHRD_CAN type checks with can_get_ml_pr=
iv()
> |   [PATCH v9 5/7] can: isotp: check the return values of can_rx_register=
() in isotp_bind()
> |   [PATCH v9 6/7] can: protect the receive lists with a per-device lock
> |   [PATCH v9 7/7] can: raw, isotp: copy socket options outside of lock_s=
ock()
> | Magic: Preparing a sparse worktree
> | ---
> | =E2=97=8F message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
> | =E2=97=8F base-commit: net-next/main
> | =E2=97=8F base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netd=
ev/net-next.git main
>
> > My current idea would be letting b4 fork the branch for my patches in
> > linux-can-next/testing at commit 0c35fa862dab ("can: proc: remove point=
ers
> > from CAN specific proc output") where "can: replace ARPHRD_CAN type che=
cks
> > with can_get_ml_priv()" would be the next commit (and the start of my
> > diverting patch set).
> >
> > Would this work?
>
> My idea (see above, now tested) is to use net-next/main and apply
> 20260831052031.902699-1-ekffu200098@gmail.com as the dependencies of
> your patches.

For illustration purpose, I've pushed my b4/can-per-device-receive-lists
branch to linux-can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yyzxkvxe43v3e246
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat5gZQAKCRDMOmT6rpmt
0lYxAQDLu7lXzxFrW9mSNOiW6Sz1WMvjAgQXhaiEQ8qZP+ylXAEA3BR5skFqNwOn
3Lo66axXpUrcIuOxvdXi6VECBVE9dwQ=
=LQ42
-----END PGP SIGNATURE-----

--yyzxkvxe43v3e246--
