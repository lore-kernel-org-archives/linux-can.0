Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794304623;
	b=314GTrsGxLtjfKEv650PAQC9IAnzyUvRg9HSfh9nOg7ggufyW9W/7t1gvSSXRx+S5nF6
	 gidwRg+863UrRqcfJa/NGhyyf1D7FUAraCWi8JqbmsJk31TK+aMGezooAl+LFaDpcNmA6
	 hEFBRSz2aL/0qRzO/ZNPSSsp7ftE/8IT9vr04TXWDJb7PFd7UPGP0yYI/SFWc5Pb8htrD
	 IjBCCw56J7ym+okOimgkr8JLQa5NmJnvwVsdOAydH+ze2i4YZeggSezM2w9VVFXge9l66
	 f1YNj3WdY2gu2kDd4FUoE1AkLgBwn1yrZ9nVJUbdN6FycHAU/lc0NV/X9kIDUyMndbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304623;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uxLTkIGD7D6dJoPWZcKcBWGaoWQfAzs49wMHvOx0C58=;
	b=3UADoJrCCcbU31VlSbJw5LeZwJdnMTjPbJW95b0TGh1IsAhf8MGuPIWaOxoNg9tFQEc0
	 YpyY6Vget/+MQerRKDru83Ga1eW2ciP9Srp6I5FwpGbygDw1HNC3i7BBTaefQ3WChk6dJ
	 cSLIlactrD+siumoQf5KIVkirgDf3eJFnYd/sj89EoyTe+f48fuw9iuNeuZ1L5NZIo7l2
	 o/A6okFByC46TUJB60FDqqordpvRsqedReb8g+cfPip+oYAHimqmTo0g+6grf2wL69nO2
	 H4482u2GBsOwIYF48syk+PrLOUR84/DHkextRRvO7wcrhmDSxG1eW+ynW9rsO5yfFRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DVytNC4Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C7606A321;
	Tue, 10 Nov 2026 09:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 196C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DVytNC4Z
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BC32C201F43;
	Tue, 10 Nov 2026 10:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794304613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxLTkIGD7D6dJoPWZcKcBWGaoWQfAzs49wMHvOx0C58=;
	b=DVytNC4Zcfex5zfvrUpWiNV+9H4WHNyaPUUEbQw4PHGhn6N0/T+6/5w4kfxSY6Zru8uYVQ
	PATTyDnGUVyZKPlkiBW/XFvB+++HzAV4HbIcoF5OhPEWjdsY7CFIbpRzlB/CauJSAFKuRQ
	PdtY9g3QixeZzl+89k1u0fmRVYuBkBI2mIZxkbSwaI7VZcZ0Cdis9WHbofXZ1omcW1ICX6
	VShzXAq4GS12I23j+pPJP2HfzhJcju+J5FlwDYYTW+ZGha7ak2WD51D8Tl7zd604iccdMD
	cRr6JJ7fpdQ9W9TMU+sYVYaKswQHJNEOr9P139LKul0yH+uQfomrkb0kzZo2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794304613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxLTkIGD7D6dJoPWZcKcBWGaoWQfAzs49wMHvOx0C58=;
	b=f6eR3h9Qma4N1ql0ZCff1L779d7qPVM6aVhwiJNBQpIBuWOErOA4y5RI948BULCqkFLi6j
	47mEJymr9dwTM5GT1n5Vap/73kdcAS7m2WMELoHAAZiCZ6GzelG/7SbIE1aoRaSOfF+WpQ
	5C7R0dLIsLptIGNtz/Q0yjKBfzp6uUwHpglT/9Mfcktvk6+ubEbO2+9Yo8N71urvamN8Rc
	Q9o/07ohNWZySfcog2bdkJ+CVcDZcqtZ1Ftvq+7wr/KsCPDDYBM55DTUkpKoeGoYN1kcQI
	+zItWKRtai7Jru6i9d+8JSbnNMtpjTRctRgYtsasHuSjydupcn06nT8P5MUl+g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794304613; a=rsa-sha256;
	cv=none;
	b=g/oLYHBqmandpZy35Y8MSWtc7xgVogOY+Fv+uvuzmKBODPD6ywPFN0jE3P59hWTMVTen6W
	MunBUIZaoc/E2fB8l43H86tdZeSrBwosQrnUo5Ref3JXT6dFbFSuTXPeMQnNFFxjpiVG5F
	ynpiDzZqxmS3Hco5axUgj+kIzK+v+HURaV/o7dsMOpVNq14MKxBlf9m8khsh7dKHDpWw1T
	76pygJXcmCgUUPBIk2+Vm65U71yCpi68tpcBA3MwLQ6v59NI6iwBrcfloSBpdFWFOypIW9
	BDRcbjkdhmMD+OtRz+RI1O4fSZyQ+VIGOjelf7gLvL1p6ktX8xy7Wejxc64NpQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQiaz-003TOy-27;
	Tue, 10 Nov 2026 10:56:53 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5925A5E668F;
	Tue, 10 Nov 2026 09:56:53 +0000 (UTC)
Date: Tue, 10 Nov 2026 10:56:53 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com, 
	max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ciprianmarian.costea@oss.nxp.com, 
	kuba@kernel.org
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Message-ID: <20261110-attractive-cricket-of-unity-27d99c-mkl@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
 <179430432849.488853.15448419304798286866@kernel.org>
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
	protocol="application/pgp-signature"; boundary="fsfkmdaqcrwgsxxd"
Content-Disposition: inline
In-Reply-To: <179430432849.488853.15448419304798286866@kernel.org>


--fsfkmdaqcrwgsxxd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
MIME-Version: 1.0

On 10.11.2026 09:52:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The patch is meant to stop RX timestamp conversion from using an
>   uninitialized parent->tc when a non-TS channel is opened before a TS=E2=
=80=A6
> - [Low] gs_usb_probe() (drivers/net/can/usb/gs_usb.c) declares `bool
>   ts_supported;` at line 1544 with no initializer.
> - [Low] The comment on tc_lock in struct gs_usb
>   (drivers/net/can/usb/gs_usb.c:335, `spinlock_t tc_lock; /* spinlock to=
=E2=80=A6

good bot! Valid findings, will fix.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fsfkmdaqcrwgsxxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavLqYgAKCRDMOmT6rpmt
0mSFAQDHt+koZcddsSoPXevsb5UAgE2tE/6B0Gfac+LDqKQdjgEAopeJx/qDhxus
MI8PWRWLoFrFcIO6PJQ/SPYGrOpQ9AA=
=Iy8G
-----END PGP SIGNATURE-----

--fsfkmdaqcrwgsxxd--
