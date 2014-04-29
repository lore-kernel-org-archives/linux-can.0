From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <oe@emtas.de>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Tue, 29 Apr 2014 14:47:19 +0200
Message-ID: <21197917.OgRarI4yV7@laura>
References: <53590FB6.6090707@tataelxsi.co.in> <20140427094418.GB28319@griso.site> <20140427180135.GB21176@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22565244.VSuzhFX62g"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60659 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbaD2MsK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 08:48:10 -0400
In-Reply-To: <20140427180135.GB21176@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>, John Whitmore <arigead@gmail.com>, linux-can@vger.kernel.org


--nextPart22565244.VSuzhFX62g
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Sonntag, 27. April 2014, 20:01:35 schrieb Kurt Van Dijck:
>=20
> Autobaud is, IMO, a userspace thing.
> The principle has been explained, and with iproute2 & candump piping =
into
> grep or wc, you could even make a shell script for that.


In can4linux it can be done in user space, like

int do_autobaud(can_fd)
{
int bitrate[] =3D {10, 20,  50, 125, 250, 500, 800, 1000 , 0};
int i;
int ret;
can_statuspar_t status;

=09printf("\tswitch into listen only mode\n");=20
=09set_lomode(can_fd, 1);
=09/* for all possible bit rates */
=09for (i =3D 0; ; i++) {
=09=09if (bitrate[i] =3D=3D 0) {
=09=09=09ret =3D 0;
=09=09=09break;
=09=09}
=09=09printf("\tTry %d Kbit/s\n", bitrate[i]);
=09=09set_bitrate(can_fd, bitrate[i]);
=09=09/* wait one second */
=09=09sleep(1);
=09=09ioctl(can_fd, CAN_IOCTL_STATUS, &status);
=09=09/* printf("Rx buffer: %d\n", status.rx_buffer_used); */
=09=09if (status.rx_buffer_used > 1) {
=09=09=09printf("\t\tCould receive frames. Switch back to=20
active mode\n");
=09=09=09ret =3D bitrate[i];
=09=09=09break;
=09=09}
=09}
=09if (ret > 0) {
=09=09/* bit rate detected */
=09=09set_lomode(can_fd, 0);
=09}
=09return ret;
}


Of course the CAN controller should have a 'listen only' mode.

On a running EnergyBus it looks like:

using CAN device /dev/can1
doing auto bit rate detection now
take care that traffic is on the bus
        switch into listen only mode
        Try 10 Kbit/s
        Try 20 Kbit/s
        Try 50 Kbit/s
        Try 125 Kbit/s
        Try 250 Kbit/s
                Could receive frames. Switch back to active mode




=2D-=20

Mit freundlichen Gr=FC=DFen

    Heinz-J=FCrgen Oertel

=2D----------------------------------------------------------------------=
=2D-

emtas - your embedded solution partner
=20

--nextPart22565244.VSuzhFX62g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJTX59XAAoJENViPQy9fcm71fsIAPKTkclh53kb+rnKJha22J8m
HBKGnZ6bFUFAxOGRkeDgaq3hmqRssLbqElLLR+R4z7gMlQy3V6WFBg+1HfGR6eYX
AaO4FbAesimJAGeSBeRyhPm3ifRsR6iOoZfCo0/rs/MEHBEdEu4yx6CH8srsq/Rk
I1XTrHgC+2PLUz/J223flsAcSr94oNdVHUI/FniKUpcOMcciSNxOCBUB1wKHTznL
i0bWznLRFxpWUzD+JUpYTpdOXeLn0FTtLb1fRT1ghb/unDjjgV7nYm5jux4AaiAF
pJloOp8BnAWUC/66oFMHPxnTz4UeAYIBdrwHSa8SfGy/Ys/t48Hqnh556hMHbfs=
=81uF
-----END PGP SIGNATURE-----

--nextPart22565244.VSuzhFX62g--

