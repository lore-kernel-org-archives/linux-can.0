From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: peak_usb: Do not do dma on the stack
Date: Thu, 16 May 2013 11:41:43 +0200
Message-ID: <5194A9D7.1010003@pengutronix.de>
References: <1368697236-17035-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DMMRDDTCPRHAKRFALJNA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39417 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3EPJlv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 05:41:51 -0400
In-Reply-To: <1368697236-17035-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DMMRDDTCPRHAKRFALJNA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/16/2013 11:40 AM, Marc Kleine-Budde wrote:
> smatch reports the following warnings:
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:514 pcan_usb_pro_drv_loaded=
() error: doing dma on the stack (buffer)
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:878 pcan_usb_pro_init() err=
or: doing dma on the stack (&fi)
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:889 pcan_usb_pro_init() err=
or: doing dma on the stack (&bi)
>=20
> See "Documentation/DMA-API-HOWTO.txt" section "What memory is DMA'able?=
"
>=20
> Cc: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Stephane,
>=20
> can you please test this patch. It applies to current net/master, but a=
ny
> recent kernel should do.
>=20
> regards,
> Marc
>=20
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 61 +++++++++++++++++++--=
--------
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h |  1 +
>  2 files changed, 41 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index 30d79bf..b94bf9f 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -504,15 +504,24 @@ static int pcan_usb_pro_restart_async(struct peak=
_usb_device *dev,
>  	return usb_submit_urb(urb, GFP_ATOMIC);
>  }
> =20
> -static void pcan_usb_pro_drv_loaded(struct peak_usb_device *dev, int l=
oaded)
> +static int pcan_usb_pro_drv_loaded(struct peak_usb_device *dev, int lo=
aded)
>  {
> -	u8 buffer[16];
> +	u8 *buffer;
> +	int err;
> +
> +	buffer =3D kmalloc(PCAN_USBPRO_FCT_DRVLD_REQ_LEN, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> =20
>  	buffer[0] =3D 0;
>  	buffer[1] =3D !!loaded;
> =20
> -	pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_FCT,
> -			      PCAN_USBPRO_FCT_DRVLD, buffer, sizeof(buffer));
> +	err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_FCT,
> +				    PCAN_USBPRO_FCT_DRVLD, buffer,
> +				    PCAN_USBPRO_FCT_DRVLD_REQ_LEN);
> +	kfree(buffer);
> +
> +	return err;
>  }
> =20
>  static inline
> @@ -851,21 +860,24 @@ static int pcan_usb_pro_stop(struct peak_usb_devi=
ce *dev)
>   */
>  static int pcan_usb_pro_init(struct peak_usb_device *dev)
>  {
> -	struct pcan_usb_pro_interface *usb_if;
>  	struct pcan_usb_pro_device *pdev =3D
>  			container_of(dev, struct pcan_usb_pro_device, dev);
> +	struct pcan_usb_pro_interface *usb_if =3D NULL;
> +	struct pcan_usb_pro_fwinfo *fi =3D NULL;
> +	struct pcan_usb_pro_blinfo *bi =3D NULL;
> +	int err;
> =20
>  	/* do this for 1st channel only */
>  	if (!dev->prev_siblings) {
> -		struct pcan_usb_pro_fwinfo fi;
> -		struct pcan_usb_pro_blinfo bi;
> -		int err;
> -
>  		/* allocate netdevices common structure attached to first one */
>  		usb_if =3D kzalloc(sizeof(struct pcan_usb_pro_interface),
>  				 GFP_KERNEL);
> -		if (!usb_if)
> -			return -ENOMEM;
> +		fi =3D kzalloc(sizeof(struct pcan_usb_pro_fwinfo), GFP_KERNEL);
> +		bi =3D kzalloc(sizeof(struct pcan_usb_pro_blinfo), GFP_KERNEL);

I think I can use plain kmalloc for fi and bi.

> +		if (!usb_if || !fi || !bi) {
> +			err =3D -ENOMEM;
> +			goto err_out;
> +		}
> =20
>  		/* number of ts msgs to ignore before taking one into account */
>  		usb_if->cm_ignore_count =3D 5;
> @@ -877,34 +889,34 @@ static int pcan_usb_pro_init(struct peak_usb_devi=
ce *dev)
>  		 */
>  		err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
>  					    PCAN_USBPRO_INFO_FW,
> -					    &fi, sizeof(fi));
> +					    fi, sizeof(*fi));
>  		if (err) {
> -			kfree(usb_if);
>  			dev_err(dev->netdev->dev.parent,
>  				"unable to read %s firmware info (err %d)\n",
>  				pcan_usb_pro.name, err);
> -			return err;
> +			goto err_out;
>  		}
> =20
>  		err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
>  					    PCAN_USBPRO_INFO_BL,
> -					    &bi, sizeof(bi));
> +					    bi, sizeof(*bi));
>  		if (err) {
> -			kfree(usb_if);
>  			dev_err(dev->netdev->dev.parent,
>  				"unable to read %s bootloader info (err %d)\n",
>  				pcan_usb_pro.name, err);
> -			return err;
> +			goto err_out;
>  		}
> =20
> +		/* tell the device the can driver is running */
> +		err =3D pcan_usb_pro_drv_loaded(dev, 1);
> +		if (err)
> +			goto err_out;
> +
>  		dev_info(dev->netdev->dev.parent,
>  		     "PEAK-System %s hwrev %u serial %08X.%08X (%u channels)\n",
>  		     pcan_usb_pro.name,
> -		     bi.hw_rev, bi.serial_num_hi, bi.serial_num_lo,
> +		     bi->hw_rev, bi->serial_num_hi, bi->serial_num_lo,
>  		     pcan_usb_pro.ctrl_count);
> -
> -		/* tell the device the can driver is running */
> -		pcan_usb_pro_drv_loaded(dev, 1);
>  	} else {
>  		usb_if =3D pcan_usb_pro_dev_if(dev->prev_siblings);
>  	}
> @@ -916,6 +928,13 @@ static int pcan_usb_pro_init(struct peak_usb_devic=
e *dev)
>  	pcan_usb_pro_set_led(dev, 0, 1);
> =20
>  	return 0;
> +
> + err_out:
> +	kfree(bi);
> +	kfree(fi);
> +	kfree(usb_if);
> +
> +	return err;
>  }
> =20
>  static void pcan_usb_pro_exit(struct peak_usb_device *dev)
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.h
> index a869918..32275af 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> @@ -29,6 +29,7 @@
> =20
>  /* Vendor Request value for XXX_FCT */
>  #define PCAN_USBPRO_FCT_DRVLD		5 /* tell device driver is loaded */
> +#define PCAN_USBPRO_FCT_DRVLD_REQ_LEN	16
> =20
>  /* PCAN_USBPRO_INFO_BL vendor request record type */
>  struct __packed pcan_usb_pro_blinfo {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DMMRDDTCPRHAKRFALJNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGUqdoACgkQjTAFq1RaXHPsrQCggWDNIPGV4P+ihZPmyG9gWOeb
Ue4AoIceNv+UZo8l0rezXB/gPF47eFJU
=pcOX
-----END PGP SIGNATURE-----

------enig2DMMRDDTCPRHAKRFALJNA--
