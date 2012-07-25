From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: c_can: Add device tree support to Bosch C_CAN/D_CAN
 controller
Date: Wed, 25 Jul 2012 15:47:52 +0200
Message-ID: <500FF908.1000307@pengutronix.de>
References: <1343218729-16954-1-git-send-email-anilkumar@ti.com> <1343218729-16954-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig121886757DB82859EF6F68A0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51924 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933007Ab2GYNsK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 09:48:10 -0400
In-Reply-To: <1343218729-16954-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig121886757DB82859EF6F68A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 02:18 PM, AnilKumar Ch wrote:
> Add device tree support to C_CAN/D_CAN controller and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.

Does not apply to linux-can-next, as Viresh Kumar's patch "net/c_can:
remove conditional compilation of clk code" is not yet included. I
suggest to delay this patch until we have Viresh's patch in net-next.

See comment inline.

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/net/can/c_can.txt          |   37 ++++++++++++=
+
>  drivers/net/can/c_can/c_can.h                      |    5 +-
>  drivers/net/can/c_can/c_can_platform.c             |   57 ++++++++++++=
++------
>  3 files changed, 80 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt=

>=20
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Docu=
mentation/devicetree/bindings/net/can/c_can.txt
> new file mode 100644
> index 0000000..dc4aec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -0,0 +1,37 @@
> +Bosch C_CAN/D_CAN controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "bosch,c_can" for C_CAN controllers and
> +			  "bosch,d_can" for D_CAN controllers.
> +- reg			: physical base address and size of the C_CAN/D_CAN
> +			  registers map
> +- interrupts		: property with a value describing the interrupt
> +			  number
> +- interrupt-parent	: The parent interrupt controller
> +
> +Optional properties:
> +- ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
> +			  instance number
> +
> +Note: "ti,hwmods" field is used to fetch the base address and irq
> +resources from TI, omap hwmod data base during device registration.
> +Future plan is to migrate hwmod data base contents into device tree
> +blob so that, all the required data will be used from device tree dts
> +file.
> +
> +Examples:
> +
> +	d_can@481D0000 {
> +		compatible =3D "bosch,d_can";
> +		reg =3D <0x481D0000 0x1000>;
> +		interrupts =3D <55 0x4>;
> +		interrupt-parent =3D <&intc>;
> +	};
> +
> +(or)
> +
> +	d_can@481D0000 {
> +		compatible =3D "bosch,d_can";
> +		ti,hwmods =3D "d_can1";
> +	};
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_ca=
n.h
> index 01a7049..4e56baa 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -143,8 +143,9 @@ static const u16 reg_map_d_can[] =3D {
>  };
> =20
>  enum c_can_dev_id {
> -	C_CAN_DEVTYPE,
> -	D_CAN_DEVTYPE,
> +	BOSCH_C_CAN_PLATFORM,
> +	BOSCH_C_CAN,
> +	BOSCH_D_CAN,

Note: these symbols are used in "drivers/net/can/c_can/c_can_pci.c", too.=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig121886757DB82859EF6F68A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAP+QsACgkQjTAFq1RaXHOKKwCgi5iTOEjuSrCCBeXfieyNNkAj
wAsAnji6IKAzleB/l6hPG/Tvh8WUoUea
=KmIj
-----END PGP SIGNATURE-----

--------------enig121886757DB82859EF6F68A0--
