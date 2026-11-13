Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592440;
	b=ezWmeIkFn0TOXsMS8sU+eDEnAMpQlHAN1vZPvIRE1ATjULz0oUJBLjbBHSwaXvX45Wg2
	 O1w2CR1S2RLfDNGZ1IBUp/XzhlULwvZSi7JP81LAiWz+VZrE/1LU2S9Wm88JanhEsDtVU
	 1mff3T4PMFvI/hxc7CpjJKRB8vDfpI2YUf1CJHYLYFZIHJOLNQotuFSAxi5QWy8NUi7Kx
	 mo91L0BFKoyW5zDKUNEbVsUA+4ofMSvgqbLWG6ghFP2AaUzzKz+XKOeRERu2RS1PfR2I3
	 UwTiw4iXp4z6m8SfLzTH9cTIiM2DPS64nCa3oeg8BqzJUhBD3fA8VRSlAXp7ad9RO2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592440;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=L0iNZbhv+LM/byRHU4HEqo/gMAl3qiRpr2MLn5hgSVY=;
	b=tyl98bCFXHRLFC0UOu0hJ5LNu/fNTDikFGyfBKH11uoou6qdcGYY3NMfzS3WDZIqp9r6
	 qzGeOqYz8/5JL2sgX/61BDO0y70+k16MHaDPrbXxbjwoFH9/agO1+eFC7kE/bPK9BiIYi
	 khztsiV1Sjl+xKc6tTL0RiY3O7o8ZQbrPSPJrFi9ZeiIFkrGi8JbmB8yPDf145ymf4GV8
	 hf+uLg8OXsl482IlgqcVGv0qhGFeq1mRMgHpNR0AjnnBZoEpJhbLdDMZFjG2KmJx7NauS
	 j9WXlGpRaw0KlmYceA6v/qmR7/YkC9qElSVvBA0psHl4Iz67SLTPSYJ08bkciwjQOWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A6kQY4ck;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9C606A883
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF9C606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A6kQY4ck
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 76C28205A0A;
	Fri, 13 Nov 2026 18:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794592433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0iNZbhv+LM/byRHU4HEqo/gMAl3qiRpr2MLn5hgSVY=;
	b=A6kQY4ckk0p53XFefEakkFLA0AZKuVPnvkrOUMbcUBytscJMUKoG2YD0+4Pye2w8ia+kUj
	KAM5HpblxKInj75UgsNhCV1PnEeeWCIjBcwqldCcYE0hoYbuLNIOCs3HKyotDFbmg3rzmZ
	JhSQMBzg6Hpi9RlunhZHYRifi6oouUuheE0yp0BACU4yeKQTDrqbamGFw61mZ+r+vHtrmU
	p2JxxXCrngXEx9o7xwPg+NUpxfybSLqFpPd7hKPXF13Mbc3TNh2mUqjcgWJTfM1e8B6WbM
	J4sUMJpfJ4Esb9iNCpj94eC8f6nIG92+zArCaxV7JNHbF31pgsCXm71LxbRybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794592433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0iNZbhv+LM/byRHU4HEqo/gMAl3qiRpr2MLn5hgSVY=;
	b=Kg/Xu1647arEdDWQlAz3zaeBYNGyo4OqebvP3wF9iKOk3jXyIcKuvwOcOY8JE1ls8UTeMc
	fcoUJblJw8QtHg83Bjl7GnT8vL1UKMcHrB4wgVcUl20RO87o4s8tM7AA+5W2FDh8Fl2Krn
	npfgne2OVTW2PZmFGSRUqha/faYe4dQ8XeCGkD2aCF1BrPtfV3MEfj77d13rSQpbPdtwhr
	fkPHAJpwOC4d/Thb0l623CZsKh0gXlTW84+Ux/Cexrqpz7t9kW3Mo2Q3KwpNx0fqEJnldH
	UU3dyVZ9/JjKLq5cxlPasZN/lLraf/E/3KCBf3sGCpP2FEDuo2uIHL0/HBcgww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794592433; a=rsa-sha256;
	cv=none;
	b=Gqb45nATH/30taiZ12QORjbEo8tTeSooXoFaUrC8xOysyb510EcvlkCZPAKyHzQqZ0hOe5
	tqmfPXBMiIhC8+Ck57ud4Tvrijrj6d41HGiX+XX9iGcBWwmNIuev0o4mjDr1SgAbfPacLX
	SjzVTp5qC8r6bEXe68Mi/sUN+zsgVgb7rZr60SkaP/qapJIbSZBGgDNo+q/dYXDqU7P7it
	lQu2TxpHlSly0aUGWwt2jPhk0w9UEpKVM0rWyXMChUlHL9vBc+X+4mobsOzdeiGduxArDW
	MBRC7LeEUj/lItCIvXujsaS7oFr0oKuqhs0qJQk8yHKiMBKKao9VG4TfmKpyrw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRvTF-0041gA-18;
	Fri, 13 Nov 2026 18:53:53 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 187DE5EAF79;
	Fri, 13 Nov 2026 17:53:53 +0000 (UTC)
Date: Fri, 13 Nov 2026 18:53:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
Message-ID: <20261113-sparkling-secret-gecko-a2aecb-mkl@pengutronix.de>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
 <20261113-raspberry-wyvern-of-greatness-248341-mkl@pengutronix.de>
 <3dec8321-5a96-42c0-91d3-d1776e974d73@I-love.SAKURA.ne.jp>
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
	protocol="application/pgp-signature"; boundary="cpw33oruvvjzrlkm"
Content-Disposition: inline
In-Reply-To: <3dec8321-5a96-42c0-91d3-d1776e974d73@I-love.SAKURA.ne.jp>


--cpw33oruvvjzrlkm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
MIME-Version: 1.0

On 14.11.2026 02:44:31, Tetsuo Handa wrote:
> By the way, I don't plan to use b4, for my spam mail filter drops
> mails sent from me.

You have several options to send mail via b4 [1]:

a)
You can deliver with authenticated SMTP.

b)
If you use the web-hook, the emails will be send from:

| "Tetsuo Handa via B4 Relay <devnull+penguin-kernel.I-love.SAKURA.ne.jp@ke=
rnel.org>"

not by "you".

regards,
Marc

[1] https://b4.docs.kernel.org/en/latest/contributor/send.html

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cpw33oruvvjzrlkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavdOqQAKCRDMOmT6rpmt
0rHJAP4y3YrtQJQaiQtvtbQry0tnShathqDp9QWrzN9a8C273wD9EoOek9CK+/E3
XCWbfPWNAFBYz8/RbGXax67Xdj5Z9AE=
=7pgV
-----END PGP SIGNATURE-----

--cpw33oruvvjzrlkm--
