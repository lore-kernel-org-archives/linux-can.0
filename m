From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan driver: tx_bytes counter never incremented when CAN_RAW_LOOPBACK
 removed?
Date: Mon, 29 Apr 2013 14:44:55 +0200
Message-ID: <517E6B47.4070708@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com> <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de> <517E4E01.3080705@peak-system.com> <517E5120.70600@pengutronix.de> <517E69A0.8050701@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UGLPXPFBRGJVKMMXKTDQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48280 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3D2MpD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 08:45:03 -0400
In-Reply-To: <517E69A0.8050701@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UGLPXPFBRGJVKMMXKTDQ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/29/2013 02:37 PM, Stephane Grosjean wrote:
>>> Playing with the flexcan driver, I've seen that the tx_bytes counter
>>> always equals 0 while tx_packets increases.
>>> I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so I=

>>> suppose that:
>>>
>>> stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>>
>>> doesn't do what it should.
>>> Am I wrong?
>> Let me see. Yes you're right. can_put_echo_skb() only queues the CAN
>> frame if CAN_RAW_LOOPBACK is set.
>>
>> We either can change that can_put_echo_skb() always queues the CAN fra=
me
>> or that can_get_echo_skb() returns the correct number of bytes even if=

>> the CAN frame is not queued or put the mechanism in each driver.
>>
>> Marc
>>
>=20
> Why not handling tx_bytes and tx_packets in "flexcan_start_xmit()"
> instead? Easier and faster change, wouldn't be it?

Yes, but it's not as correct. As technically the frame is send after the
tx_complete interrupt.

> I also have seen that the flexcan ctrlr (iMx25) behaves oddly when rx
> overrun occurs: each time I get such an OVR INT., I also get some
> spurious TX INT. too, while I never sent anything on the CAN. So, for
> me, handling tx_bytes/tx_packets stats when sending the data would fix
> everything!

If you get a spurious TX INT when during RX overruns, I don't think
changing the stats solves the TX INT problem. You only cure the effect
on the stats. What does else does a spurious TX INT do?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UGLPXPFBRGJVKMMXKTDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF+a0sACgkQjTAFq1RaXHPEngCfVNY1dxC/Z3D8JqogEV1sHnBH
IRsAn2d0uvhtNd+foL6Jnjj5D48RRTfE
=3+fr
-----END PGP SIGNATURE-----

------enig2UGLPXPFBRGJVKMMXKTDQ--
