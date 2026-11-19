Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087181;
	b=rN7rKDau5NmuLlGG0iHyvNmxXjY7oBN4I/V0tKlXFoIF1pkg7i0znTl9X651T62uZbcK
	 ZhiZZai9/0hGV6v3L6xGMi/daML54BQMsTGE71cQte/lI8JAcl67CScFOZQ70Wfo8B53U
	 KWCiNn3Ilv/sllk3luU9fJEcjKxarAaJvepMP4OIVgS1Jk0nxr0x+rYcy7T7IHF0iIwrJ
	 SWhm+6l8KDbY3jnwO9hzmQzXvzcKvh8cIj+Y69yBuMvd9GmzORdRzIZMU21KYPzfCwABa
	 K7zWW7pmybrbcNZfBj8VexFqvYOF3o+eb4S5Lx8ntJAot/OuIqc1XApF1TSYuv7G3gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087181;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ovjOSxDz0rrZAUrt6MaZMN6vIlGcphoYgirIQE4EbNs=;
	b=2hIRT+6/B8ZHnZRhkEVbJ5PImuqUa3AKqZhaq6MXH5txAIG4C4UPyX1muj/hJ8J1hNoC
	 asDDrD6GxoBiENO2zubTnYFct0i0GaGCexkg5rBrw/1L2rXlX6m1E4io0i4Etm1ZNVNoi
	 Uw8kNEu1/ujhrxlHS7L51v7LicAlQgCxU4GcTY74E2YFSQ6Hzf7X4owiZvmRAIemAclCv
	 kntAcySL58M9tZ6foBku05Q5jVKiT+7WH78ZQG5nG8quQszxoJAI6L7Zy992Q0o+BmpNX
	 YctdqEBC7IF03ZfF/iTH3LiM6cvQQkdVLrQudbUoHu1SoQ5nAexgrn2pgs1lrVBqxGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Uua8QaHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B3606A320;
	Thu, 19 Nov 2026 11:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645B3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Uua8QaHT
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 909142021AD;
	Thu, 19 Nov 2026 12:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795087179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovjOSxDz0rrZAUrt6MaZMN6vIlGcphoYgirIQE4EbNs=;
	b=Uua8QaHTggtjdIBtQPk3/qef6/e3N+9JKI+CMGRThED4CKGVmx1lMei+MjTWJA7V4PdCSr
	A+odGnIIEla31+Sm+bX+CryaPszcQC9Tl/meyIFBIcz6R8lICfi7HPpBO6fVZrhnJnmI0V
	LdwBFX2ZawMvgO0O/t8y518wnPpPBp6DXAvDtQvvy/qu/iyGLTbzkcYh5DYCxG3E8l53cq
	tjZlETqja/gWUC9UVwkarHAFoiq9lACBHQCU7Uc3NDfdIV5L7pXStk5kuyJEqUIgI/2hpB
	zTLNU33fl0fgikDr7DMSJKVp1zwSsS4zCFodJ+ECxCO6qPvDW0Jq0BsoZ2jLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795087179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovjOSxDz0rrZAUrt6MaZMN6vIlGcphoYgirIQE4EbNs=;
	b=eehVWcB4dvt7rwTNhQOucQdt4IWjQuL6n3pB/Svc+Cm76Z1YoCPlNIFJUjilsszYIyVUO5
	nHsqHbnb+fSDxESIK+WVJCqcma5GELR15KaNSsVSHNoCXLaWgTEb2Wfd+fzxONFE9H0OvE
	yauIGrr6Tj5Kl66zmNBRbXIfWQ4xaq3CeLfDZz7yjqdWkpaKQ8OrKhH6vTA9x0Muod6lGr
	j4FaRABZGaZxXFRKRfuXkzppqE2IhUWIF3tmUt+M32RDT9o7IH5XdqnaWX2KGTt/Wes4JW
	iNN0pp8lqq7mQvSJ9HpZmN6ilZ2xxJ3LfogOhx7Pwp8z7IGCdRJudynQqhxeDw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795087179; a=rsa-sha256;
	cv=none;
	b=NwKNadOrBBZqUz4V0yayIaXb2JFfE5hm//Pje+5DiJYSJ8IbuLngNkLRa27CXT6X4kWonX
	ZqANIcVNutijPC1scFI+qXig/HdtSx9EF69v8yMzCXqpEG2ooEqen8aqpciA1Yv/rr8VgJ
	NS7UOJr5czA1jzOel7+p2A9BEVrZvTZfjsvesoD0KONIsCsw+KpwX6c8HLRXCCkk/9wwcV
	ZNNziHQVwOx9pXKK8wkb7nyMifU7IdoGB4e9um3jh61j76+72l19E3LgZonLfnBGcT9hHZ
	mgD5fcGFRploflle9jU9/2nHQO/+XPOoarCl2CkbrUFS1PrrooaPxMMyvK6oPg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 12:19:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH net-next 04/12] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20261119-sophisticated-okapi-of-flowers-97986b-mkl@pengutronix.de>
References: <20261118092955.1283165-5-mkl@pengutronix.de>
 <179508206819.3136.5143765579402417874@kernel.org>
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
	protocol="application/pgp-signature"; boundary="scsbncfo4wxaccno"
Content-Disposition: inline
In-Reply-To: <179508206819.3136.5143765579402417874@kernel.org>


--scsbncfo4wxaccno
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 04/12] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
MIME-Version: 1.0

On 19.11.2026 09:54:28, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] For the ctucanfd glue drivers, the commit message's claim that
>   the conversion "reduces kernel size in case CONFIG_PM or=E2=80=A6
>
> --
>
> can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
>
> This converts seven CAN drivers from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and wraps the .pm pointers in pm_sleep_ptr().
> It also drops the __maybe_unused annotations from the suspend and resume
> callbacks.
>
> Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@gma=
il.com
>
> > diff --git a/drivers/net/can/ctucanfd/ctucanfd.h b/drivers/net/can/ctuc=
anfd/ctucanfd.h
> > index 0e9904f6a05d6..7dcd7dc507e49 100644
> > --- a/drivers/net/can/ctucanfd/ctucanfd.h
> > +++ b/drivers/net/can/ctucanfd/ctucanfd.h
> > @@ -76,7 +76,7 @@ int ctucan_probe_common(struct device *dev, void __io=
mem *addr,
> >  			void (*set_drvdata_fnc)(struct device *dev,
> >  						struct net_device *ndev));
> >
> > -int ctucan_suspend(struct device *dev) __maybe_unused;
> > -int ctucan_resume(struct device *dev) __maybe_unused;
> > +int ctucan_suspend(struct device *dev);
> > +int ctucan_resume(struct device *dev);
>
> [Severity: Low]
> This isn't a bug, but does the size reduction in the commit message hold
> for the ctucanfd drivers?
>
>   "also reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is
>   disabled."

looks valid.

pw-bot: cr

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--scsbncfo4wxaccno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav7bSAAKCRDMOmT6rpmt
0i57AQCSDHjg8SlfcIO7OklL7VSP/MXkLxhNll4wSXZ4b9qtDAEAq7xvQVjV2Ex/
3NkJS8G3o+wFTAEItc2E1i8EJkRl3AU=
=Y/YN
-----END PGP SIGNATURE-----

--scsbncfo4wxaccno--
