Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909A395240
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445753; cv=none; b=V6YPMiS0ronPBxbwlQcRwayZQX0BQldpoXCi8jmmp7N7yzIHbKrF2prMuBjxfDnV7WZMGIeisurhnlECSk9EkFMOFyyNywWabY7AMn5r1zREE2P5EEo0waVhN5+RvTjrzWRlpDyt2v0yf9RgPUd360w6bFxtQKJTYEz2NFz4gKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445753; c=relaxed/simple;
	bh=N/oOoxbJ19AWB+IrIbVKPcieRFmqLgzSoNPF7uizn3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfKHg9UbCXQrSEatQxm0P/q6BY7zHmjEiA0cdo/cJ6B5092tLcHZC9vdqxnvTw1gG/GfSOGZdD/CebWYPEVYbqOMppfXhPbVV7kmm1LsZdneu+C8YWVlseIkzTf3hvTwcJlDOrqvhfyK2N2fm2EEbyE+3CZcUTniz+hH7uNcVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx06O-0008KN-2T; Mon, 02 Mar 2026 11:02:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx06M-003MGI-1Y;
	Mon, 02 Mar 2026 11:02:11 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 593674F501B;
	Mon, 02 Mar 2026 10:01:48 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:01:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the
 read bulk callback
Message-ID: <20260302-festive-crane-of-fortitude-d135bc-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <2026022320-poser-stiffly-9d84@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zsshq5asyuanavm"
Content-Disposition: inline
In-Reply-To: <2026022320-poser-stiffly-9d84@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4zsshq5asyuanavm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the
 read bulk callback
MIME-Version: 1.0

On 23.02.2026 17:39:20, Greg Kroah-Hartman wrote:
> When submitting an urb, that is using the anchor pattern, it needs to be
> anchored before submitting it otherwise it could be leaked if
> usb_kill_anchored_urbs() is called.  This logic is correctly done
> elsewhere in the driver, except in the read bulk callback so do that
> here also.
>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: stable <stable@kernel.org>

FYI: checkpatch suggests:
Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stab=
le@kernel.org'

> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to linux-can, with preferred stable format.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4zsshq5asyuanavm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVgCQAKCRDMOmT6rpmt
0kp2AQC8gVN4R91gipw/S3nzF654WA+vXp/cTm6bEpWw5NirngEA+TdNOKf/mbzK
PVWqBYxr18qaFC0e3M3d/Axd5CeBUAk=
=G5bm
-----END PGP SIGNATURE-----

--4zsshq5asyuanavm--
