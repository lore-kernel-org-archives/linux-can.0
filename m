Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FA4A4986
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675212; cv=pass; b=Se+naF7Z5PzavCgGZ7wp2RHFr2QTYy9eHWnBgVMRJfEhJ9TJjr5O0Klf+8BP8Xo/S8E0M/Tnrkz8VEsqbHzBzSHCRXu4IbMe5ILX88xGuYnLhYKZ/iD37L5q+Hx3eZW63cJm/6QbqeCrTGLmS0wsTvjheWVgItGf27rEJct23bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675212; c=relaxed/simple;
	bh=kTYQkAgajUJKmakMJHkg7GO0lC03sWeaWx7fmbFUu0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLd5ORHU5bHO50sv5VK7qVrcDJEHYAWMit+co8FzNU2iIYf4X+HcSSI+vk4ULMLGNWmNQKey4/J+1/f6T43rhwrn0Sl1mjKipqGd4hNdnEIa4erh7q11FzZK3JfG6deJBFMwKQUwXt2oeBPyF/9wlIwGBFaLeaWi3R96LItHa5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Sbk4pBKT; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Sbk4pBKT"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CC8E5201E6E;
	Tue, 29 Sep 2026 11:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790675206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6H0KssZ0wK0tWYUtNFKaeZbfjsN39XG62n6cTjBq5Mw=;
	b=Sbk4pBKTbFRQREdBmtTdZtBTkFyqzBAwYBW4HNOFyy8udJMh24cfM+/VT2LC63tTgiv2qe
	gSe6Gk7X4udn0vx4ycHpBTNkre0PpHuW+nVRs54jINPJDakGe4q1jEiF1x6jOgbV5tBfi3
	Zv13vVem+NERklbBNvxOaV1wmH0o66hPBYLlJms/0WdrqcP5RAeeNUleRBVuP+zYnmD3Pf
	cK+RMAMP4Pn2hD4Giya/ltpG6ZpEMUmQHse+Z1qNFc/Yg1Xrqe149kDZXZnd6MKP2MeMiB
	Snhgb2MkF3AysCqJO0yAfMhXJ2I0oHpZ9/yM6sjvcUqIRZOLPe85djbZiPORNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790675206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6H0KssZ0wK0tWYUtNFKaeZbfjsN39XG62n6cTjBq5Mw=;
	b=P5CULqwoYvBHlp03fAo4sKjurjOsqhUl3izxIUhe5SgIQvL7PJ6KUFS+eKeKXxdGPw0B44
	ASZnChmZBWV8ePMY8ySOku3jwQ2Q0D6tCF+ueDhUrPJY+oKY6AE/62vs4ZeKA+awkOyg1e
	Gcms1wEzsV5Ei19nhqk+PxQbQH/iaiLyMX3JW+XlX82E37K/l+W7vf4QggYryuTrOvDHn4
	9pKPqN1wD+ttLJ+XaLJPM2BRM1S5ycEHbFsp2CVA+cn2c+Gf2HtrHq8O2CxRvtTzmAZzsA
	fF/j4G4tLMwJX1M/mgXXMzNL2rbEZHqU6cuq1UJ6/ISiLAQ9vVlpmJLe0kHYRA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790675206; a=rsa-sha256;
	cv=none;
	b=B08vC+mZP/pCC/mv7Wopxlyth7n7wmrIhMfxu8lgOSF0xCbmU2kB3nByIYhmlDUAxTzZBs
	SWXZABDcmrPn4zAwhhoelL0RGM8BdUQ1J4ROs/sxuxrUtNkiYo3YKaBuw7p9t93ZW8doT6
	RpHy67afV8ZlfyNxzwNgLOHSa5Qh+1kpg7yqTIauhAV7aZMKrLTlPll/Mxzclqrp19S46x
	EMXsTaVlOVmQi+L+gXvwCnascjlZLlr1U0EkRHMfr26SAwZmM+wwKujwhoxSrpQK+1mKqr
	s83Npy+/vC7SZJTD/A4fxWqxjodWtuu9izzCSD+sNI3ax9JBDq1d2HOj50scZQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBUQA-003N4C-2N;
	Tue, 29 Sep 2026 11:46:46 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 73A1F5B33FC;
	Tue, 29 Sep 2026 09:46:46 +0000 (UTC)
Date: Tue, 29 Sep 2026 11:46:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, 
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
Message-ID: <20260929-woodoo-iguana-of-romance-dd56e3-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="sxgxox7zklrmqgpt"
Content-Disposition: inline
In-Reply-To: <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>


--sxgxox7zklrmqgpt
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

How ist this patch (can: j1939: cancel pending address claim timers on
rx release) related to the new one (can: j1939: cancel pending address
claim timers on rx release)?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sxgxox7zklrmqgpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaruJAgAKCRDMOmT6rpmt
0gnrAP9bx//In3PvLEY8qnB/KMO7dFyB105SNkJ1ZFjgdIwV+AEAjljPysWum+6S
IB1d4t30/8WjEKlc8LovMUFhLXSkpAE=
=VAM7
-----END PGP SIGNATURE-----

--sxgxox7zklrmqgpt--
