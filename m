From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 11:49:53 +0200
Message-ID: <51668741.6030909@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XGTONEXAFHOVNFCXGKMF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55144 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3DKJt7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 05:49:59 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XGTONEXAFHOVNFCXGKMF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/11/2013 11:22 AM, Mylene Josserand wrote:
> Le 11/04/2013 10:39, Marc Kleine-Budde a =E9crit :
>> On 04/11/2013 10:04 AM, Mylene Josserand wrote:
>>>>> root@navocap:~# ifconfig can0 up
>>>>> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for=
 irq 201
>>>>> mcp251x spi0.0: failed to acquire irq 201
>>>>
>>>> It's a bug in the driver....which was introduced in v3.5[1]. I'm loo=
king
>>>> for a fix.
>>>>
>>>> Marc
>>>>
>>>> [1] 1c6c695 genirq: Reject bogus threaded irq requests
>>>>
>>>
>>> Okay.
>>>
>>> In this
>>> http://markmail.org/thread/uc2adurel247yitp#query:+page:1+mid:uc2adur=
el247yitp+state:results
>>> and this
>>> http://www.raspberrypi.org/phpBB3/viewtopic.php?f=3D44&t=3D7027&start=
=3D150
>>> posts, they set the irq_flags to IRQF_ONESHOT.
>>>
>>> I have tested it and I did not have the error anymore. Maybe it is no=
t a
>>> good way to fix that ? (I don't know what is a "one shot" IRQ) but in=

>>> case it could help.
>>> However, it did not fix my static-mcp251x boot hang.
>>
>> Can you test my patch and give me a Tested-by?
>>
>> Marc
>>
>=20
> I tested your patch and it works ! (As module), I can UP the can=20
> interface and set an IP adress. I did not test much (cansend / candump,=
=20
> ...).

Err... don't set IP addresses on CAN interfaces, that's wrong.

> Sorry, it is the first time I take part of a kernel patch (thank you fo=
r=20
> that !) so I don't know what the "procedure" to give you a "Tested-by" =
? :)

Please do a "real test" and and send and receive some 10k frames. Reply
to the patch and say something like:

"I've tested your patch and successfully send and received 10000
CAN-Frames. You can add my Tested-by: Mylene Josserand
<Mylene.Josserand@navocap.com>"

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XGTONEXAFHOVNFCXGKMF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFmh0QACgkQjTAFq1RaXHMYOgCcD7jnelh+wtJ7zNPMHjiaMzxg
TI0AnA9ZRmX5mNYsV6NgSZwhYDmNDI6O
=+s+H
-----END PGP SIGNATURE-----

------enig2XGTONEXAFHOVNFCXGKMF--
