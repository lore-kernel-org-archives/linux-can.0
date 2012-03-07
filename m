From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 15:13:14 +0100
Message-ID: <4F576CFA.6020107@peak-system.com>
References: <20120306112108.GA4362@elgon.mountain>
 <20120307122112.GC674@mwanda> <4F57549F.3050309@pengutronix.de>
 <20120307131741.GD674@mwanda> <4F5761F2.5010301@pengutronix.de>
 <4F576B3C.7000607@peak-system.com> <4F576BA7.6080406@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:49885 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2CGONW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 09:13:22 -0500
In-Reply-To: <4F576BA7.6080406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-can@vger.kernel.org

Le 07/03/2012 15:07, Marc Kleine-Budde a =E9crit :
> On 03/07/2012 03:05 PM, Stephane Grosjean wrote:
>>>> That's my guess too.
>>>>          __le32 tmp32 =3D cpu_to_le32((cf->can_id&   CAN_ERR_MASK)=
<<   3);
>>> St=E9phane, do you want to make that patch?
>>> Add my Acked-by and a
>>> "Reported-by: Dan Carpenter<dan.carpenter@oracle.com>"
>> Ok I'll do it as soon as I did small tests to check.
> Have you got a big endian machine (powerpc or an ARM IXP in Big Endia=
n
> Mode) somewhere?

No sorry, I only have little-endian machines here (x86 and ARMle). I=20
just talked about small non-regression tests.

Regards,

St=E9phane


--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
