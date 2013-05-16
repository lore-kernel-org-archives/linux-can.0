From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: command ip -details -statistics link show wlan0
Date: Thu, 16 May 2013 17:37:53 +0200
Message-ID: <5194FD51.1030803@pengutronix.de>
References: <CAOD0pe=EMt3+ymJMwT+gOUbFZN7_R8exkh36G5457O61GoV4UA@mail.gmail.com> <5194846B.1070307@grandegger.com> <CAOD0pekopW9g0SD=BnOMCEp3SdVZPrx5jY_CKLjZV09sWepS6A@mail.gmail.com> <5194F46D.4060905@grandegger.com> <CAOD0pena8JLpCsq6EUqqy_Rip0oRe0Z5=6SQfGV2TNeS_YABfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GBXXKDFFJKXLRAHBNANG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab3EPPiA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 11:38:00 -0400
In-Reply-To: <CAOD0pena8JLpCsq6EUqqy_Rip0oRe0Z5=6SQfGV2TNeS_YABfQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ernast Sevo <ersevs@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GBXXKDFFJKXLRAHBNANG
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/16/2013 05:32 PM, Ernast Sevo wrote:

>> Well, not sure if the hardware realizes any packet lost. This typicall=
y
>> happens when the software does not empty the hardware buffers quickly
>> enough? What hardware are you using? MCP251x?

> Yes I am using MCP2515. I am getting a couple of rx buffer overflow err=
ors
> so I was wondering how these errors corresponded to packet loss,
> whether this is a 1:1 relationship or 1:N relationship (if i am
> interpretting Marc's post
> correctly should I assume 1:1 for best case and 1:N for worst case? ).

Yes, exactly.

> Essentially I am trying to determine at what speed i can have stuff
> coming in before
> I start losing packets for any reason. I know how to account packets
> lost in userspace
>  and packets lost by the driver (which you mentioned above) and now I
> am trying to
> account for packets lost at the hardware level. Knowing how these rx bu=
ffer
> overflow/overrun errors correspond to packet loss would help make my
> data more accurate and reliable.

If you don't get any dropped frames reported via SO_RXQ_OVFL (see
Wolfgang mail) you can be sure they are lost at the hardware level. I
suggest don't use the mcp251x, it's really slow and puts heavy load on
the machine. However there might be some knobs to tune in your SPI
controller/driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GBXXKDFFJKXLRAHBNANG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlGU/VUACgkQjTAFq1RaXHMViwCYjh6N7aQfk3rtqE7ZhpjILsGD
PQCfXj4TCCMg7Z5T51hMcy0B3R8anIA=
=5Aqr
-----END PGP SIGNATURE-----

------enig2GBXXKDFFJKXLRAHBNANG--
