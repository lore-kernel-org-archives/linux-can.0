Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FC49250D;
	Wed,  1 Jul 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921744; cv=none; b=Jj7JUEs091zNMBV5D70yxoXmay4GGWcWN5f30jYbbnR0lZstiGQU2MEAiwn1SznTJ/kFs3ta77mzlRD+MAoMTmdx7IjZHS1xiPNrXnwwknPL68q0LMguz9TWcm/X+QD/LrfO38DHp7yg0T7/1XnIqHMbMgp0iW7aeV4D5KYtP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921744; c=relaxed/simple;
	bh=AG83QuzuUjrjSLK52HpMiWn4MKRX6i2rEPMtXcZoDSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAJwf0lTbPlAEenhn3o6hp92XjuOZiVizvKWWDRyRA9rmJgKTZ+n+CIYLRosQt0G6k6CKYVmlEN5vNAQX9hnPaTKq1nPWUMYC/JFpCoXur873TaZvFwj/Q/qp8qp5C2JlzgH/k3SP25mD1RXDcd81b2Q3+wxl8iqXKPb5B7oRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MaTGrKK+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MaTGrKK+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Oi59Gfv03QRh4wuEQ3UJG1fGRKD0h5n2wK8ssSfHsFY=; b=MaTGrKK+eqnG+SYj6BecTVg4tW
	7qdxK+Va41Q2jRAT+9P3v8pxHfhrcHqMtM0ibxcke4vKH8rCytyJ5qNXhNiPiPlw7DlvHvWuAPj/b
	vEzF/SktlyChlwRuHUHMup59gXxjv9f5OA8ur9ozlYgSkytj0D7Y3tS6nkskdPA6syEzkUyFnz8DT
	9XXxi41yPrqj3MDFzGyFtq/Up91i4+qDj2lA4ZUy+FDVdkSVkCRzYSycpnyM+fOwlV4iQCmEkssL4
	urBkcySQ3HphZQ2h7vbr4Qm7iVrhM4RZntqzA3KBN8ad0mcymjnmgG1b5p6DbRWg+MwZufHFsSLAF
	+2QOQenw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?B?8J+Sqy4yMjA=?= <1579567540@qq.com>
Cc: linux-can <linux-can@vger.kernel.org>, mailhol <mailhol@kernel.org>,
 kernel <kernel@pengutronix.de>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Date: Wed, 01 Jul 2026 18:02:02 +0200
Message-ID: <3077724.o0KrE1Onz3@diego>
In-Reply-To: <tencent_AF88C27E354DFF34B132BC0906236A01A408@qq.com>
References:
 <20260701070128.2096267-1-1579567540@qq.com>
 <20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
 <tencent_AF88C27E354DFF34B132BC0906236A01A408@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 1. Juli 2026, 14:29:22 Mitteleurop=C3=A4ische Sommerzeit schri=
eb =F0=9F=92=AB.220:
> Hi Heiko, Marc,
>=20
> thanks for the review.
>=20
> > please use a real name, not an alias.
>=20
> I will use my real name in future revisions.
>=20
> > Funnily enough, we seem to have worked on the same topic
> > at the same time :-)
> >
> > https://lore.kernel.org/lkml/20260630164336.3444550-1-heiko@sntech.de/
>=20
> I missed Heiko's series before sending mine, sorry for the noise.
> (But it really is a very interesting coincidence.)
> Since the series overlap, I am happy to base further work on Heiko's
> series, or to let Heiko fold the RK3588 RX_FIFO_CNT bitfield change into
> his v2 if that is preferred.

I don't think we need two people working on this and you did the better
investigation into the differences, so you should get the credit :-)

So I guess my preference would be to:
=2D pick up the erratum 6 into your patch
=2D add my haikou patch to the series - that way we also get a user
=2D handle Krzysztof's comment from
  https://lore.kernel.org/linux-rockchip/20260701-sensible-cryptic-ocelot-5=
8035b@quoll/

  as both our bindings have the same structure, so I guess it should be

    oneOf:
       - enum:
             rockchip,rk3568v2-canfd
             rockchip,rk3588v2-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd

And submit that as v2.


> For RX_FIFO_CNT, I found the bitfield difference by reading Rockchip's
> vendor kernel 6.1 driver and comparing the CAN support for RK3568 and
> RK3588. The vendor driver uses different RX FIFO count bitfields for the
> two SoCs, and my testing on RK3588v2 also indicates that bits 7:5 are
> needed. I can add a short note about this in the commit message or
> code comment.

It's already in the commit message, so that should be fine


> One more question about RKCANFD_QUIRK_CANFD_BROKEN: in my RK3588v2 test
> setup the two known CAN-FD trigger frames did not cause an Error
> Interrupt or Error-Warning. I also ran a 12 hour CAN-FD stress test with
> can0/can1 directly connected, 200 MHz CAN clock, 500 kbit/s nominal
> bitrate and 1 Mbit/s data bitrate. That test included periodic
> transmission of the two CANFD_BROKEN frames, variable DLC CAN-FD frames,
> CAN-FD+BRS+EFF load, and a canfdtest run with 19,417,129 frames without
> data mismatch.
>=20
> Would it make sense to leave RKCANFD_QUIRK_CANFD_BROKEN disabled for
> RK3588v2, or have you seen this issue on RK3588 as well?

I was more going by the fact that even Rockchip removed every mention of
the -FD from all documentation, so was assuming it still being broken as
before. But if it actually works, then personally I'm more than fine with
enabling CAN-FD :-D .

I guess Marc might have more insight where the FD issue triggered on
the RK3568.


Heiko


