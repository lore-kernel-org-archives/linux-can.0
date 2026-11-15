Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794738650;
	b=ZXWo/tmZP2ltNEKssveqTw7OTOJm0rEJ21r1NcwHwrOnYi3C9ksT7Xt3bWrewSE+H3yJ
	 NZxtS4p3wJ2omwN7vHK+sraCfUMrqnWrAWce/aL8YT5mK5NWMT8CuHyleTt7xyBBcNsxG
	 aRtq93Nhh3FpilvWMF2R5GhQfnIl6wOFS2/FmE7HR09LMjd2D3NWUJCELFdwpdOviEcxC
	 UKd6+jFX7Uyd4nEiwwFwisWItcaDDlOxRKZ4M3azKK2QrmrvZ/hwc+7FxWiWfZgc30O2H
	 5Z5KbxrFoBAhoo1nWjjgsc6BCDO+40X7UMr82N6ifAkX37vuFAKozm96WDOG7xwFNrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738650;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pDYEvLzsSXWWpmJxAwgYYI1aR048iwwCWve2F9MMvwY=;
	b=24fG8q4k84bv5S8WtIxcE7JNyOEqluVmAi0xWyacPDlx0esZ7k5kT+F1p6Zw4BdUQji5
	 u9BuRNcTU8vv5fPHpRxxKSZ1bsxJLvUfyPcrOrbKZW5qMFwSL8QVUzG4r9pgcE3UStgC5
	 rdNcqUircD/t7B7oOlpzESt2CFrvYdHsm6IfKj/T7sEjhULZPOKdP2rZsIQGAJS7Gyr5L
	 u8b2cWl9x5TVzWW5673VF44td8WMp5dF24gXFj76VAe5KJsmHcibJirfZ6aDx3JV10uAT
	 ayHUbQFwqteFS16OyN7UOf/t08rkN0n9t0t7Fpf/XLtaHv7/ZuTFMUu08CHuFDZgjew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZbwWLEQS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF6606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 10:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ADF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZbwWLEQS
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ADB7C201E6E;
	Sun, 15 Nov 2026 11:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794738647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pDYEvLzsSXWWpmJxAwgYYI1aR048iwwCWve2F9MMvwY=;
	b=ZbwWLEQSxMmDXw7Um9G6Cn3/g2O2nNm5Rz0zKdvAoc99fgv/4ZWHluUcRGxoqi40qbwNRc
	b781mFHm4gRhRsOTlDP/14L6FSa2lV8KfUU4zz5yQTGqyWN7Ubq4u2UH8OsQlefAuxg7qn
	Vs3zxhHPYUscc0QUbZjil09NytGOqLGlOe5WT6s9Pi3a8t/CV+RjCAYaOEFyBeIqKNU2fj
	otYjxZsqbiybisOKCYmvERrqlKEFx+UIAnkeLNiAgr0J2/Gmd2lF03G/UqA8q75hXodwCj
	sy43zBTsf3TOquEWsLR4vruGer68bmaUrZIt0v+fiqJZLWI0Cnih65tfC2m46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794738647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pDYEvLzsSXWWpmJxAwgYYI1aR048iwwCWve2F9MMvwY=;
	b=RzwhsJV+Z7bdtx9hhP7YP/XLAsbOpb90RhngNWeCBeAhc0b6xHdL18H5pcj48SyGJir6Ri
	fhHEUcrx9/txmcL1m2qN/Q0HQDgousPyn4KV4O6EKBAEGy3hn1ed3/E5ZP64ictY17+60n
	6WD2j1Z4+HH6tPkCmVfswWw5QUKj0nWsUCU+Fw3wOnfjuE3sUuWityEH1e7McM4CKib2Ig
	quZFVFhz7bOmYuzD5xe/AAZ6BdGmIvdCbvmJeqaXewwPEpK3Hi45MQC9lhCzh2YO+tkh00
	TWM+1uDlnrQf8tUqbAOkFH9mm3Fv0u7Lo4ll1l3pKnYD4wA88Qs2afytX2Lqow==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794738647; a=rsa-sha256;
	cv=none;
	b=BHC9vATzbMZpl6MQwBc4th8ufT154HRLcHC7UPetcaBWnMRu3p3+FkQ80kVmyauuOYmCEU
	gqlzc0LV4IZ+dV6f16eKHQDznpQmcm9ldFDG0zMvCzAdOwrPfDsi6QZlgqC71YSN2yCtvF
	UW6gA/dTkx6vG4BnJZCJlT0Tlhw+GHhyV0vRSsxejoUTX2uET1lQMS+mdj6DL26VrIizBK
	6lcx4CbRfBRJyfQagkBJ5N31KgGzeb6WvnSztmd3NIA3dOOqW1LfJzjTa5M/a+cGNTS78O
	6g/Rq6FT4cvW3LaZFgoLfrzcLZDjEt09kglS89UHcAWEhYQZxPayokEPNreGEw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSXVX-004Gnz-20;
	Sun, 15 Nov 2026 11:30:47 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5BFAD5EC307;
	Sun, 15 Nov 2026 10:30:47 +0000 (UTC)
Date: Sun, 15 Nov 2026 11:30:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev-bot+sashiko@kernel.org, linux-can@vger.kernel.org, 
	o.rempel@pengutronix.de, kuba@kernel.org
Subject: Re: [PATCH v5 1/5] can: bcm: copy the CAN frames outside of
 lock_sock()
Message-ID: <20261115-nippy-adventurous-scorpion-0a33ed-mkl@pengutronix.de>
References: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
 <179470332579.488853.5643594273401866523@kernel.org>
 <25179774-bf3d-43d8-84e6-b0ce121f3eac@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="riuj77p6kbjvmsds"
Content-Disposition: inline
In-Reply-To: <25179774-bf3d-43d8-84e6-b0ce121f3eac@hartkopp.net>


--riuj77p6kbjvmsds
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/5] can: bcm: copy the CAN frames outside of
 lock_sock()
MIME-Version: 1.0

On 15.11.2026 08:55:26, Oliver Hartkopp wrote:
>
>
> On 15.11.26 01:42, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] This patch's commit message describes the bug as 'a stalled
> >    copy on any CAN_BCM socket can block RTNL'.
> >
> > --
>
>
> > The later patch in this series, "can: bcm: use a private mutex instead =
of
> > lock_sock()", appears to close this gap. At the end of the series,
> > bcm_notify() takes mutex_lock(&bo->conf_lock), and the generic SOL_SOCK=
ET
> > options never take conf_lock.
> >
> > This patch is tagged for stable. Should the commit message say that the
> > RTNL stall is only fully fixed together with that follow-up patch, so t=
he
> > two get backported together?
> >
>
> Not needed.
>
> This patch is a follow up to a bunch of recent fixes to remove the
> dependencies to rtnl_lock()/lock_sock() like
>
> can: raw, isotp: copy socket options outside of lock_sock()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
?id=3D43c973a0887d3d7b2ee0a446603c97bf0f38c58e
>
> which had no such announcements for potential future fixes either. Doing =
so
> only adds some bloat to satisfy the AI bot during the upstream process.
>
> The stable process works pretty well without adding such hints.

I've send a PR, let's and comment on it as needed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--riuj77p6kbjvmsds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavmJ1AAKCRDMOmT6rpmt
0lp4AP9Mw+7J/Zp9I70zJicIHRzmM87iJfTDYDhGLDmU/qLVHAEAg+XDuf2SiNlL
sTLztZ65SHXIQ2Qs2+QbNPeN3Lp9gwM=
=0i9E
-----END PGP SIGNATURE-----

--riuj77p6kbjvmsds--
