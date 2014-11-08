From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: candump error flags
Date: Sat, 08 Nov 2014 17:46:08 +0100
Message-ID: <545E48D0.3020409@pengutronix.de>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net>	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>	<545E301F.7090708@hartkopp.net> <CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iMdFXPWdSrjce0IhecwvV1okIgxUjxFi0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42596 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaKHQqo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 11:46:44 -0500
In-Reply-To: <CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iMdFXPWdSrjce0IhecwvV1okIgxUjxFi0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2014 04:14 PM, Paul Lever wrote:
>>>> ps. additionally "candump -r 16000 -l can0 &" would be better :-)
>>> I need the timestamps.
>>
>> The logfile format contains a unix timestamp (usec resolution) for eve=
ry CAN
>> frame (and error message).
> Correct if I use the -t option. I was just commenting on the
> suggestion not to use the option. Not sure why it was suggested.
>=20
>=20
>> I'll better wait for the kernel version until answering based on assum=
ptions.
> The kernel is
>  Image Name:   Linux-3.12.9-00111-gcad6b9e

As I said, make sue you use at least v3.15.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iMdFXPWdSrjce0IhecwvV1okIgxUjxFi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXkjQAAoJECte4hHFiupUZOUP/jWY14YkSeoLt0UioWGaCpF4
pR010IpPN8IEvG09ZqCnzPYwbBH6KfDzVVaZnlkwr2UUO/9k5k8WLRLtS/u5RMRw
nFUMDLR1Ikmf2cHOu8nHin+axrQnWQbYbmStWGeKXQMZVTXe+h7fxTG4ykyqZM18
0U3fD/kxHrSFNF7yC/DuF/mZ5plRxti5LD8Lskg3IWS92hO0+p2Bgu+uKb1jbL28
IyjT55B+SQyGiKRT9r4CjwuwTNrKnrwjk+c4NFGASChuMQieadEBlR1tmEupLPjH
Bb4kWMysHcxo1KhX+EDFDPcNlMJB5P3mneRNxVh33iCRpo9oJKX8IwkO3rxdlqgN
e8/GNpvABJi7BTtaRD08Ox23q0mC6SDNANrqGtqVfXQqAzW1CYMwmZShMetPvwWv
7UmnGTFdnMxOhHM5diMWlYrE+g8qzJgpB/JSrJD4dkSYSHFT8IsUlvcJZvAPRH0o
v8A+uRndL1sE1HeHDp7ZAtrw3lhE2LmoCmcgbDBjVLM3Pl7sPELPala4CFLX8Rte
hCWWHvHfx2faMMqPef+qIKcBvSIrFtwgy7S/LXUaeE4+rtddomYmqQ7tDgoBTXQC
0uSxYM1YP7zg0316BZiKxk6O5ktkDnb56j2zWy0MKJ892w54B/500DgjDukrasSK
iPE49K/W5SUbdOM7Hnba
=aLlr
-----END PGP SIGNATURE-----

--iMdFXPWdSrjce0IhecwvV1okIgxUjxFi0--
