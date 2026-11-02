Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614189;
	b=zmCre+rI01lqp1882uOO53NshRTB3yIW5eJACNUXXe90UCyFfLwFvmBVl1aMeebDPasR
	 lE33ZaTwkOKN9MPM2rALYI28CWH1EoXrb3Xi4DX+rYQkZKnbS9ledWqi9CZ62/Cu/ztxG
	 ndHQB4GBuZg3BCpl88/3sP3VoqPfdBu1aoBiMFLgxdVeJAOdkTuboYfzPQXiwh2O+T2e9
	 45jmp9NwqnmtiVZfMo9Y9DMVWkyeR7/Pc8h07/kVsQHhfUZvC5RkfuIPD5zWh/vNNI0BA
	 FBd+C5JsZ8wErSCU1szDgbN9+xnp42g4fUeh21xhpEtbJepDSKovMtmDQv4dV8ujx7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614189;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fjzxDTVabpEPTBiexdT8Fcvo+x/UHlCDp3u4vbWAkyY=;
	b=cxHi7Khh9vw7Po6XroD0WBkcOLADudJR3acPA9BPo2GmJu/ktfnLBEyMJf3eOYG9JyS3
	 HObUTidD1MwIBjRP/q+bEN1clP1ZBPxLOtw795622DvLbWlqicGlrHvUSnJmZ2V6Owkal
	 AJGnH8+Tv9mOnMCVdXGsxtDSyr6lesZ2z0/i9Zs68iwsDC/djnAn2dV0D03VGOhCekSkA
	 gac3zzPZhoBJRiNJSSnSmWzO7Ki8H1m76Q2Yxow/VZq7reh59P12qA7DJXLkY73W7CkTL
	 5UvmZ6V6vulziCmc2oUxHxvvTwtViIHSWWzzzDoguRrD2jSpHRLXySCbuZ1GLjm5fgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="JNDmbOo/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD8606A326
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 10:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CD8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JNDmbOo/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3E51F2008BB;
	Mon, 02 Nov 2026 11:09:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793614186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjzxDTVabpEPTBiexdT8Fcvo+x/UHlCDp3u4vbWAkyY=;
	b=JNDmbOo/JdeMA7VvmLGBm3pdOQ3/3xayDsmlJwaEA6PwN4FD4+imnjQ4XYMJnBrSCmH8Zh
	V/FVzxpHggc47QhzNZp3KuLY5RT4I77ZqTxk5UQIiSwXMw1I6dypmOPKJyNMXVoUjy1bpA
	P6ZxwdHW131gon6kkshvSTg4SzplRaXaKiRd0ABlXcJI0Zai8aCNUCGL0b0TMVhcM9qiSZ
	VrR7B7r+KkNB4Wesz69PsYm9p9cMP4qNxFgEIJiluiA719reoZFxr3nKwzQMcyVVMHUZNi
	LaGxw/IYjGR+xw4eWR6/AAwue35zf5SbbMggGnxzgu/KAn5fW09jFjnGL+sSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793614186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjzxDTVabpEPTBiexdT8Fcvo+x/UHlCDp3u4vbWAkyY=;
	b=HN0VFBQjHPLu4bYaSI/jwzfoz2naUH88MhsHrSF3Br8NH1wQexKDrupWqlS/DGmMmMLDCp
	zvILISl9R2c1jLaGFsncsOCSl92QdBb2YiwadeMVRTreVHRunEVUQiD46hipe2wsIdPMLQ
	aTBbjO/Cvgl47EfKgXZXdEA4Dqs7J7VGas8yEB06+J/gssmIXqHVJlHd1tVQfyea3z9q3l
	Dg9Oq76ijwpqnYEkF20eix7IblXms2eMcQg4i1j9/9k2CUSKcJ0rdE1qY7cSfYzpqSYGM8
	w4vQOL6Ql5Azfsu1M+5tFF3sIhdddWSZEoaKDpq4/nzKfztBl+kIJ/CGNEGsJQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793614186; a=rsa-sha256;
	cv=none;
	b=ItyrBMkUeIniN7Tb225b1NQduyyd4nWtRrY00+yMQP1NjMFtaCB+5kcHwEpFY777d3Y/9T
	inwbeBKT/4OKmG8ojol8ceIo5zzP00oa+SxxzC/jKpFctUpXOk9gLoUoKeaKvsSpfPNkrQ
	xdNXDx5+ZFCLvAu6TddKe4ELKX305kxX8AJv8QU+/9RSIdZzpYdK44vJ3QH8MJYzLHuZxT
	pHgSRF6kXsMEHoVgL7iIbgjg/DmHm5geTVJwzbDXF8oJEDs9s7Yq95+sXDhDkFKrXEY2lR
	psVcroYNDzNeX9KYdAX4yw0j3jo7y7qSnR3K/Ti443rIqAIJrGxIfAUTnAytMw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xNoz4-002Hra-0V;
	Mon, 02 Nov 2026 11:09:46 +0100
Received: from pengutronix.de (unknown [176.200.56.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 455675DC219;
	Mon, 02 Nov 2026 10:09:45 +0000 (UTC)
Date: Mon, 2 Nov 2026 11:09:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261102-cuscus-of-exotic-atheism-400de6-mkl@pengutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
 <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
 <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
 <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
 <d87ad286-dcf7-47b6-9612-e8c2c547805d@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="or4jy4puyrzgjzm6"
Content-Disposition: inline
In-Reply-To: <d87ad286-dcf7-47b6-9612-e8c2c547805d@hartkopp.net>


--or4jy4puyrzgjzm6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 02.11.2026 10:16:00, Oliver Hartkopp wrote:
> On 28.10.26 22:31, Marc Kleine-Budde wrote:
> > On 28.10.2026 21:55:02, Oliver Hartkopp wrote:
>
> > > To me it is not relevant. If you would prefer the cosmetical roll bac=
k I can
> > > send a new series.
> > >
> > > Do you?
> >
> > no - it's only low, so fine with me.
> >
>
> If we would like to meet this Thursdays netdev PR and want to answer the
> sashiko feedback before, when do you plan to send a net PR including the
> other patches then?

Hopefully I'll find time in my vacation (which is this week) to do so :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--or4jy4puyrzgjzm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauhhZAAKCRDMOmT6rpmt
0pYqAP9ZdCjP0h++7cUggMfZ2CIb+57VlkHH++0WocSbEbnBMgEAh8NStuI6mq5e
qtWThJtyEvNCMLKQKaJma8wG5HSA5wU=
=Pm0u
-----END PGP SIGNATURE-----

--or4jy4puyrzgjzm6--
