Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650C46AEE3
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072363; cv=none; b=cIdh1wxZx4kRoS33wK2yFe+K5wLyIPis5BndmUGm8B9GpRWVMNfK9qTqlOZKbFJ3glrtOcKdGp2rGLn5BAOT8Ses8dFyb1pZFxOOmq/qscFx3WoRz/mgDl6mBnAFSrASqbhbvs/ZoVwBzJhPQ38za0UJW31nlsvOY+1q6RwUEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072363; c=relaxed/simple;
	bh=rxoJo6a9jFQA/uBtPewvAOyO317rFiS1R5Rj1VfUlnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex5diq5by507qJkf+1O5B+S/+2EJxziJ+/KzLlYdQNHI/CWEwj7hT2Sz7Nt43YyLuu7AMiXcyJyFRzoUr2z4fJB/aaUTzsg3KvODmnr5Zk1dQ10Qup29p0mOOfe+IWek10hvAcyzOYb0xOkouagK4jA4tlR6vC2VINfyIEr64rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbqN-0001yX-7H; Wed, 06 May 2026 14:59:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbqM-000kKX-0x;
	Wed, 06 May 2026 14:59:14 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8302052F692;
	Wed, 06 May 2026 12:59:14 +0000 (UTC)
Date: Wed, 6 May 2026 14:59:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH] can: peak: Modification of references to email accounts
 being deleted
Message-ID: <20260506-aromatic-lively-mantis-8f0bf3-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260410124251.40506-1-stephane.grosjean@free.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq3h3sdkdo2ow5mk"
Content-Disposition: inline
In-Reply-To: <20260410124251.40506-1-stephane.grosjean@free.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wq3h3sdkdo2ow5mk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak: Modification of references to email accounts
 being deleted
MIME-Version: 1.0

On 10.04.2026 14:42:17, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
>
> Following the sale of PEAK-System France by HMS-Networks, this update is
> intended to change all my @hms-networks.com email addresses to my new
> @peak-system.fr address.
>
> Signed-off-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wq3h3sdkdo2ow5mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafs7HwAKCRDMOmT6rpmt
0nwAAP9Z89ZjXZYeIzgn7+R00NZEcP+AyFJBwxWpO5bQWGL99gEA+j+ka1cldYxV
xif22ozjGSEW+F4y3AwIFlpU1vxI3QY=
=yb5q
-----END PGP SIGNATURE-----

--wq3h3sdkdo2ow5mk--
