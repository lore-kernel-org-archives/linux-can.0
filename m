From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: cansend app will block while it is sending RTR frames
Date: Wed, 28 Aug 2013 14:31:21 +0200
Message-ID: <521DED99.6010606@pengutronix.de>
References: <loom.20130828T111851-325@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="km17URsdTE8LxXCdr9JMsLUeq88bPcxlJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab3H1Mb3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2013 08:31:29 -0400
In-Reply-To: <loom.20130828T111851-325@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: xuewentian <xuewt@embedinfo.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--km17URsdTE8LxXCdr9JMsLUeq88bPcxlJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2013 11:34 AM, xuewentian wrote:
> Hi all,
>=20
>   I want to test sending a lot of RTR frames, because select/poll is no=
=20
> effect on the flow control, I add the usleep in the cansend app.
>  =20
>   The code segment is :
>  =20
>=20
> 	while (infinite || loopcount--) {
> 	=09
> 		ret =3D write(s, &frame, sizeof(frame));
> 		if (ret =3D=3D -1) {
> 			perror("write");
> 			printf("Please specify a more long delay time!\n");
> 			break;
> 		}
> 		usleep(delay);//flow control
> 	}
>=20
>   Here the "delay" is about 200us, and I used "cansend can0 -r -e -l 50=
0 -
> i 0x1234567  0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88" command to send 5=
00=20
> RTR frames.but candump on
> the another board could only received the 336 frames,and candump app=20
> hasn't print the received RTR frames,and only count the received frmaes=
=2E
>   and I debugged the send process in the kernel, and I found that it sl=
eep=20
> on the copy_from_user in the memcpy_fromiovec of the raw_sendmsg
>  =20
>   err =3D memcpy_fromiovec(skb_put(skb, size), msg->msg_iov, size);  //=
 in=20
> the raw_sendmsg function of the net/can/raw.c file.
> 	if (err < 0)
> 		goto free_skb;

How have you measured that the kernel sleeps in that function? How long
does it sleep?

>   What about happens with the write of the cansend app? and I used the =

> same way to send the 5000000 data frames, it didn't blocked.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--km17URsdTE8LxXCdr9JMsLUeq88bPcxlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlId7ZkACgkQjTAFq1RaXHNeRQCfRUcpBM9ml+KMKc7z89XtSQn9
lOQAoJdBefvMJYrA6wZDBpAEWtiJbBg9
=H7iY
-----END PGP SIGNATURE-----

--km17URsdTE8LxXCdr9JMsLUeq88bPcxlJ--
