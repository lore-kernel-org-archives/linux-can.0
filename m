Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2200286881;
	Tue,  6 Oct 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299479; cv=none; b=rQBHZgzuq7aec+/5MlRFXTwh73ngMRpA5Ktv6xFCQzSXqI6nwM6N6yfTEGZ+Rik8CdCbQkPm16oBU9EfGZqdJE7W6cTVvvcDnZfpUdUPgqhjQ3aV1SSt8S4EmdSdIKs9KBzszuRfeP2p1CCu87kUjGgWP7MeLm20ZpR2GdbgkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299479; c=relaxed/simple;
	bh=VZFJvVMUGIK0cCNKxz1sZJdh4ECX4ohLDPCHwrGg9Cw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=KhsOnoMtRtPK66on/XEx8m2NAKyF7aKBGVfsFmfY4blfsI3S5olIr2Le985zgbvF5HIVbBw2xurcaJm1hHWq+a6MUyeSTG+HIE/jx9dPbTqmRkP+3Ue2RoYPUjTl3i/dutt8tgVPpw5Nlo0T8KxJ0XJT7XaUhkrQ+cDTEUpGPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=jwLaAopR; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="jwLaAopR"
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 0CB9AB00539;
	Tue,  6 Oct 2026 17:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791299469;
	bh=VZFJvVMUGIK0cCNKxz1sZJdh4ECX4ohLDPCHwrGg9Cw=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=jwLaAopRJmSLNgERfbWKyUGfGgBlaMfjcUOrbPRiOdSWwAP7rxtpQo5mnxGN1nNgg
	 KgUUpHOW2PhhKRRyRQGADaTL0yWJx5/D4OzTGjZO9pUVTb7NAUkDaIVS2JrCKHgEyH
	 MfC461Neqek5MEt09PTohbHKZm2iIDuCx2VKw0Xe8JUC9fvaVEpARdneT4Qr+1ypHX
	 GiE1QYeBK2FPNPWD9AP6NIgbh5SBzGsoJMeJuJ2yeCg2b22hqkPIudiwaaQ1l9PmGP
	 3+QmI6HjsczFzvqDGE1Bp1VWxt19vn6uCaH6/9pzCXx/uQwXGWw+sYrlELD6zT7QR0
	 QSQWMmAfAokrQ==
Date: Tue, 6 Oct 2026 17:11:08 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, s grosjean <s.grosjean@peak-system.fr>, 
	kuba@kernel.org
Message-ID: <597196165.930416749.1791299468914.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20261005-ancient-viper-of-swiftness-c884c3-mkl@pengutronix.de>
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
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

Hi Marc,

I think I've pulled on a loose thread and ended up uncovering a much larger=
 issue.

My original goal was to work on some improvements and cleanup for the PEAK =
USB drivers. However, while reviewing the series, Sashiko started pointing =
out places where the new code was still trusting data received from the USB=
 device without sufficient validation.

After fixing those issues and respinning the series, the next round of comm=
ents raised a different question: if these checks are necessary in the newl=
y added code, why are similar assumptions still present elsewhere in the dr=
iver?

The more I look at it, the more it seems that I'm mixing two different obje=
ctives in the same series:

- functional improvements and cleanups intended for linux-can-next,
- hardening changes required because USB devices can no longer be considere=
d inherently trustworthy.

Given that every new fix tends to reveal additional places where the driver=
 relies on the same trust assumptions, I wonder whether it would be better =
to pause the planned enhancements for now and first perform a dedicated pas=
s over the entire driver focused on robustness and security.

My idea would be to start with a separate series whose sole purpose is to a=
udit and harden the driver against malformed or unexpected data coming from=
 the USB device, and only resume the functional improvements once that base=
line is in place.

What do you think?

Best regards,

St=C3=A9phane

----- Mail original -----
> On 05.10.2026 16:22:12, St=C3=A9phane Grosjean wrote:
> > Can you let me know if I need to make changes myself to these
> > patches
> > you sent,
>=20
> Sure!
>=20
> > and if so, how? (Should the new requested changes=E2=80=94which are
> > unrelated to the original patch=E2=80=94be included in a new version? O=
r in
> > a
> > different series?...)
>=20
> As I'm not planing to work on this series, feel free to take it
> (including my patches), add your changes and send a v2.
>=20
> FYI: you can import the series to your b4 with:
>=20
> | b4 prep -n peak_usb_enhancements -f net-next/main -F
> | 20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de
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
