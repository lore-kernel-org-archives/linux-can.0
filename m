Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAD2C11E9
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594667; cv=none; b=mn1PtnN3cMNFTxXhlg9+lDgOrG52C7rWtEaLahuGsvjPLEMegzrj4KgoOuEohn8G7WvlMGh8FOgmQ0rVHSheT3fXG4NGyb92Cz+teSVJsu+BJcv3hz1f9Qg+J9neN9ll5R64AJBWRx2W+Fl/kh6npStNYUHUh9DsEwwI1PqPGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594667; c=relaxed/simple;
	bh=cWXOogrWK0vb/sM5Gb08cOEf3p8t+pakkcmTytY6enE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5sGtEdxNsZKDJ1oIIefGL/Fh0XTLS+MEGlUQeVvVqB4oGW5RzKPOeqypGiiDhsFJBXvs4hDmlDk/oNNWvWC+MA7JjZZ34PBSutQgAk8Rlg0OKnU2jgoZ/4ywtdkZvOwRMifSO0j0r/p65iVMDLv6TOG9EidnIZlIC565OTqCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl2PQ-00049x-BJ; Wed, 28 Jan 2026 11:04:24 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl2PQ-002tnW-2Q;
	Wed, 28 Jan 2026 11:04:24 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C04494DA0C6;
	Wed, 28 Jan 2026 10:04:23 +0000 (UTC)
Date: Wed, 28 Jan 2026 11:04:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260128-keen-owl-of-emphasis-ca7f18-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oysvqpl4c7f3mvsl"
Content-Disposition: inline
In-Reply-To: <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oysvqpl4c7f3mvsl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
MIME-Version: 1.0

On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
> > In fact patch 6 stuck in my providers mail system which responded this =
to
> > (only) patch 6 =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > 5.7.1 Refused by local policy. No SPAM please! (B-EX
> > 155302::1769588601-AC38E895-223F95BA/10/71040183929) see https://www.st=
rato-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered
> > [MSG0011]
> >
> > As this could not been solved since Sunday I'll kindly ask Marc to send=
 the
> > attached v2 patchset (including your __u32 remark) to the mailing list,=
 so
> > that also the AI bot can take a look at it.
>
> I'll do. In the mean time, please have a look at b4, it has support for
> sending patches via a web hook.

Your ISP's mailserver also classified Patch#6 as spam when I was sending
it :/

| Reporting-MTA: dns; metis.whiteo.stw.pengutronix.de
|
| Action: failed
| Final-Recipient: rfc822;socketcan@hartkopp.net
| Status: 5.0.0
| Remote-MTA: dns; smtpin.rzone.de
| Diagnostic-Code: smtp; 550 5.7.1 Refused by local policy. No SPAM please!=
 (B-EX 149500::1769594129-F202EB70-729865BA/10/71040183929) see https://www=
=2Estrato-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered [=
MSG0011]

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oysvqpl4c7f3mvsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml53yMACgkQDHRl3/mQ
kZy/fwf/VFWWOTWronZ0zENTA9JycJ+ktnG02/TfSrqONArP2/3Ed5YZhggvg3/w
QZ10DJTRlFHu7MA/tbE0KgBn7qgSxe29MAvzqN6DuFRt8tJtWfj26tr9iDLCxoT1
dgBbjY21hkITzANUpK/Jvonl1zrrTUcrOs0o+yQcnm6spgnGxwf/3hFmXZ4aGEIR
cIp+QPi8/Z/wGx4fjqFJgrOUr5YPLqXCqbsMdvAFsI1auYyWtVGYzLyNGWcBiQt3
CmWuTEIx+c+M8KmmmFm/ZqV2vPENjOB6d61c8HydTSZVbqshpI7zq0fDGBP+rB1w
bAB1yt51jBeii/1ZQqpeZaivVPqyEQ==
=7gJi
-----END PGP SIGNATURE-----

--oysvqpl4c7f3mvsl--
