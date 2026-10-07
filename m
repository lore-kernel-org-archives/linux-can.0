Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF663A63F3;
	Wed,  7 Oct 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377779; cv=pass; b=G6YGR9NNDKZY2ind2oJS4X+GcchEmMHlb+Zu+g6cXxrn4rbMdKro2vKjf0VO/XVaHiyF1Hn+IMJR2TtkDoTM3zOyIPVZtV+ImTDqgc/wY4cPEHccBpRL/lZrw+5xSqZLEiLxrZBoos0WvmLwK6jvm86uq1FEvowWJFmc7ziQWBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377779; c=relaxed/simple;
	bh=Pmg8cPHdnp67KvvGtaNcEeC/CYMt2+14QU8E50FcYvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI+sY3dbBoaut1QihWTYQTNyf8S8dt9UZzzj9mMES+x87JUCU/tPLR0x/6mEca9J5Jg5n1QibzU7mLHY3UkytZHEMfu5+h6sj4hL2GG6TpXbBnu+HEuRhIKs0GKSxinIpYogddsM62Lz0iZ/LCnPB59fcCCxB+i0OTqnZ8Ec8FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gPW7/um3; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gPW7/um3"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 57809201DC1;
	Wed, 07 Oct 2026 14:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791377759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkwpWfXMu4S0YB/C5Qy7MCV0wk07++yiLxRo5FMELXk=;
	b=gPW7/um36CQpXofP4o46aD2MiEVJiT/O0u+G0GEI+tRyUBj20x3MEG4XRpqHegZuR2iITt
	x5VeuKaWg+rtOJIUnC0wlnWUsmvrjurG9eKEGmrW6hkUgHi5nlX0ofnUhxVk4Tgs1RU9QV
	EDq8MKWd6doU3REGvwVRWu9W/40RvQRwM8JnS+Qr/T8C9hlQvoPmpHU3l+9ODcy8nJvAzq
	RsaIacD3uUF6YuHJZM9kybthZS2OW4z/bQoC0kZzwVHDKRrnE95hVP/sWZ86lDX+aFXArq
	O9FcWlnAlEv7bD/dMxZYDpIU3AB2m7gfDpDK+gePCviHfa1z04aPeZk7YJqr/g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791377759; a=rsa-sha256;
	cv=none;
	b=PoCUKdeganCHBBazzPK00RM2n6rnKqISwBKFgp0Tl6VTMvdqTT6KqRDMDKRrC0Vv9MLfsP
	6Xk+9HjulpdkkqgihmyC7xNrfjsmx9hC3VuwnRRdQTuUW0+3aDOSy+lJteVw6G6+AtpkJm
	FLmXF1aeNTosruU/g078gSWotF9B4NjZZc4vwgDtVDwhtV/lmBAiN7NGvv+vCXTJSHZBIG
	0ZzmlSdPenUOAzBVZZiEiuk0MOzDFk4bQrj8AOImuwws6VMJz3VnkCk5UQxTByAq5gFHtq
	dJy4vR+bSMbvwFvZqjunlokShzrZwbRLTht6q++8KExEMZxb8pdesEf55adZfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791377759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkwpWfXMu4S0YB/C5Qy7MCV0wk07++yiLxRo5FMELXk=;
	b=GvTTV4Dg1Yo3HmeLkQFEwMKWc5SBFgzPMHECtzr5M2GuQ+obTVBkDHgu92R8fVrkok7GDK
	g5c9zeQNbhc4aD7EXjZR7vAODRn695dYPqXVflLBwwQ6ZQQlmuD3eEHmkzm643ljMdEvpN
	88YG3rdbpdmJDEiAqqJGu1bvm9huiBsuDlOzegQ7ae3E7cYpqvJiwEB+Sj5R4YLiDAmNll
	mAsQl/OftXXPjV4Gv4r1hRxbo5nEmHmsNYHS9wy+LTuU4LEk32SKMcjCs/qaah2kCphHQ8
	rWQJ2nlpVVeOIlvJ7ff4vJTI7A4KPwK0Rr6/3rCH0EjXHdfLQqddNsbGIUlHFw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xERBf-004ie0-0o;
	Wed, 07 Oct 2026 14:55:59 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE3355BBA6A;
	Wed, 07 Oct 2026 12:55:58 +0000 (UTC)
Date: Wed, 7 Oct 2026 14:55:58 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: mailhol@kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, s grosjean <s.grosjean@peak-system.fr>, 
	kuba@kernel.org
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
Message-ID: <20261007-nostalgic-wapiti-of-fascination-ee80b0-mkl@pengutronix.de>
References: <20261005-ancient-viper-of-swiftness-c884c3-mkl@pengutronix.de>
 <597196165.930416749.1791299468914.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6izpg7bozbhdg7bd"
Content-Disposition: inline
In-Reply-To: <597196165.930416749.1791299468914.JavaMail.root@zimbra65-e11.priv.proxad.net>


--6izpg7bozbhdg7bd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
MIME-Version: 1.0

On 06.10.2026 17:11:08, St=C3=A9phane Grosjean wrote:
> I think I've pulled on a loose thread and ended up uncovering a much
> larger issue.
>
> My original goal was to work on some improvements and cleanup for the
> PEAK USB drivers. However, while reviewing the series, Sashiko started
> pointing out places where the new code was still trusting data
> received from the USB device without sufficient validation.
>
> After fixing those issues and respinning the series, the next round of
> comments raised a different question: if these checks are necessary in
> the newly added code, why are similar assumptions still present
> elsewhere in the driver?
>
> The more I look at it, the more it seems that I'm mixing two different
> objectives in the same series:
>
> - functional improvements and cleanups intended for linux-can-next,
> - hardening changes required because USB devices can no longer be
>   considered inherently trustworthy.

As far as I know, the Linux thread model is to trust USB devices. If you
don't there's infrastructure that USB devices are mistrusted, i.e.
disabled, by default.

On the other hand I really appreciate that you take time to fix these
issues.

> Given that every new fix tends to reveal additional places where the
> driver relies on the same trust assumptions, I wonder whether it would
> be better to pause the planned enhancements for now and first perform
> a dedicated pass over the entire driver focused on robustness and
> security.

Yes. That's a good idea!

> My idea would be to start with a separate series whose sole purpose is
> to audit and harden the driver against malformed or unexpected data
> coming from the USB device, and only resume the functional
> improvements once that baseline is in place.

I think this is the best way to move forward! As these issues are found
by bots, the current consensus is to mainline them via net-next. I think
you should add a Fixes tag. I'm not sure if we should add stable on Cc.
For now try without and let's see what the humans and the bots say to
this approach. :)

regards,
Marc

P.S.: I'm not quite sure myself yet how we should handle the details;
we'll have to wait and see what feedback we get. We'll just learn as we
go.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6izpg7bozbhdg7bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasZBWwAKCRDMOmT6rpmt
0iupAQDjVaXKwNa3OP3MN2rKP7s+sub6sbxJA5lQxtgFnuDO9gD/fmjx254C4H0j
pOHlybQo4cSEwcLGc2quJvp6MaaNjQs=
=f21C
-----END PGP SIGNATURE-----

--6izpg7bozbhdg7bd--
