Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7B4AD4CF
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155659; cv=pass; b=ph8aPYs3T2fzldDE3n7GOJ5BOFioBilxqeB6UUv6zoBJbYcxLs9NxAembsIMsdVunCRRQU0J6D8zG1dcmkU0xTEqGnBnBHM2SWYu51GYkwDKPvJ8lzH/8YCNxeWCWSAdXi01CcZhdyz46Yc21a/Q9NYj8b/O1I1VM4don1L0PnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155659; c=relaxed/simple;
	bh=x5vDa2bDj4zMXJkMn60DOyp/rf4jn9x8PgtzFVUFOkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzuwG2F10vw7N/rh2H06W26lj0kx1i1UVFs0oZg5SwPicoKI2vBzmLqbk0t6GKCB66HJOGpB9bqMhJlJiy9yfx+gsnoGmzylUZQPtuwI13pjm0iylwFW8U8x/qqxOHzETDNm73KiZQNRPOe0mJ8+l5dng6Dx9uwTRMjN0u6jDsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Pi0Z/QPy; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Pi0Z/QPy"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5BFD32027F7;
	Fri, 16 Oct 2026 15:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792155652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+IVXFd5YVfF9SAoQfC9OMzy0PFo4/ZJb6EtVz1kaIY=;
	b=Pi0Z/QPyld/1c5bc4+b2JPRHENidEorbYPTVowBwE34YKGae1ZNtanlhmSZzNcY0g2WuSI
	nBRqYYh0qChqVNIJN2PsgFonvgQkQfDz2Z0h7/PyqMp1QnWA9au8bPbjG6GBZOMqz4Mlfh
	j1Ocys8gKHBlaL89G3hoqxI2zKhOF8LqV/R3E+tL5YDq8U8B0ja9jPVnc/3AKORSQyoUzL
	hTyMu0OynakA2bf9MxlcxtKcyDQs3AMuEu6uQSz6NY4JnTwGcjIY+P1tO1DtvMeLpWIUwW
	cPxUMCvpVPbFYcMeviUPLM96ttroGTw2dWsUareHM+BSy9ZsI3z9fREB9dA12w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792155652; a=rsa-sha256;
	cv=none;
	b=bCJX9KKnueHbsi6jEV+Uq4iUbROKw5tJA7sjMmUxCWI4ASTxwuFWKysW9BG3aT0+1BNj8E
	1TQXV3AkADlYzty/hxu0QNW6xk3r3E1gBsfaY3WjQ3RWMSGs0kG5E87YR/nym+5CzdnXpl
	7dKYiNCb5sVcVMF/tkQKMYyHbCs0tL9Y8ZWq6RyQSfC97LhBwn8Ncz8eKl7mKCtEp3fKJd
	D3zm8/ALfMJk/HVPmpTQ6IFVjdwp7UcghQw7LJAhOYniprLaOq9UCBlVeCSKhP1q2RlePc
	NmvUujbOwTfJ6qkpffFh+ep9VUkPv3S/imRg3b12SM0w2z/++/QZCdzqRoaPWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792155652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+IVXFd5YVfF9SAoQfC9OMzy0PFo4/ZJb6EtVz1kaIY=;
	b=N2W4j1oO3IBG8elHxxbCAAUZXw8Dr5Sl+guZAPbEDsmdKtuY6muZE+FpMWZU31fJYSqSa3
	Bu5ESdNMzHX9TUxombhcHRm98cf2U1lSfVit8hp5SCs61LmiWoVIBPjN63RmTzdZezPaSy
	6Zgz9+BYdUQCU+w/FFSGnkIAIz4YtavroI4wPbeCk2MNdvwKFBMovo6Si1oJ5WsmpOV0zy
	bQBcMqefDx60qvs3IU5xUgEta+yGpjhaXjnmyYxAXYDca9tUrrkRRekiaZ4zpUxU917B0k
	KtVMFnSIyeBc1/resSzLMlg4GcNHfZTcr0Jh/6OoA4VrHfbBzZRv4vgknz/Aeg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHhYK-006Bel-0t;
	Fri, 16 Oct 2026 15:00:52 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 090B55C61CC;
	Fri, 16 Oct 2026 13:00:51 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:00:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/3] can: take rtnl_lock() before leaving the
 notifier list
Message-ID: <20261016-funky-piculet-of-awe-98548f-mkl@pengutronix.de>
References: <20261016091128.325332-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3cktkynh5nodttt"
Content-Disposition: inline
In-Reply-To: <20261016091128.325332-1-socketcan@hartkopp.net>


--y3cktkynh5nodttt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/3] can: take rtnl_lock() before leaving the
 notifier list
MIME-Version: 1.0

On 16.10.2026 11:11:25, Oliver Hartkopp wrote:
> Norbert Szetei reported a use-after-free in isotp: isotp_release()
> removes the socket from the netdev notifier list before it takes
> rtnl_lock(). A socket that leaves the list in this window is skipped by
> the notifier and has to remove its CAN filters itself. If the bound
> device is moved to another network namespace in this window,
> can_rx_unregister() silently skips the removal due to the namespace
> mismatch and the remaining receivers point to the freed socket.
>
> bcm has the same window and is affected in the same way. raw has the
> window too, but removes its filters with dev_net(ro->dev) under RTNL
> and is therefore not affected.
>
> This series takes rtnl_lock() before the socket leaves the notifier
> list in all three protocols. As the notifier chain is always invoked
> under RTNL, the busy-wait loops on the *_busy_notifier variables are
> dead code and are replaced with WARN_ON_ONCE().
>
> For bcm, RTNL is only held for the notifier list removal and the
> removal of the device specific filters. The procfs entry, the tx_ops
> and the 'any' CAN device filters are removed after RTNL is released,
> when bcm_notify() can not access the socket anymore.
>
> Tested with PROVE_LOCKING, KASAN and DEBUG_ATOMIC_SLEEP while creating,
> binding and releasing raw/bcm/isotp sockets on a vcan device that is
> continuously moved between two network namespaces, set down and
> re-created, with concurrent CAN traffic and bcm procfs readers.
> A bcm procfs reader stalled via userfaultfd does not block RTNL while
> bcm_release() waits for it in remove_proc_entry(), also not with a
> concurrent removal of a CAN netdev in the socket's namespace.
>
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301=
A8E@doyensec.com/

Applied.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--y3cktkynh5nodttt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIgAQAKCRDMOmT6rpmt
0jowAQCw2nuABaR5uCAdRFOYPqEB9R6KrasZIOQJkiASFZsuEgD/QBLhORf0Uk2v
Ep4zdto+QoGxOyF8uBFIaZ5r4QNopAA=
=r2BW
-----END PGP SIGNATURE-----

--y3cktkynh5nodttt--
