Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D643F4A3;
	Mon,  5 Oct 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192749; cv=pass; b=HFiztJm8Y3j67nb5QsygGJEXqiCiwy1bUftqIqqyiyCvP4kY8B3VCIA/RBm50FKzwZIJgvEtu5rA32FhnNB5gJqywRTVr+4HOcTzi6Z1iuF/ZxUwvFPGCFchvU0gp2Gj3hpSwn1TjyEHvksg8catqcc0lOduAjZ4iuGFZRGZHZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192749; c=relaxed/simple;
	bh=bCJkJEdc5JVUhCBqgK6K8IaNGZIBrIxxJEIm5hI3dCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8xoTzJyTYzyloZBap6MiDlorM4hkj2lO7aNUSS0HE8n3XDv5BeeoVL5AXkAN2hlhw81wl/rGQePVw8HrgDYyrBFCTcqKyJp0LbTwCeBZO4mLK5LNLbhLbz3hKLJUANvBuTruagHggKk0xXqurmpc9QBNhhFBz834WFeIS17Z7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GQ7we3r0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GQ7we3r0"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3696C201DCD;
	Mon, 05 Oct 2026 11:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12NWJYavUebVU99Z1JapDBaS31SkZ9WxETeE663CSAg=;
	b=GQ7we3r09tE5HY9I3sOwxBW+CBKNVPN6S3rvlD73stvpnHn+Tk5Ty48Q6J6JsCvkKTJ32Z
	ogopbs/ZBUliMjp662XHLHPusLskekaXJoxTy8A2j8Q7mfarq12viKnnZulXcURcp+G3vf
	GdIXrx2V8SOUoXE5n2l+RIDbpcm7PKCctRgb1+6Vxv6ONTpDVaaghcTeqIkvmWF0rwChY/
	aDFYEk9ESmyMz7K5/WnE/xVuWuvLGUz8GgCCYiBx+W3VvQCzpWvWC4g73+TqNN+QQ3SgIc
	HGGIBMCP1Y73+2wnSDY6BY7gD13QN9ym3+JMh208QuYbQ0eaIbm6h0QNfJf2pQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791192745; a=rsa-sha256;
	cv=none;
	b=XRWqywju3uVy39TieNe6vPBn9QEbzSUj+OUEE45MLPqKjQF4SCAuft/hkiGkNyNSUVy84n
	8bzMDe/LfkJrrw/7Heul0RzcmmyIZyuaBI4xKEf6hx86yAaAImSvH+uNtGqPzRt+glcBP/
	ha4tlXlnGsgaYFaJ36nmlBoVRyOj/h4Czb070D0SHJutNZGjccGdjJZqpzAt3CSkFnrQn2
	R8w1m/It/uJZVDhtW4V7gcvTzdYjLOIcKp5WUxit4QgqjOm6J1/ofH+Unx6OT2/I7o3G6W
	uxoR4pxjXXkMFdxvVY5n04Nnd/t+d6c9vXTZvNEjyS+UsRkDlugU0iUCHonYpg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12NWJYavUebVU99Z1JapDBaS31SkZ9WxETeE663CSAg=;
	b=gCL30YS8GQDhtv8P8dSX7dLO488EgF/y2sVTW8Z9sEYhujVdXW/B6kOUxDSAIPb9lLcqdS
	lr2mXVgRpZNJtSb06puMvfVI6KPAiXEL7nMm+VND78jsA4tn5BdwUqop34gpAf1jbe/o3L
	lwwPLDUzj8iLA3NriwkjPsBPDw/JW567pSuTNIH6ntQHgKDPF+ASBqxXYnn+0i/m5hK6Ke
	qJ4uMjiUgfa9SBo8ioD+7CnZ2m73k89S4hOPQ+9S99dqn7QCkpFQQjTI6YWK4CJEXGbMNQ
	P1xBGI5F9Vmtahn+q68KCQsgfnG31icaIAbATPHIohupIHdQRhp4gVll1ITqTw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDf3Z-004MSa-0L;
	Mon, 05 Oct 2026 11:32:25 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A05E75BA016;
	Mon, 05 Oct 2026 09:32:24 +0000 (UTC)
Date: Mon, 5 Oct 2026 11:32:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, ore@pengutronix.de, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261005-speedy-imported-beetle-d1abf0-mkl@pengutronix.de>
References: <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
 <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
 <20261001082552.514c54fd@kernel.org>
 <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
 <20261001111954.2ebaf14c@kernel.org>
 <57de2511-fb5a-4689-bc21-2a9fe25761fc@hartkopp.net>
 <20261005-prophetic-civet-of-faith-08ea65-mkl@pengutronix.de>
 <fe6d19b7-31f1-4559-b313-da4e2bb6ff98@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74df2dxc7ww4fkga"
Content-Disposition: inline
In-Reply-To: <fe6d19b7-31f1-4559-b313-da4e2bb6ff98@hartkopp.net>


--74df2dxc7ww4fkga
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
MIME-Version: 1.0

On 05.10.2026 11:24:48, Oliver Hartkopp wrote:
>
>
> On 05.10.26 11:20, Marc Kleine-Budde wrote:
> > On 05.10.2026 09:28:13, Oliver Hartkopp wrote:
> > > Hello Jakub,
> > >
> > > On 01.10.26 20:19, Jakub Kicinski wrote:
> > > > On Thu, 1 Oct 2026 17:38:17 +0200 Marc Kleine-Budde wrote:
> > > > > On 01.10.2026 08:25:52, Jakub Kicinski wrote:
> > > > > > > Don't know Oleksij has done the sashiko.dev integraton.
> > > > > >
> > > > > > Let me try to plug you into netdev-ai one for now.
> > > > >
> > > > > Thanks, do you need anything from us?
> > > >
> > > > I don't think so, we already had the setup for the old AIR system.
> > > > The emails should start flowing in a day or two. Please let me know
> > > > if you don't see any review out by Monday!
> > > >
> > >
> > > The new netdev-ai picked some older can-ML patches for an additional =
review
> > > but not the important latest "[PATCH net 0/3] pull-request: can 2026-=
10-01"
> > > which is still only reviewed by gemini-3.1-pro-preview :
> > >
> > > https://sashiko.dev/#/patchset/20261001151905.1556270-1-mkl%40pengutr=
onix.de
> > >
> > > Should Marc resend the PR or can you trigger its review manually?
> >
> > =F0=9F=91=80
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001151905.1556=
270-1-mkl@pengutronix.de
>
> Ah, thanks! Did not see that. Too many URL locations ;-)
>
> So the can 2026-10-01 PR can get into upstream.

FYI: I've commented on the "high" severity issue (which is actually a
pre-existing one):

https://lore.kernel.org/all/20261005-weightless-fat-seriema-802f2e-mkl@peng=
utronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--74df2dxc7ww4fkga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasNupQAKCRDMOmT6rpmt
0sN6AP4p2zDwxkKs5OZQJ2QIDegrLZ4NPi8ZdfigeovyOsfBKwEAwRMkDXjd3lls
Wnx3+KDenmAgMrXlSpJe89GuHrTNDws=
=Hypb
-----END PGP SIGNATURE-----

--74df2dxc7ww4fkga--
