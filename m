From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V5 3/3] bfin_can: move/merge the contents of header file
 into driver code
Date: Thu, 05 Feb 2015 12:06:55 +0100
Message-ID: <54D34ECF.1060209@pengutronix.de>
References: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com> <1423133067-17289-3-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VcvHiQIDqqM9oxjossu6LKUx64XeMlWPQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423133067-17289-3-git-send-email-Aaron.wu@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Wu <Aaron.wu@analog.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-devel@analog.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VcvHiQIDqqM9oxjossu6LKUx64XeMlWPQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 11:44 AM, Aaron Wu wrote:
> Rewrite the blackfin CAN driver into more common style in three ways:
> part 1/3: rewrite blackfin style of read/write into common readw/writew=

> part 2/3: introduce ioremap to be compitable with MMU enabled arch
> part 3/3: merge the header file from the blackfin arch dependent
> location to driver code directly, note the original copy of more comple=
ted
> bfin_can.h in arch depentdent location is reserved for reg test purpose=

>=20
> V5 changes: merge contents of header file into drivere code in patch 3/=
3
> V4 changes: remove unused variable in patch 2/3
> V3 changes: remove redundant cast in patch 2/3
> V2 changes: split patch into two parts
> V1 changes: rewrite code into common style
>=20
> Signed-off-by: Aaron Wu <Aaron.wu@analog.com>
> ---
>  drivers/net/can/bfin_can.c |  119 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
> index 0209c14..a676624 100644
> --- a/drivers/net/can/bfin_can.c
> +++ b/drivers/net/can/bfin_can.c
> @@ -20,7 +20,6 @@
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> =20
> -#include <asm/bfin_can.h>
>  #include <asm/portmux.h>
> =20
>  #define DRV_NAME "bfin_can"
> @@ -28,6 +27,124 @@
>  #define TX_ECHO_SKB_MAX  1
> =20
>  /*
> + * transmit and receive channels
> + */
> +#define TRANSMIT_CHL	    24
> +#define RECEIVE_STD_CHL	 0
> +#define RECEIVE_EXT_CHL	 4
> +#define RECEIVE_RTR_CHL	 8
> +#define RECEIVE_EXT_RTR_CHL     12
> +#define MAX_CHL_NUMBER	  32
                         ^^^^^^^^^
Please use a common indention sheme, I suggest to use on space only.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VcvHiQIDqqM9oxjossu6LKUx64XeMlWPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU007SAAoJECte4hHFiupUjvcP/jcOCrR25uO2144syPUrNGQa
gReMDUSuVwMuz3ZD8+9X5byC/DaeLMKA5J680VNUEUJKbwaAlv8dk2420Bhmu1FJ
ux5x1Ms6XOH0H2NKqT/iUOhzEO2dxWAqM9abeXXhNPghdxzA4DVsQNjZ3mgqU0Nk
cRUWJtk6S0sOo8kLLdZI9Y4wr4BgQIQBqBmUEimahXYG29Bha293LD5XuJ6nSvpA
dTeKeyXBfNpojcR3hfyiZ0KKhSL0Q25HNwbCZRUTrQKFImYkikAwdp5my+WhLtuP
qhIoEYFQdgXoUnRGH71AdIh1Ei1UktkCiiP638lTmjKuthSZOHnMd2q4KHpkOuRv
KSCIVe0/3zAre7uXX3U+bHlzBNN5lac3R6XdhwDpuE+KtHkqCluO4ds0T/qSNZgf
RmcT/T+Vr9p/Qny1G3nnCHNbYVmKXt6Dj/ghX+CgcJKbtZi4WLVnWrXm329JVZi3
Bsc3A+oItG3Js1pe241IxYD77fcEE8PRbF/lR3rdm4hGq5s2mOfO1Kacb0ylnPWB
+Pw4mEzsdDPna/wGUo36sNJUr8nubuKzNBvlXVUiEmsBcmKRPK6yEUk+xvhHRQkO
xfhyecaFLjlCpEa+wtzZn4SkebYNCjQKMAGs0iaVGBLfyph2P96racYpDid3fr1o
u34OGVmMWOWLfYveHw7W
=Wkzr
-----END PGP SIGNATURE-----

--VcvHiQIDqqM9oxjossu6LKUx64XeMlWPQ--
