Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9024718D7;
	Mon, 12 Oct 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814140; cv=none; b=kCNE9Tqniubb6vTPxohzmzuKZ1jIuoc/fys5+dLW03JfpndP2YveYyqayXvjci3qJl8b+UNRNoxKTKft5vcT5Zj9iHtYaRsNa04pHHWcq461W7c7F0bhh+spvhxnAD4BGvohaUoxjoXFOl2DA9NteAcfwmmwgUsLx8o6kDMVe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814140; c=relaxed/simple;
	bh=5NqQN3twOjvV7VGfTkFD+oEXAYL6fnAiqaDrnzcTQ3k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=AmVgARNGrlmQDhrJj6oNqQcU+/3DPEen+sumVqnOsBKOFzdtOFGCRL+qGlVRGR0EHS3D3XF1+csornk8tzppaQImTkwQvPioCODZzRSTdf2V3nFjsHo9xlh1G8tsHWT15aq4yfVOyus31kp0APEc4nRcZEq1gU/JDmUfUtiQg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=jWeXkbli; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="jWeXkbli"
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 6BB0D2003E8;
	Mon, 12 Oct 2026 16:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791814128;
	bh=5NqQN3twOjvV7VGfTkFD+oEXAYL6fnAiqaDrnzcTQ3k=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=jWeXkbliblbXZEB+GRsipSUFyc4I9qXVJwVH8Je4mZ6zLpidSryzVt0b7ZP/FwQ4K
	 N/KljX8Vzw8L4lPgv85RHqM20u99S2kGLqO2qHJU3O0h7BLL+J+JhOK745NxzYsS46
	 FCGFa0QRGEZyqL/9LbjLvcPhqg3/mJdUdTXgmnIy7vKkcsJ1+mtjc2E1MaLmjzJ2QS
	 9eYCHpcpGFGN7XG36502pp3LTwC2Ko1J3IQ0OAWOhedyTBC3uBvwgwym5WIF7IORTf
	 t3+RCjHmKhAGD++8D+8fRylhLlzS1zHamquDJpi1LX7vvKi8x3u4LibdI3EJGq2xnq
	 GS/jP0z9R/Cfg==
Date: Mon, 12 Oct 2026 16:08:47 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Message-ID: <1228378911.1051074990.1791814127665.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20261012-rare-pigeon-of-elegance-6014fe-mkl@pengutronix.de>
Subject: Re: [PATCH 4/5] can: peak_usb: validate channel numbers in PCAN-USB
 FD
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC154 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Thank you so much for your help, Marc. I really appreciate it.

Best regards,

-- St=C3=A9phane

----- Mail original -----
> On 12.10.2026 11:04:56, St=C3=A9phane Grosjean wrote:
> > I need help (or training) to figure out how to deal with these AI
> > bots:
> >
> > - How many of them are there before the changes are accepted? It
> > seems
> >   that even if a patch has passed the Sashiko filter, we should
> >   still
> >   expect feedback from other bots...
>=20
> There's https://sashiko.dev/ , which replies within minutes (as long
> as
> you don't include the netdev mailing list).
>=20
> And there's https://netdev-ai.bots.linux.dev/, which embargoes the
> review for ~24h, but runs several LLMs with better models.
>=20
> > - The fact that there are multiple levels of bots isn=E2=80=99t a probl=
em
> > in
> >   itself, and is understandable. That feedback arrives on v1 even
> >   though
> >   v2 has already been analysed is also something I=E2=80=99m just learn=
ing:
> >   so
> >   when can we consider it safe to push a new version without fear
> >   of
> >   receiving comments on the previous one?
>=20
> Maybe you can mark the v1 as obsolete yourself with replying "pw-bot:
> cr".
> On a new line, without quotation marks, see:
>=20
> https://github.com/linux-netdev/nipa/blob/main/mailbot.rst
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updat=
ing-patch-status
> https://github.com/linux-netdev/nipa/blob/e03d912ce66fd5d427cb9cf900409e1=
abc6eeba2/mailbot.py#L52-L81
>=20
> > - And finally, providing more explicit comments on our changes is
> > also
> >   a good thing. But when those comments themselves become a source
> >   of
> >   problems and rejections=E2=80=94due to an overly nitpicky interpretat=
ion
> >   by a
> >   bot=E2=80=94it becomes far too time-consuming:
>=20
> yes known problem :/
>=20
> regards,
> Marc
>=20
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
>=20
