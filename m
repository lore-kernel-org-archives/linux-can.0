Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C78448BAA;
	Tue, 18 Aug 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046847; cv=none; b=N18k9LGLdnZPCRsQvqE+p51NXXYAtrJZZbaEqyLjtahMzCYDwesoKJfhUkQ9CnJOhU6slk2lJv2juTpD/bC+VjMV6HijNKCrERoeBKwKM9L+JBSIG+46c/v8msrv3M5x6qqBGRQyjEOyFeK6LRVldrHtn6M63c4lWR5YJezh43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046847; c=relaxed/simple;
	bh=CNVS4CTw9xZGyKkzwORuges4kfKFqS5O9IVCKOGlZUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSRJ7tkODXXN4wQUwCDJTlkDxPaApq/F3L3nZ2QxO5msfGvGUE8WcZJRPn2lCm6xrlf8xsbsZhrrj4mC/Qv6J8A9jDqSwbA438gu2eJKzxreRgdNPluDdfxw1L4vL/avOkqqVtri4ML2StmJ3H1Puxpxq/uqdUWkHV+oCyRivNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ECCD720102E;
	Tue, 18 Aug 2026 11:54:01 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwGW9-0026Q8-2k;
	Tue, 18 Aug 2026 11:54:01 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DAA5585723;
	Tue, 18 Aug 2026 09:54:01 +0000 (UTC)
Date: Tue, 18 Aug 2026 11:54:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Ondrej Ille <ondrej.ille@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Avi Weiss <thnkslprpt@gmail.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Jiri Novak <jnovak@fel.cvut.cz>
Subject: Re: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit info
 messages on Arbitration Lost or CAN Bus Error IRQs
Message-ID: <20260818-optimistic-woodlouse-of-cookies-972baa-mkl@pengutronix.de>
References: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
 <202608150102.34461.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4kq5ebrnds6t3qr"
Content-Disposition: inline
In-Reply-To: <202608150102.34461.pisa@fel.cvut.cz>


--t4kq5ebrnds6t3qr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit info
 messages on Arbitration Lost or CAN Bus Error IRQs
MIME-Version: 1.0

On 15.08.2026 01:02:34, Pavel Pisa wrote:
> Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

Thanks

> In the fact, I am in doubts if ALI Arbitration lost interrupt
> should be enabled even by CAN_CTRLMODE_BERR_REPORTING unconditionally.

ACK

> There are lot of situations when error reporting is valuable
> but overhead of arbitration lost could load system quite lot.

ACK

> But on the other hand SocketCAN does not provide separate
> reporting option to enable can_stats.arbitration_lost
> updates

If needed, this option can be added.

> so current code in ctucan_chip_start is proper option

So I'm thinking of sending a patch to disable the arbitration lost IRQ.

>
>
> 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
> 		int_ena |=3D REG_INT_STAT_ALI |
> 			   REG_INT_STAT_BEI;
> 	}


> PS1: I have been on vacations without e-mail and I will be next
> week too, so sorry for possible delays and these PSs to
> wrap up quickly what seems on hold before my leave.

Enjoy your leave and e-mail free time!

> PS2: Marc and others, please, can you confirm if my patch
> "docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CA=
N FD"
> https://lore.kernel.org/linux-can/d775feefa1c16d7ea7f42482483c81491f75ce6=
c.1785574572.git.pisa@cmp.felk.cvut.cz/
> is on the right track or if I should repost it to somebody
> other than Randy Dunlap and linux-doc to reach right
> documentation maintainers.

I've included it in yesterdays^w todays PR.

> PS3: Marc, please, have you received my question about problems
> with CAN FD on iMX8plus CompuLab's IOT-DIN-IMX8PLUS.

yes

> Even manual specifies it as Std CAN only... Can it be
> related to some SoC problems, even much lowered speeds
> do not help so probably not transceiver HW, may be missing
> information for TDC in DTS???

The flexcan driver is not attached to the kernel's TDC infrastructure.
Maybe it needs some improvements.

> PS4: LPC and Open Source Summit Europe will be held in Prague.

I'll be there for LPC and E-OSS.

> Our submissions to OSSE have not been accepted, one
> is on wait list still. Price is too high for my budget
> when I bring open technology to others. I am not sure about LPC,
> I consider to pay for Real-Time and Scheduling microconference
> or something like that. I could presnet something about our mainline
> and RT CAN latency testing or our other RT, RISC-V embedded
> knowledge if there is interest and suggestion for miniconference, BoF,
> so then I would be allowed. Anyway if you have interest to meet,
> I will be in Prague and when not teaching, I will be happy to
> reserve time. There would be real local enthusiast, free community
> and access conference before these Linux Foundation ones
>
> https://www.linuxdays.cz/2026/
>
> I expect to show our HW ZOO there on the booth there as usual
> so you can visit us at our university ground.

I will arrive on Sunday, but I haven't booked a train yet. When does the
conference close on Sunday?

> If there is interest in some community open and free access
> meeting then I can negotiate lecture hall, computer rooms etc.
> at our faculty when they are not used for teaching or other
> events. For something relay interesting which fits in weekend
> October 3-4, I would consider even abandon part pr whole of my
> LinuxDays presence. No chance to meet during weekend after LPC
> and next days, I have already taken these by Apache/NuttX conference
> in Glasgow where we present our projects including Matlab Simulink
> target for NuttX (and Linux).

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t4kq5ebrnds6t3qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoQrtgAKCRDMOmT6rpmt
0rQBAPwNtMm9+PH3PatdonCiN5LT1FcXP8oyI6CI41eIVlm+BgD/Xmo/02tvdw/Y
Gh0DQWWEVCx9jhh5huqJzf/tFTa/ew8=
=VpK/
-----END PGP SIGNATURE-----

--t4kq5ebrnds6t3qr--
