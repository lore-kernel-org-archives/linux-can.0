From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: kvaser leaf and SocketCAN
Date: Thu, 30 Apr 2015 08:48:55 +0200
Message-ID: <5541D057.2020003@pengutronix.de>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de> <20150429104528.GA5712@linux> <loom.20150430T051006-395@post.gmane.org> <loom.20150430T080326-120@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2S2EbwTvOoLL9TRaasGuVCvOS3fUH4QCJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58705 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbD3GtH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Apr 2015 02:49:07 -0400
In-Reply-To: <loom.20150430T080326-120@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2S2EbwTvOoLL9TRaasGuVCvOS3fUH4QCJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/30/2015 08:14 AM, Leo Stan wrote:
>=20
> Actually I spoke too soon...
>=20
> When I try this simple code from the documentation :
>=20
>=20
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> =20
> #include <net/if.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <sys/ioctl.h>
> =20
> #include <linux/can.h>
> #include <linux/can/raw.h>
> =20
> int main(void)
> {
> 	int s;
> 	int nbytes;
> 	struct sockaddr_can addr;
> 	struct can_frame frame;
> 	struct ifreq ifr;
> =20
> 	char *ifname =3D "can0";
> =20
> 	if((s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
> 		perror("Error while opening socket");
> 		return -1;
> 	}
> =20
> 	strcpy(ifr.ifr_name, ifname);
> 	ioctl(s, SIOCGIFINDEX, &ifr);
> =20
> 	addr.can_family  =3D AF_CAN;
> 	addr.can_ifindex =3D ifr.ifr_ifindex;=20
> =20
> 	printf("%s at index %d\n", ifname, ifr.ifr_ifindex);
> =20
> 	if(bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> 		perror("Error in socket bind");
> 		return -2;
> 	}
>=20
> 	// Reading the CAN port
>=20
>=20
> 	nbytes=3Dread(s,&frame,sizeof(struct can_frame));
>=20
> 	if (nbytes < 0) {
>             perror("can raw socket read");
>             return 1;
>         }
>=20
>         /* paranoid check ... */
>         if (nbytes < sizeof(struct can_frame)) {
>             fprintf(stderr, "read: incomplete CAN frame\n");
>             return 1;
>         }
>=20
>         printf("dlc =3D %d, data =3D %s, %d bytes read\n",=20
> frame.can_dlc,frame.data,nbytes);
>=20
>         close(s);
> =09
>         return 0;
> }
>=20
> I get this flag :
>=20
> can0 at index 3
> can raw socket read: Network is down
                       ^^^^^^^^^^^^^^^
You have to configure your CAN network device first, then bring it into
an operational state, this means the network is "up".

    ip link set can0 type can bitrate 500000
    ip link set can0 up

See section "6.5.1 Netlink interface to set/get devices properties"
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L99=
0

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2S2EbwTvOoLL9TRaasGuVCvOS3fUH4QCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQdBXAAoJECte4hHFiupUrt0P/Rg5K1CqKHwoIe8zObrj64D5
TLzpxlKQxpyzD/VCj/Zbt4BdLgqC9JTO3OQ1QNEcF9cS75u2bZttCFtvGnk3RHFi
Fjer2oBnHK5I7E8kcSs47A+AWiVCvPyeBpaXcNpPNalmKoz0Wap2A1qCfDs3Zwoy
pLseap0m6b9YX+Pe++MiBJ/wyXKqQvK6vYuW/0/duyUxwy9mlmyvXZdK2L1fK8wK
Pn4bMrFDnwriw16ouQg7x/hlxobVjWZZawSODXDFSTJqrTJc2yBHTwe5nHFZRTeg
x8FZ+Z5SqJUwhRMlro4dNNoHEEWs3VwM4y3tSdCE+38fDDXtgpyGrWVSl/rECHX4
b4/qxbLDZi1/lm30jLywkApRD/o+4NlBSWRTOlTgLxq/j8WmaOEWUH7I+Cful/7G
CPXRS0F/l1zpefUymfnC/+vwsdRNtxUfkZewGBA60R8QKxBuc8iIv5vh2K5G2jT0
SG5OmG49d+dy8EfpZ+KWiCS6RT92Aw0Wa+qU3JEQiBfemWfNCvEl/c+Z+8qkOJcM
dME+nB/5e9K6swCv3oAInMGU5PmN1lmzHcc6x48tPTiNy3plT9hUX60nFsVjEmdQ
v5NhFdGaljRrIyNOl3gAbGGgHhzfKNvZkTcQvtWTGrcIGcojYYS1a1MAVRTE8mA6
6xBn4fdm9V5bsqynTuqA
=dyGB
-----END PGP SIGNATURE-----

--2S2EbwTvOoLL9TRaasGuVCvOS3fUH4QCJ--
