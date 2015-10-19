From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Canplayer play to can0 - problem
Date: Mon, 19 Oct 2015 11:41:22 +0200
Message-ID: <5624BAC2.6050002@pengutronix.de>
References: <447a130eb0e223d5336a160a19d91648@haw-landshut.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IFuFc2WjdmKxevicSpV01ONNRxJa0feM6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbbJSJl3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 05:41:29 -0400
In-Reply-To: <447a130eb0e223d5336a160a19d91648@haw-landshut.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s-amarce <s-amarce@haw-landshut.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFuFc2WjdmKxevicSpV01ONNRxJa0feM6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2015 11:14 AM, s-amarce wrote:
> I am currently trying to play a recorded log-file to my installed devic=
e=20
> can0. There are no problems when the  data is streamed to the device=20
> using a cable.
> I managed to stream the log file to a virtual device executing the=20
> command canplayer can0=3D3Dvcan0 < file.log.
> Using this command I can see all the data using candump vcan0 without=20
> any problems.
> However when I try to run: canplayer can0=3D3Dcan0 < file.log, I receiv=
e=20
> the error: "sendto: No buffer space available."
> Is it possible to replay logfiles to real devices like can0 or do I hav=
e=20
> to use virtual devices?
>=20
> My ifconfig after reboot:
>            can0      Link encap:UNSPEC  HWaddr=20
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>            UP RUNNING NOARP  MTU:16  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:10
>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>            Interrupt:68
>=20
> // The error
>           canplayer can0=3D3Dcan0 < data.log
>           sendto: No buffer space available
>=20
> // After
>           ifconfig can0
>            can0      Link encap:UNSPEC  HWaddr=20
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>            UP RUNNING NOARP  MTU:16  Metric:1
>            RX packets:2 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:10
>            RX bytes:16 (16.0 B)  TX bytes:0 (0.0 B)
>            Interrupt:68
>=20
> I hope you can help me with this. I look forward to hearing from you.

You have to add a loop like this:

resend:
                nbytes =3D write(s, &frame, mtu);
                if (nbytes < 0) {
                        if (errno !=3D ENOBUFS) {
                                perror("write");
                                return -1;
                        }
                        /* wait for the write socket (with timeout) */
                        if (poll(&fds, 1, polltimeout) < 0) {
                                 perror("poll");
                                 return -1;
                        } else {
                                goto resend;
                        }
                } else if (nbytes < mtu) {
                        fprintf(stderr, "write: incomplete CAN frame\n");=

                        return 1;
                }

Patches welcome,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IFuFc2WjdmKxevicSpV01ONNRxJa0feM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWJLrDAAoJEP5prqPJtc/HsC4IAJ8Ri0xHYjQPGxxi5LsWAR1w
EF5T+z8cGrANQSixPFqYMPvWgCOZnbUg8HNitea1u8EJqZ4UMuZ+dtjOwQLlwqhL
o/TY345ukXnONeo/SDHzuaTpEu5PefKxBo82RdpVU3n/1wLOhWyewTZ7l8hGVzy6
+2AZlx4ko8FYKmzEN1xTtk2rrqgoisXUXO5UCeg+907noBQqE6UCGlA6vm/eZacB
RrDz9g7orWFbpdqR/wv6INEhlUI/HzFpgFClSAL56Z71cbeaul5waeOEpa/DmJI2
oq9Yg/QuT5v5UzfyB5OgFC2o8GOBQOXxxB++vHDM9Psw2TlsRoS5/izrFqxOacI=
=gO+g
-----END PGP SIGNATURE-----

--IFuFc2WjdmKxevicSpV01ONNRxJa0feM6--
