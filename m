Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127076;
	b=xmiAubn1X07caDoun4E9geZNAgvzNBVzvzDHd5oWm/AuyajDi8oIWDND8X/aw95RCVOk
	 WSqg1o9kk3cS8cDYP8GwvZuV+Y6zqehBt2gv3+Rhw7O5hMaU2qz6rs2nUWOcODNHev7G5
	 wiBMosFVLyJrNoAA8oxf6PmJCnm0nrVyzmxKyqMyY+EMcIHhukiThlf2K2mJboz87zis7
	 Ntl11TOJm07wrJA1d+YGu/8Muto3VKFUlrJRD+vu+7B9D6ELJUqaYUvjJ9FFRLaf+AIBh
	 Xngzp8/5hz4sqRA2+BXelsPBtOv8TsoTYOdQvgz8t6dCgJIgNp7ve7xv3TJsmhrwzAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127076;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RGzDY9o+cbkCTDKb/jd+TzHBeaQ0PQqOTT3Ib2R6Cow=;
	b=HXJzRz4wBpjXlGtRsNxPZLnYjUdXIbNSmC3+TDQXIEA2g1gmqUHlV6i6Da+hs/SIz6Dh
	 cgLKqFWnttsTcqo300KYFrPDRI/TPEaeYqeZX7UHtLYVhxb1BThdCsZPm2Gfw97AHxJ7T
	 jysOLZxQuvHVyq02r1xjag/SK0Qm4D4r2ey+pmt9X4uFE9fhOrFm/CEdl93UTBopoWjWv
	 7t27ljIYYOuFVjsBe3KQQaktr+aA+J3XNwY7Ewr8rFGhc7o2opZI7eeSzHm43oUd+4ka4
	 37i00Sp1lSj6dWmyfKzGnbjD6gA/fW2gcKsU75TrT8VUdTPtBY+eUW+feFazjJ/q7VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="C/hbY4TU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FA606A320;
	Thu, 19 Nov 2026 22:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5FA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=C/hbY4TU
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7D1262000E3;
	Thu, 19 Nov 2026 23:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795127068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGzDY9o+cbkCTDKb/jd+TzHBeaQ0PQqOTT3Ib2R6Cow=;
	b=C/hbY4TUC/NFDI8GdD7Ue5XVrm90OY90qC2Vx53mZZtI9npdhHXgboh59EjmZPTx8ynPdf
	nnTKsufHqv9vGcx+ji6961hMrz2Kb9Jx/NP/qIhb/aa6UT12WNPIuPWEZcq3laDtNiWrNH
	hfQv2zuNZaAKthT3RqZMs5eiy5usZihPtJCE+LQQPLRl3ivuEpIVCa23Z9ArYWe5kxbA8j
	Dx8UUhdRWhvx7khpLtELRWIlAH/MHue2wBhCGZ5Bm9se18+uRtVz4WHjHm9dG2YXjr6ke9
	Xiyd64qQe+nxHjrnKqPEf2fbWoO7szK7O2Oc/tnQjuRI+5KRY6B/23pqluJ6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795127068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGzDY9o+cbkCTDKb/jd+TzHBeaQ0PQqOTT3Ib2R6Cow=;
	b=VO/gkJlbB8JU3vp8QW+EA88BKX3kXjB+iXmJ9NSCPv7NnXQ1/jOSuNAmV8eAKlkf0Lp00l
	Sf/oEs8F+5VSp6X/b1vu1+XXn0jbSpRgVODP78YKGhp8ooODP8SGNppwIh+3Hitdu8XQE0
	Jc/Njbr08olCLK3p+vwBHz/DUbYCt6DFWatypuafecDpRmdR8eyDKZsH6nxJckwTCETVgR
	YsWmk5ZAGKuFDkICXHUYcl1tImA/SffPVzjxswraTvAxrQ1BztqOUxqZtX0rXXQZyOdDvd
	M5S0YE/hrgdzHIz4FjYZBpH45Zyy4PPKlZpmA0UepSkCxe6kd7ySfqYNRZ9h8w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795127068; a=rsa-sha256;
	cv=none;
	b=TbrJhmDGWERyl4W2+PQKRDAGRo3oSHuIpIwTZVrkToPYVLXd/3ApfqKRlI3WkjzhPC1FaU
	TbyDEDEpJwnn8vg2GwV++x0O/JDKJlqhdL6VKLArY6D2OKTBwJtZYYieSBNJxpNwrsK4Er
	CPNG3DaSATHYOnHpSDCaVSbexkW7jX/Z2NMSHPwfEE0Xf4Z/rglxpziU3YHYB6C6VwCjVW
	B8I/A1xXCezKvGb+eDWewtRa7sPc+X682ihLF7RiCDZNMp5S9+Gqkr+VbSvVAWoyk/wnwN
	aCAd2c18kTHP/EriXj7YTVB7XEdskrxQjQgVEAyu43utLx/ouG3/bLT9q6V46A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 23:24:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH net-next 01/13] MAINTAINERS: add entry for PEAK-System
 CAN drivers
Message-ID: <20261119-fancy-armored-walrus-7e7943-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
 <20261119220936.155728-2-mkl@pengutronix.de>
 <179512673520.3291.7584679191508386933@kernel.org>
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
	protocol="application/pgp-signature"; boundary="2bxsz2qaiisefaxj"
Content-Disposition: inline
In-Reply-To: <179512673520.3291.7584679191508386933@kernel.org>


--2bxsz2qaiisefaxj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 01/13] MAINTAINERS: add entry for PEAK-System
 CAN drivers
MIME-Version: 1.0

On 19.11.2026 22:18:55, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.

The cover letter explicitly lists this information for fixes:

| Wentao Liang's patch fixes a clock leak in the suni4_can driver.
| (fix clock leak, found by LLM)
|
| 5 patches by Chaosheng Qu clean up the error handling for
| platform_get_irq() in several CAN drivers.
| (fix error handling, found by LLM, but not been seen in real world
|  systems)
|
| [...]
|
| The last patch is by Maximilian Zimmermann and sets CAN FD related
| flags on received frames in the xilinx_can driver.
| (fix a real problem, can be seen in production system)

All other patches are not fixes (code improvements, cleanups, remove of
unused code or drivers).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2bxsz2qaiisefaxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav93GgAKCRDMOmT6rpmt
0rhlAQDhH1mOgPMOQ7d6y8soMZbd+h3wB+dq/FCAJ3Ck//Nj2wD7Bq8UvcSlqhrh
QbuqWgT7m7acxOt7isSZ/Js+m/lTUwI=
=e4Z4
-----END PGP SIGNATURE-----

--2bxsz2qaiisefaxj--
