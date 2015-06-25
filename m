From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] treewide: use if_nametoindex to avoid overflows
Date: Thu, 25 Jun 2015 09:28:36 +0200
Message-ID: <558BADA4.5000404@pengutronix.de>
References: <1435217092-3022-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8FPJINo5qLuOsbqRI06xXHlQHiRLQG9CK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48610 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbFYH2p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Jun 2015 03:28:45 -0400
In-Reply-To: <1435217092-3022-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sven Schmitt <sven.schmitt@gmx.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8FPJINo5qLuOsbqRI06xXHlQHiRLQG9CK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/25/2015 09:24 AM, Marc Kleine-Budde wrote:
> From: Sven Schmitt <sven.schmitt@gmx.net>
>=20
> replaced strcpy(if_name, argv[x]) + ioctl by if_idx =3D if_nametoindex(=
argv[x])
> to avoid overflows caused by long user input.
>=20
> Signed-off-by: Sven Schmitt <sven.schmitt@gmx.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> I got a S-o-b meanwhile:
>=20
> https://github.com/linux-can/can-utils/pull/4
>=20
> Marc
>=20
>  canfdtest.c    |  5 +----
>  cansend.c      | 11 ++++++-----
>  isotpdump.c    |  8 +-------
>  isotprecv.c    |  5 +----
>  isotpsend.c    |  5 +----
>  isotpserver.c  |  8 +-------
>  isotpsniffer.c |  9 +++++++--
>  isotptun.c     | 10 ++++++++--
>  slcanpty.c     |  9 +--------
>  9 files changed, 27 insertions(+), 43 deletions(-)
>=20
> diff --git a/canfdtest.c b/canfdtest.c
> index 28b204263aaa..24070278109f 100644
> --- a/canfdtest.c
> +++ b/canfdtest.c
> @@ -312,7 +312,6 @@ static int can_echo_gen(void)
> =20
>  int main(int argc, char *argv[])
>  {
> -	struct ifreq ifr;
>  	struct sockaddr_can addr;
>  	char *intf_name;
>  	int family =3D PF_CAN, type =3D SOCK_RAW, proto =3D CAN_RAW;
> @@ -356,9 +355,7 @@ int main(int argc, char *argv[])
>  	}
> =20
>  	addr.can_family =3D family;
> -	strcpy(ifr.ifr_name, intf_name);
> -	ioctl(sockfd, SIOCGIFINDEX, &ifr);
> -	addr.can_ifindex =3D ifr.ifr_ifindex;
> +	addr.can_ifindex =3D if_nametoindex(intf_name);
> =20
>  	if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>  		perror("bind");
> diff --git a/cansend.c b/cansend.c
> index aec64a5c9e61..a0b9bbbfb25d 100644
> --- a/cansend.c
> +++ b/cansend.c
> @@ -94,13 +94,14 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
> =20
> -	addr.can_family =3D AF_CAN;
> -
> -	strcpy(ifr.ifr_name, argv[1]);
> -	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> -		perror("SIOCGIFINDEX");
> +	strncpy(ifr.ifr_name, argv[1], IFNAMSIZ);
> +	ifr.ifr_ifindex =3D if_nametoindex(ifr.ifr_name);

Why do you copy the name to ifr_ifindex and not call if_nametoindex
directly, as you do in the other commands?

> +	if (!ifr.ifr_ifindex) {
> +		perror("if_nametoindex");
>  		return 1;
>  	}
> +
> +	addr.can_family =3D AF_CAN;
>  	addr.can_ifindex =3D ifr.ifr_ifindex;
> =20
>  	if (required_mtu > CAN_MTU) {
> diff --git a/isotpdump.c b/isotpdump.c
> index 6e64eefba5d4..b2b650aa7996 100644
> --- a/isotpdump.c
> +++ b/isotpdump.c
> @@ -96,8 +96,6 @@ int main(int argc, char **argv)
>  	int timestamp =3D 0;
>  	int datidx =3D 0;
>  	unsigned long fflen =3D 0;
> -	struct ifreq ifr;
> -	int ifindex;
>  	struct timeval tv, last_tv;
>  	unsigned int n_pci;
>  	int opt;
> @@ -202,12 +200,8 @@ int main(int argc, char **argv)
> =20
>  	setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter))=
;
> =20
> -	strcpy(ifr.ifr_name, argv[optind]);
> -	ioctl(s, SIOCGIFINDEX, &ifr);
> -	ifindex =3D ifr.ifr_ifindex;
> -
>  	addr.can_family =3D AF_CAN;
> -	addr.can_ifindex =3D ifindex;
> +	addr.can_ifindex =3D if_nametoindex(argv[optind]);
> =20
>  	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>  		perror("bind");
> diff --git a/isotprecv.c b/isotprecv.c
> index 5c4f2a5f11ce..763da39315ef 100644
> --- a/isotprecv.c
> +++ b/isotprecv.c
> @@ -81,7 +81,6 @@ int main(int argc, char **argv)
>  {
>      int s;
>      struct sockaddr_can addr;
> -    struct ifreq ifr;
>      static struct can_isotp_options opts;
>      static struct can_isotp_fc_options fcopts;
>      static struct can_isotp_ll_options llopts;
> @@ -232,9 +231,7 @@ int main(int argc, char **argv)
>  	    setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &force_rx_stmin,=
 sizeof(force_rx_stmin));
> =20
>      addr.can_family =3D AF_CAN;
> -    strcpy(ifr.ifr_name, argv[optind]);
> -    ioctl(s, SIOCGIFINDEX, &ifr);
> -    addr.can_ifindex =3D ifr.ifr_ifindex;
> +    addr.can_ifindex =3D if_nametoindex(argv[optind]);
> =20
>      if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>  	perror("bind");
> diff --git a/isotpsend.c b/isotpsend.c
> index e0256cb9083e..b6a56708fb4d 100644
> --- a/isotpsend.c
> +++ b/isotpsend.c
> @@ -79,7 +79,6 @@ int main(int argc, char **argv)
>  {
>      int s;
>      struct sockaddr_can addr;
> -    struct ifreq ifr;
>      static struct can_isotp_options opts;
>      static struct can_isotp_ll_options llopts;
>      int opt;
> @@ -224,9 +223,7 @@ int main(int argc, char **argv)
>  	    setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &force_tx_stmin,=
 sizeof(force_tx_stmin));
> =20
>      addr.can_family =3D AF_CAN;
> -    strcpy(ifr.ifr_name, argv[optind]);
> -    ioctl(s, SIOCGIFINDEX, &ifr);
> -    addr.can_ifindex =3D ifr.ifr_ifindex;
> +    addr.can_ifindex =3D if_nametoindex(argv[optind]);
> =20
>      if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>  	perror("bind");
> diff --git a/isotpserver.c b/isotpserver.c
> index b900f279b01d..7c0c1eeb5aa2 100644
> --- a/isotpserver.c
> +++ b/isotpserver.c
> @@ -137,7 +137,6 @@ int main(int argc, char **argv)
>  	static struct can_isotp_options opts;
>  	static struct can_isotp_fc_options fcopts;
>  	static struct can_isotp_ll_options llopts;
> -	struct ifreq ifr;
>  	socklen_t sin_size =3D sizeof(clientaddr);
>  	socklen_t caddrlen =3D sizeof(caddr);
> =20
> @@ -345,12 +344,7 @@ int main(int argc, char **argv)
>  	}
> =20
>  	caddr.can_family =3D AF_CAN;
> -	strcpy(ifr.ifr_name, argv[optind]);
> -	if (ioctl(sc, SIOCGIFINDEX, &ifr) < 0) {
> -		perror("SIOCGIFINDEX");
> -		exit(1);
> -	}
> -	caddr.can_ifindex =3D ifr.ifr_ifindex;
> +	caddr.can_ifindex =3D if_nametoindex(argv[optind]);
> =20
>  	if (bind(sc, (struct sockaddr *)&caddr, caddrlen) < 0) {
>  		perror("bind");
> diff --git a/isotpsniffer.c b/isotpsniffer.c
> index 7618dca549a0..9182fcc240b6 100644
> --- a/isotpsniffer.c
> +++ b/isotpsniffer.c
> @@ -271,9 +271,14 @@ int main(int argc, char **argv)
> =20
>  	opts.flags |=3D CAN_ISOTP_LISTEN_MODE;
> =20
> +	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
> +	ifr.ifr_ifindex =3D if_nametoindex(ifr.ifr_name);
> +	if (!ifr.ifr_ifindex) {
> +		perror("if_nametoindex");
> +		return 1;
> +	}
> +

Here too.

>  	addr.can_family =3D AF_CAN;
> -	strcpy(ifr.ifr_name, argv[optind]);
> -	ioctl(s, SIOCGIFINDEX, &ifr);
>  	addr.can_ifindex =3D ifr.ifr_ifindex;
> =20
>  	setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts));
> diff --git a/isotptun.c b/isotptun.c
> index c793f42015fb..400e1b74e8bd 100644
> --- a/isotptun.c
> +++ b/isotptun.c
> @@ -265,9 +265,15 @@ int main(int argc, char **argv)
>  		}
>  	}
> =20
> +	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
> +	ifr.ifr_ifindex =3D if_nametoindex(ifr.ifr_name);

Here too.

> +	if (!ifr.ifr_ifindex) {
> +		perror("if_nametoindex");
> +		close(s);
> +		exit(1);
> +	}
> +
>  	addr.can_family =3D AF_CAN;
> -	strcpy(ifr.ifr_name, argv[optind]);
> -	ioctl(s, SIOCGIFINDEX, &ifr);
>  	addr.can_ifindex =3D ifr.ifr_ifindex;
> =20
>  	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> diff --git a/slcanpty.c b/slcanpty.c
> index f485ac775a53..5cf14ef98374 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -422,7 +422,6 @@ int main(int argc, char **argv)
>  	int s; /* can raw socket */=20
>  	struct sockaddr_can addr;
>  	struct termios topts;
> -	struct ifreq ifr;
>  	int select_stdin =3D 0;
>  	int running =3D 1;
>  	int tstamp =3D 0;
> @@ -497,13 +496,7 @@ int main(int argc, char **argv)
>  	}
> =20
>  	addr.can_family =3D AF_CAN;
> -
> -	strcpy(ifr.ifr_name, argv[2]);
> -	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> -		perror("SIOCGIFINDEX");
> -		return 1;
> -	}
> -	addr.can_ifindex =3D ifr.ifr_ifindex;
> +	addr.can_ifindex =3D if_nametoindex(argv[2]);
> =20
>  	/* disable reception of CAN frames until we are opened by 'O' */
>  	setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8FPJINo5qLuOsbqRI06xXHlQHiRLQG9CK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVi62kAAoJEP5prqPJtc/H7dQH/R08KNTNfqug6n2itHMSZFgz
xTlN3dxbxhnbzij/4G1iHS9H2/I5jfsgNUHr3mM7bnTb77xOR+qJmMSuDDD5z0vb
kvkC6BtKvhtBYdZpxHgeaE7HY5PWWap6LR8nQhzDTOFl48pBUjsBG5JqpDj3xTq2
AUc2+w9LRlrLdOZYDypMbbexSUxW14yZnwcokgBYQ2hV1y8FGNtnihpa9WdqdrTQ
2jDpNEGCbsi4yt9tfIgC/498pERdTPz+sIu11e100sApj0NGAVZGLrpetYs2xovi
i9P1lrjfaNtfQtQfUQvnPosnfCDVxXvnfGvNnQ47xiVCpWjI4Y5UTgMfFW7U1PY=
=naCQ
-----END PGP SIGNATURE-----

--8FPJINo5qLuOsbqRI06xXHlQHiRLQG9CK--
