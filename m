From: Steffen Rose <ro@emtas.de>
Subject: Re: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 18:36:53 +0200
Message-ID: <4764001.1dH8LXDQX4@lisa>
References: <544A2943.1080808@marel.com> <544A64A1.3050104@marel.com> <544A78A8.40909@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50953 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763AbaJXQhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Oct 2014 12:37:34 -0400
Received: from lisa.localnet (unknown [192.168.0.254])
	by kolab3.emtas.de (Postfix) with ESMTP id ED1AD5E28DF
	for <linux-can@vger.kernel.org>; Fri, 24 Oct 2014 18:37:38 +0200 (CEST)
In-Reply-To: <544A78A8.40909@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

Am Freitag, 24. Oktober 2014, 16:04:56 schrieben Sie:
> > We can do little if the CAN controller does not notify the Software
> >> via interrupt.

> > Yes, that's why I wanted to figure out if it's a controller problem=
 or
> > not.
> > Turns out it's a controller problem, but perhaps we can work around=
 it?
> > E.g. if we check esr for state changes every time someone transmits=
 a
> > frame, both of these problems would go away. Would it be unacceptab=
le
> > overhead to do so?
>=20
> I've just confirmed that this "fix" works, but only if berr-reporting=
 is
> enabled.

Is this workaround working in case of an open CAN Bus?
(Ack error situation)

The flexcan can generate an error interrupt after every CAN bus error. =
But in=20
case of an error situation the interrupt load would be very high (e.g. =
short=20
circuit of the CAN).

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen

Steffen Rose
www.emtas.de
