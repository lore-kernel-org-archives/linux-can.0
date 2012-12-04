From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 23:11:43 +0100
Message-ID: <50BE751F.10106@pengutronix.de>
References: <50BE7C7E.8080406@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8387D1B04727A5C130DA53C5"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BE7C7E.8080406-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8387D1B04727A5C130DA53C5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12/04/2012 11:43 PM, Bernd Krumboeck wrote:
> Add device driver for USB2CAN interface from "8 devices"
> (http://www.8devices.com).
>=20
> Signed-off-by: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>

Please use git send-email.

A changelog would be nice, in the form of:

changes since v4:
- done this, deleted that

If you post v5, changes since v4 are sufficient.

> ---
>  drivers/net/can/usb/Kconfig    |    6 +
>  drivers/net/can/usb/Makefile   |    1 +
>  drivers/net/can/usb/usb_8dev.c | 1089
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1096 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb_8dev.c
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2162233 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>        This driver supports the PCAN-USB and PCAN-USB Pro adapters
>        from PEAK-System Technik (http://www.peak-system.com).
>=20
> +config CAN_8DEV_USB
> +    tristate "8 devices USB2CAN interface"
> +    ---help---
> +      This driver supports the USB2CAN interface
> +      from 8 devices (http://www.8devices.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
> index 80a2ee4..becef46 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) +=3D ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
>  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> +obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
>=20
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/usb/usb_8dev.c
> b/drivers/net/can/usb/usb_8dev.c
> new file mode 100644
> index 0000000..b3a7eee
> --- /dev/null
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -0,0 +1,1089 @@
> +/*
> + * CAN driver for "8 devices" USB2CAN converter
> + *
> + * Copyright (C) 2012 Bernd Krumboeck (krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org)
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, write to the Free Software Foundation, I=
nc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

you can remove the address here.

> + *
> + * This driver is inspired by the 3.2.0 version of
> drivers/net/can/usb/ems_usb.c
> + * and drivers/net/can/usb/esd_usb2.c
> + *
> + * Many thanks to Gerhard Bertelsmann (info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org)
> + * for testing and fixing this driver. Also many thanks to "8 devices"=
,
> + * who were very cooperative and answered my questions.
> + */

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8387D1B04727A5C130DA53C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC+dR8ACgkQjTAFq1RaXHP+hwCeO8NOpGOtd1kDNAcr7t9zjtm+
ojIAn0fV/JZA16DaKJIB1Lhn9qsexSFv
=BmiJ
-----END PGP SIGNATURE-----

--------------enig8387D1B04727A5C130DA53C5--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
