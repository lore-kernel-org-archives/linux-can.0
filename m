Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F15013BC;
	Wed, 30 Sep 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778301; cv=none; b=aEVu/sGgTSHBF88lE45zKwE2bUEJNoLgeY2r+gQ25ZkmDDxZKsD9yupoIWqJSKTd4DQ4JgYO3qe/IGPgWxFPuDXEcS769B7nb9ydaRhYLkyQ1r3VBA1gGrvdyIj4U1JqGS/RRYAqEI8ev7Wm9xGMSleeKG9sOb8vAk8eet2HLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778301; c=relaxed/simple;
	bh=Ob/WFEhtiG/vySjXgXqfPfTA9ToAjDkVPZeXU4RVCNg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=MWg1XzsWckuHqbX18lWmRBemEBHVslPyOnyA0zAxDwyAtCSSHfNL9iHY8Fgq7ZVGftP4BhHAbApeHI5zVLgDvYGtQv7GzIu+S9CuJExXtA99lEZqEmiODnIXfd4c2UMd1ik/SYlcjgdaSPQZYiaJ89KEINUj7yic9J+Cmjp7RIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vH5BTQLo; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vH5BTQLo"
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp6-g21.free.fr (Postfix) with ESMTP id F1AC2780375;
	Wed, 30 Sep 2026 16:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790778285;
	bh=Ob/WFEhtiG/vySjXgXqfPfTA9ToAjDkVPZeXU4RVCNg=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=vH5BTQLo8DAko0GSLaTlt/8Ab5sLu1CdmBTiTgFtajB4TMJ0VCOMW5eXDfgR3EAKW
	 KGHEfBcwkHZuG6yZ5cB0j8EcLUQ0CQqEXo6NLcwp84Hg2n1ZKaMhOSuQ3NWnbykjrr
	 HS+WVNmD5j3fPKUOwJ7pwxhh1MiBH1R/RXqDwjvXVyqpZMXy5xqxZSEjihMvYwemPy
	 0wXEX33gH2oqZ/9LjGJ6Ci5bjtKQCWSlFqL2cipmtDJxM4W6iZnhsAmSu27203cqQ+
	 ckX/w7hTjS/Jv1HAtEuZvea90S1duyPPwPvNh3BnFSh/L1a7+t1efNtclU0xHzV2aX
	 EE7AAnPdr7G1A==
Date: Wed, 30 Sep 2026 16:24:44 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <s.grosjean@peak-system.fr>
Message-ID: <700277696.812114266.1790778284780.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20260930-foamy-nostalgic-elk-30d429-mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC151 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

> > @@ -1266,7 +1272,7 @@ const struct peak_usb_adapter pcan_usb_fd =3D {
> >  =09.ctrlmode_supported =3D CAN_CTRLMODE_FD |
> >  =09=09=09CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> >  =09=09=09CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
> > -=09=09=09CAN_CTRLMODE_BERR_REPORTING,
> > +=09=09=09CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
>=20
> Can you keep the CAN_CTRLMODE sorted by their value?
>=20
> Please make an incremental patch for the CAN_CTRLMODE_BERR_REPORTING,
> I'll squash that...and add CAN_CTRLMODE_LOOPBACK in the appropriate
> place.
>=20
Hello Marc,

Do you want me to post a v2 of this patch with the CAN_CTRLMODE flags sorte=
d by value, or do you prefer a separate incremental patch on top of the bus=
 error reporting series?

> Marc
>=20
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
>=20
