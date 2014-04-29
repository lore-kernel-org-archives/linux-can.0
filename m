From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <oe@emtas.de>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Tue, 29 Apr 2014 16:12:51 +0200
Message-ID: <8638796.WNtrS54FvS@laura>
References: <53590FB6.6090707@tataelxsi.co.in> <21197917.OgRarI4yV7@laura> <535FA7BB.3070700@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1695738.XLPzDzzLf8"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63835 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaD2ONn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 10:13:43 -0400
In-Reply-To: <535FA7BB.3070700@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org


--nextPart1695738.XLPzDzzLf8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 29. April 2014, 18:53:07 schrieb Ratheendran:
> this mode, transmission is disabled, all error counters are frozen an=
d=20
> the module operates
> in a CAN Error Passive mode. Only messages *acknowledged by another C=
AN=20
> station* will be received.

In this case always two nodes already communicating are needed in order=
 for=20
the node doing the auto detection.

> If FLEXCAN detects a message that has not been acknowledged, it will
> flag a BIT0 error (without changing the REC), as if it was trying to=20=

> acknowledge the message."

Is this BIT0 somehow exported to user space by SocketCAN to get the=20
information
 "received valid (+ CRC) message but without seeing an ACK" ?

=2D-=20

Mit freundlichen Gr=FC=DFen

    Heinz-J=FCrgen Oertel

=2D----------------------------------------------------------------------=
=2D-

emtas - your embedded solution partner
 
--nextPart1695738.XLPzDzzLf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJTX7NjAAoJENViPQy9fcm73QUH/i/wzfGOvFdJ7j6DiPsEXsA1
G1Pwnqz9F7NoL79cRE3gWbbatqqzSyvqEVLXus73LvTtICE7kgcTqdu/ZgNfZfm9
KkLgjZ1n9L8ptki9U/U646Shh5VMuiLh3qTT5paJc5l2mwg3QGkSyOH2zYMrLUJ7
wx/pLBR8UMU6M9rCEuNhAUoOWcwpJMxCvFb/9bmN4Rvp7b3UZ5AK/lacenWbcJCW
fo0uP/CQYy1xL4uUimEnFLAoG1ECTW0w6UgTPBPE3Lt+OFC9VsLO+4PqeUljUjd4
zB43nzCJSatQlRA9kHkpjykA2nYB5eI69P3vyno1ktAHbE/sz21O2dKXsLjwEBc=
=/DWC
-----END PGP SIGNATURE-----

--nextPart1695738.XLPzDzzLf8--

