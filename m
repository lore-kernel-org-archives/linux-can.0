From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Re: [PATCH] can: update documentation wording error frames -> error
 messages
Date: Wed, 9 May 2012 17:09:38 +0000
Message-ID: <D6B800AA-023E-43AE-8D82-B7FEDF74B5F7@port.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
 <4FA98011.3020600@hartkopp.net>,<4FA98441.8090308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:37140 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758439Ab2EIRJn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 May 2012 13:09:43 -0400
In-Reply-To: <4FA98441.8090308@pengutronix.de>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,=20
I can not check before Saturday. Sorry.
Heinz


Heinz-J=FCrgen Oertel

Am 08.05.2012 um 22:38 schrieb "Marc Kleine-Budde" <mkl@pengutronix.de>=
:

> On 05/08/2012 10:20 PM, Oliver Hartkopp wrote:
>> As Heinz-Juergen Oertel pointed out 'CAN error frames' are a already=
 defined
>> term for the CAN protocol violation indication on the wire.
>>=20
>> To avoid confusion with the error messages created by CAN drivers av=
ailable
>> via CAN RAW sockets update the documentation and change the naming f=
rom
>> 'error frames' to 'error messages' or 'error message frames'.
>>=20
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Sounds reasonable. Heinz-J=FCrgen, can I add your Acked-by: to this p=
atch?
> It means that you've read the patch and think this is a good change.
>=20
> Marc
>=20
> P.S.: Oliver, try to use: "git send-email", it much easier for you to
> send patches than to copy/paste it to thunderbird.
>=20
> --=20
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>=20
