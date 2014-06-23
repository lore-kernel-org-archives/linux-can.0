From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Gitorious] Activity: prabhakar requested a merge of prab...
Date: Mon, 23 Jun 2014 18:46:29 +0200
Message-ID: <53A859E5.7050107@pengutronix.de>
References: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail> <53A851DC.2060801@hartkopp.net> <53A85445.8070400@pengutronix.de> <53A8560F.4060607@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="S4gNx2LwVcmnWcG9dRAeRubudHXUpDvgs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33782 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274AbaFWQqf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 12:46:35 -0400
In-Reply-To: <53A8560F.4060607@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, prabhakar.csengg@gmail.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S4gNx2LwVcmnWcG9dRAeRubudHXUpDvgs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2014 06:30 PM, Oliver Hartkopp wrote:
> On 23.06.2014 18:22, Marc Kleine-Budde wrote:
>> On 06/23/2014 06:12 PM, Oliver Hartkopp wrote:
>>> Hi Prabhakar,
>>>
>>> thanks for your patch.
>>>
>>> Can you please send it with git send-email to the mailing list for a =
review?
>>>
>>> Additionally:
>>>
>>> Does this patch introduce any backward compatibility restrictions (e.=
g. you
>>> need at least the includes from 2.6.14+ to build candump ...).
>>
>> When was CAN support added to the linux kernel? :)
>=20
> I know that you would detect this joke ;-)
> Btw. I backported SocketCAN to 2.6.13 - so my question is not totally
> brain-damaged when talking about the can-utils which are not sticking t=
o a
> specific kernel version.

I was assuming that there was a certain seriousness in your statement :D

Do you mean the inclusion of "sched.h"? I think this comes from the
glibc. However, we can add autotool support to detect this.

>>> You only provide to configure a value for SCHED_RR.
>>> Does it make sense to provide other scheduling policies too?
>>
>> I would use chrt to start the tool, if I need non standard scheduling
>> policies.
>=20
> But then you would like to specifiy the scheduling policy??

You can use chrt to start another program with different scheduling
policies, it's like nice, but with more functionality. See man page of
chrt for more information.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--S4gNx2LwVcmnWcG9dRAeRubudHXUpDvgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOoWeUACgkQjTAFq1RaXHNHhQCfSAHPg5aT5tA1amJ9mT8orTX0
/YMAnRN+dawK7hXx6plrSQ9EhwaQsn+E
=JSgf
-----END PGP SIGNATURE-----

--S4gNx2LwVcmnWcG9dRAeRubudHXUpDvgs--
