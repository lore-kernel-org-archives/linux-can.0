From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Thu, 03 Sep 2015 11:16:35 +0200
Message-ID: <8605150.LGJ155yN3b@ws-stein>
References: <55E6CCC8.7010908@picquet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:34647 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbbICJQm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Sep 2015 05:16:42 -0400
In-Reply-To: <55E6CCC8.7010908@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>
Cc: linux-can@vger.kernel.org

Hi Guillaume,

On Wednesday 02 September 2015 12:17:44, Guillaume Picquet wrote:
> I=E2=80=99m doing tests on embedded hardware with integrated CAN bus =
interface=20
> (based on AT91). The driver provides Linux Socket API and I try to se=
e=20
> the limits:
> I have one transmitter that writes CAN frames (CAN_RAW) as fast as=20
> possible and a receiver that reads continuously.
> After a moment the receiver gets an error frame signalling RX overflo=
w.=20
> I have no problem with that, it's normal and expected.
> But question is why at this point no more frame is received ?
>=20
> read() do not return, I've tested also with select() which return tim=
eout.
> (The restart-ms option is set)
>=20
> I expected some dropped frames and others RX buffer errors but not th=
e=20
> end of reception.

Maybe you are hitting the same problem as I was last year: http://marc.=
info/?l=3Dlinux-can&m=3D141225364212703&w=3D2
It seems the at91_can driver hasn't changed essentially since that time=
=2E So please give the patches Marc sent today a try.

Best regards,
Alexander
--=20
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
=46ax:    +49 (0) 3765 38600-4100
=20
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

