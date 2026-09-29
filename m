Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CEF4EFFC6
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674763; cv=pass; b=PPl1etmdzl/xZ2mm/+yUToGULyYDdG5hFQQcO3RCPFRnLRizI/HJq1vYnpRRz8HLZLjBEL0IUDBvaeEqKPkXtU1PlYcZBT+1fr7+5+KlJUJ2/5LwRO3JmDMooeqlxm5Gh+ikd64Yjh/saOPhlvNWm9NLo43hk7wrWz+J8cg3xf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674763; c=relaxed/simple;
	bh=6ASEDIfBwC4QUSLZZnkmS0iL5k2PTygT7nI8gfUi7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3J1ex9iVutQUCqu99l+HmKHXwqcFvnjoW6qGciiWzG/FkvC15DDp3oXWWFAWIWYJ4nr/57rMxAOOpsVJJe8H2f6kFn/Ityl9JdIascezBnYZ97u/xmJNZnftrXIyU2hg9JACjt+sCb2Mc8JD6MOrM56xW3GAATGaylF7Zx/yUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=UGw+l1c3; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="UGw+l1c3"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DBD992010E2;
	Tue, 29 Sep 2026 11:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790674758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSURpHxzm7eeVuc1kiiG1zF6mwEOl1xtvlkb2Zwtq0I=;
	b=UGw+l1c3F0b3lE7Vr9Yj+IPwiub+8yqssZvQFVMqSe/RAnSDL17vx8R372gYk3KdFI5L4x
	1edKEybdpGi3M5C28WXUEaEta/K3q41yi46CqyQPbzO8SrTr74U2vb2w8Eekm3OmrRL6IC
	HJGoeky1EnwTB5/FPnLjveKl9xRyvNm1WKImplz/XD3PoxdlzY+WhT9eLpWtvcKjQG/x6O
	76NjFgLya8Q7T9pFacv4jjr8Xwx8h1tu5ERi/UtLzzzXV5FURUzDUuFKRkRuWhxmB6TMFw
	i7MP6BUM3q5+K15gLXtzmKgEAdZ7uz1ADzxx9chmxNEOKOf1JdOnnJlLWlAK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790674758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSURpHxzm7eeVuc1kiiG1zF6mwEOl1xtvlkb2Zwtq0I=;
	b=QXD3NhA4EEhie5NyCKHMMgfOvIFKUn77E6xX47jOHTJ6RgRTj+0hs6D6vME7qGeRw/DyWy
	2y/N3zspI1KRnR2E6fMg8IhSl1PB6VPimsISFH6KTe9jvD0y+7Xk4q0bkRE6JphCMYhqxE
	lDku0Fkdod5cv1QjgtdBF0KYdZQQ3W/1zyqT2mwp8N7iAl5XyZWQ3j1X/Uoy0XcRL0lGxo
	3Y5pmrfyQiuajQ+FvXsOHaWacdE9INKo4JstpAvFOfhkBH+D9tIMd3nlXXiDyC3IZmgFYD
	ZQerUPC+gXcXxOfgAPTUIJyQK9wC4z4ZQnzKBg6B7Cy1MRwFRXPqMm2yfi9FJg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790674758; a=rsa-sha256;
	cv=none;
	b=csVjyAn1RQpfV72kf5tRJiTNjJrMoUbKLmcdfYbsTMypKJwbDsIEDcn7VD1rrVnTuT+uEq
	d5gmbdPnmm7bzXVzh8CQQ+23ZQExDoh88326+83mKwlSkMDq9jCKvWhERiuk5zjkY0+6Ho
	0fbWCSvRfcsMV3PEUu2FeC9dj1FTvqKVYSkj8R2doeoO9duGuuPCejxsOo4LX/QnLG2BVt
	PFcxI6lgQfgvVeoCF83JMLVOJiQBeZN+Ta7z+vQeCgDsNb6RqfMpzSNTfhS+sLa2Xk8ILC
	Vs57impK7cmaFPORMIZF3nd3XNj5fo8pn3wI1/eGk2MT9CVggH/6f67k8SCCkg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBUIw-003N3V-2a;
	Tue, 29 Sep 2026 11:39:18 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4E4865B33D8;
	Tue, 29 Sep 2026 09:39:18 +0000 (UTC)
Date: Tue, 29 Sep 2026 11:39:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, 
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
Message-ID: <20260929-ordinary-auk-of-sunshine-8e1cff-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
 <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
 <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ih3edqdpelcb6yjv"
Content-Disposition: inline
In-Reply-To: <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>


--ih3edqdpelcb6yjv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
MIME-Version: 1.0

On 29.09.2026 18:07:43, Tetsuo Handa wrote:
> On 2026/09/29 17:56, Marc Kleine-Budde wrote:
> > I've dropped the patch for now, the netdev bots gave the following
> > review:
> >
> > regards,
> > Marc
> Yes, please. I'm trying to make an updated patch.
>
> https://sashiko.dev/#/patchset/f982152f-ff51-4d31-a17c-bd0d562c1414%40I-l=
ove.SAKURA.ne.jp

Please use 'v2' as the follow up patch, not 'v1.1'.
Please include the linux-can mailing list and the j1939 maintainers.
Please consider using 'b4' to send patches, not Thunderbird.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ih3edqdpelcb6yjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaruHRAAKCRDMOmT6rpmt
0nxGAP9K9So4RLWE7/bJj5r7Hy78+o1sjslwjaVBTRMqC9KalAD+In5PetfuBhBW
FTq4ytpFlKvwdDd8rlwxE2idYW6a5w4=
=VhL9
-----END PGP SIGNATURE-----

--ih3edqdpelcb6yjv--
