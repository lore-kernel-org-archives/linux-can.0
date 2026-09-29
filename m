Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D454C6517
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675619; cv=pass; b=cLiJ04OZRd64EITpW+2Ns1z2ieOpVThH5C180n6FtTUk/7FImxnvbpr58gftmVnheOai8t8K8LHJjSwy7n4+yq86RDMEYOPUg3MoEnfCcc0QAWANfQxXn/v02An+VMOgzmLNfu3F/HCMYFFlyI2CdAdK2O7d/rUyZsx+bdrcxDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675619; c=relaxed/simple;
	bh=TYYOHMH3HFAkiqWDVC+eIGWWfNp6gw1GAh/57o1V7hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxSS+HJGiAF5EA/x58Igym9LiKbzQMV2SsZUw1XDbW8p+MrAMp27ILjkY8E+NoYm5KwGe6/DkCpUjo1vTRqRFwzammTDpEk+k24gFl40n/s87qbScTCiz/krKHZdC0zG5Qzr/+Y2uNbqhRLglqoyCjFLxkPfDPs6hxkfZBDOvog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=S8Z5ueHa; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="S8Z5ueHa"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0649D2010E2;
	Tue, 29 Sep 2026 11:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790675615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6Av5lMYxOT2zyv7rzJCeN9Q3GZF5wEd/iDw6JKzS1g=;
	b=S8Z5ueHaRPVXST+Qedx6MD/rl5XgqNgQSvQ4dWVbCS0guKElGwyTE1LhyMfKdwFKLft12Q
	CBMOkhjpegtK19KkakwRlURLeywTcBnOTMA9G1LXKGHWOk3hbfhI8opp/G9qgXsU8J7nQL
	/dtj03NnTr/Vt/yAdtEWyyN3zRetXEph0wwwJTjJJvRZJaEaggmprb5ShI1FhLNoZVlf4+
	rsJylLLpBN0mweCNZ7qndTxi7DgmcW4moKwj+pK/tcc1GBqwfCaxyTTqhszCGAJomFRWTU
	4RgfQ7+G/2/Of75kwy2ELiz1ws42gk55YQx7ZI7h3Z2+yJZQkilSroJEgK8WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790675615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6Av5lMYxOT2zyv7rzJCeN9Q3GZF5wEd/iDw6JKzS1g=;
	b=UUu1xxaxgXgbwss5SRxDdIsho4ZRwGhyc1g1IZU536/dakTUOyPN7wuB+4qyYTgW6HyBN5
	YzzFLVR1fNaqJbFo+Y1i3dTuqYEv0IyQFmwjIXrZdk5n/4FHmwqMiVR7AR9KKOAJw2IcMh
	rqFT52D2o8BpOuDx3BPvj6lbfLb5JQiyHU8huV/sGOYa9XumwnlSWnrGnyXYJGYj5fU8Xv
	4sCVjJKFQuYyw0uMpyiFIBzAUQtsg2EDBhZlVGzRfu30msJbKHg83FMfucLlBBwA1ri8Ic
	AWntE+p6Ote3Bxs87bjuPwDDTUmlYRERrIyxie4dXQklVhrNvsRYOuAv8MzvWA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790675615; a=rsa-sha256;
	cv=none;
	b=GD1PEiMmHqL6ra3Y/F/tGOyYcnHX5FtN+kpq5I67t/aIQ28bBCSI4EUi5Z4Q8FX2/h0esp
	nSi6ecu3Uo/Pan6viRWNT9JZdi1J3t2mbba/77BEoVHyQJYO/bwzGHAbXftVWAtHjHH2PI
	zIOhP/1BWQyM0FoD1Y4verVj9b3dBiTXjLoiX51nmxpmQEkfqlVhl6icrSvZ5u105Jr4hR
	zejcrriMAPHGm7JLi61NcEZTbjNlYq4XN7GkN2OC4LwkgMLKPsxtO6P7ZuztjSdkiDXJIe
	gmfXsQKgqa9hKumBwuIJCzYEzaCaYj9mONam/L/9NTeQT2Y4z2XWC0dZflI+9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBUWk-003N4z-2t;
	Tue, 29 Sep 2026 11:53:34 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9BC7B5B3419;
	Tue, 29 Sep 2026 09:53:34 +0000 (UTC)
Date: Tue, 29 Sep 2026 11:53:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, 
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
Message-ID: <20260929-talkative-hidden-dragon-58ac1c-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
 <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
 <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>
 <20260929-ordinary-auk-of-sunshine-8e1cff-mkl@pengutronix.de>
 <2a418d5f-5d1c-4472-81cf-8eb029e0eca7@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gg2qo5auuo6jakui"
Content-Disposition: inline
In-Reply-To: <2a418d5f-5d1c-4472-81cf-8eb029e0eca7@I-love.SAKURA.ne.jp>


--gg2qo5auuo6jakui
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
MIME-Version: 1.0

On 29.09.2026 18:48:22, Tetsuo Handa wrote:
> On 2026/09/29 18:39, Marc Kleine-Budde wrote:
> > On 29.09.2026 18:07:43, Tetsuo Handa wrote:
> >> On 2026/09/29 17:56, Marc Kleine-Budde wrote:
> >>> I've dropped the patch for now, the netdev bots gave the following
> >>> review:
> >>>
> >>> regards,
> >>> Marc
> >> Yes, please. I'm trying to make an updated patch.
> >>
> >> https://sashiko.dev/#/patchset/f982152f-ff51-4d31-a17c-bd0d562c1414%40=
I-love.SAKURA.ne.jp
> >
> > Please use 'v2' as the follow up patch, not 'v1.1'.
> > Please include the linux-can mailing list and the j1939 maintainers.
> > Please consider using 'b4' to send patches, not Thunderbird.
>
> I need several trial and errors.
> I will include linux-can ML and maintainers after passing sashiko's revie=
w.

Please _always_ include the linux-can ML for CAN related patches.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gg2qo5auuo6jakui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaruKmwAKCRDMOmT6rpmt
0g2vAQDa04qadSX8xnl8ylSDJqLjZxNigKAQ2aIY7RaXn0KKQgEAr7dLbp31pnNP
m/BaZvYI8mIwlD79yuzpOYEzWNZx5w4=
=+I+O
-----END PGP SIGNATURE-----

--gg2qo5auuo6jakui--
