Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081052;
	b=0++/XzLnfP1/D0uoANKB8dLp/aX2wLftOMNrb156Cw99oAJbgWwkGCHLkmRayiI93o1d
	 32E5AEZPegISgJj2R8OOiNRFFEGoaAsJ/B0kg7HS9OSgF/Sf+MbjkXTfy4JtBo7slP8FW
	 drZuC2rHS1orAl9GO6X3eezhNTB01vxfDB7dFF8v+DfA6D3som3VvULM69aild0PzTisE
	 3B0GGz+LvGn+2DuzWY3eOlw1rR4vHTrQxpnfDvbDUv8B0e3cuCDQRZriBqOhpriTWbA+h
	 kJrx2JLHKy4NzNDs7p9cH2IoLapmawX24i8ue8jnzAh8ATDPd2Jx0ApbPJCp05TOujg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081052;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3sfoUIMJDv+Ip3VGOV5agyxNixgFFdYsyblod83bXp4=;
	b=WPi6yXH8Gpci6w8HHoHwfe/rIM9q3CQO/pyzVVab3ZDmGNhPMw/1vtT0LcYS//XvcwDM
	 sJMMMotSDXOpbVlbjZ8e8+zUgD7+L1njJDcd8hkD1TPli+Isn4XuIovvkgPJaLd2LAwqm
	 Ydm+A86yfi0taj9cKVDLvHuMnNHcmrUzSn25btpeqZB+YxcUfH+XDWqMaGKussONO/Q6e
	 amjw13QFckX3JVQGXTw+5Hv3uGAuwhNfBpzSs3JiNTnzqEhrDgAij0hiIstCxehbLhWol
	 yEHMWihff377whZ322MqWj8oOwL/tUylxmbcnPT5FfyaE+Kydvh40t5hWIZW26aVO+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KZ2CvHtF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6E606A336
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 09:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA6E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KZ2CvHtF
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DA23920311A;
	Thu, 19 Nov 2026 10:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795081041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sfoUIMJDv+Ip3VGOV5agyxNixgFFdYsyblod83bXp4=;
	b=KZ2CvHtFvl+M0u+yyQUktu/hNhNIP6DpAGvmtvFOEyL4t/bD70gxfIonRJtGKubjeo1qf7
	U0o9h52bGrqVsXJVtY6QB6qzD2Z/YKXsb/8BzUfFejXgwxnw0vwbC6/TAV3fL50IvaQbUe
	Zq6SU3MFZjtK7mYVp/fhcDF75ALcpjq8oabH0Mq7Aw3gLMpo+OrAnE0aIuy6TdUKrD0OHJ
	0RBSP5TQK8Z7dVtK/5wn/aq08Vd9F1qJLzx9ASxQZ3AS6ic+SWD8lCFvPQeC5UXJDLeie2
	sLueG5G+lrB5eTBh3DIGNEFXHUBCrZSA815+O727FMeekvfzO0QWveivyj+Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795081041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sfoUIMJDv+Ip3VGOV5agyxNixgFFdYsyblod83bXp4=;
	b=MpZ1UqJ1HCVGr5aL6ZV5zwxpKvIo9TkWjDuhYZrNK9HwZ05At8Luw4SU50R67b6wUPvmF/
	3p7WN2RfouYnk/hwgdHH6TJ39Uy81Pub2IKMR56lkV6YkeKt3RkTxnFtq2a9mFvKzURsBs
	tVXQdFaLEJ7npSYCN9SGiPtYy9oPbBdayI//D5fSx5jgA2Cy3+c2e8OB7JUdlEq+pZ77Qy
	RYrCPJJlfZ1NrS9BJrlxSD/kWuYczJNYONm86oU3+qJLGoPSC/EG4j0vERmE2hhMozUA/b
	kKU6OT8Ag5yU9Grhz4Zq3UoxOp899JV6+1lV772mghTsUBOp5VeX1w8WhRaKCg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795081041; a=rsa-sha256;
	cv=none;
	b=TnqDnXR1tKgF2MNp+p0VylS9XMrJZk3HtEO5heR35Ul578asGiakm3CBZ2jzA5rv9ESMA1
	urOcFA0uc5BKWgmdKLmXV/MJm6jYEJEWdfWdEHphqpWoWOS1l99X9Hgote00OyKNSNiED+
	TWjyknSJugRZv9vjDvLifZovvHHgfpcOHx87AqRLUmV670D+/yZzZ2VPJinE2rveSTgLqL
	iSCcCQSeZfp27/ycpAoZhB516adpoL5YBL68w/j/o9XtXiOyu357EAG/9HTUPnUV9cPcW6
	xnc0AnljeWm4sUiLP+wejN9KrDYeKFaxvvZ/qI/fb5ZZGXV2MaRBI1YmatDOGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 10:37:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 06/12] can: sun4i_can: don't discard the IRQ
 lookup error in probe
Message-ID: <20261119-congenial-macho-squirrel-2911f1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-7-mkl@pengutronix.de>
 <sashiko-outbox-222848@kernel.org>
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
	protocol="application/pgp-signature"; boundary="qid4m7zoiqybsgq3"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-222848@kernel.org>


--qid4m7zoiqybsgq3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 06/12] can: sun4i_can: don't discard the IRQ
 lookup error in probe
MIME-Version: 1.0

On 19.11.2026 09:32:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] can: sun4i_can: clk leak in sun4ican_probe() on IRQ deferral
>   and log mismatch
> --
>
> commit d88cf8d3dd8506848b42acf7070c915117b36839
> Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
>
> can: sun4i_can: don't discard the IRQ lookup error in probe
>
> This commit propagates the negative errno from platform_get_irq() in
> sun4ican_probe() instead of overwriting it with -ENODEV so that deferred
> probing can succeed once the interrupt controller is available.
>
> Link: https://patch.msgid.link/2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1=
792118040.git.chaosheng.qu.linux@gmail.com
>
> > diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> > index af52285d5a4e0..80be48d0593db 100644
> > --- a/drivers/net/can/sun4i_can.c
> > +++ b/drivers/net/can/sun4i_can.c
> > @@ -853,7 +853,7 @@ static int sun4ican_probe(struct platform_device *p=
dev)
> >
> >  	irq =3D platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> > -		err =3D -ENODEV;
> > +		err =3D irq;
> >  		goto exit;
> >  	}
>
> [Severity: Medium]
> Does returning -EPROBE_DEFER via goto exit leak clk on each deferred probe
> attempt?
>
> sun4ican_probe() acquires clk earlier via unmanaged of_clk_get(np, 0), and
> the exit label returns err without calling clk_put(clk):

Makes sense to fix the clock error before adding this patch.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qid4m7zoiqybsgq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav7DTgAKCRDMOmT6rpmt
0msQAQCXNT+QDVOskLNBhA2GWbLAjtDuRnC1XrNfbT3bzBGgfAEAsk100T1JVaz3
EDVBTWCAOh4MQYiOitNnpRrNn0Q2uAs=
=jKnX
-----END PGP SIGNATURE-----

--qid4m7zoiqybsgq3--
