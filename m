From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: add support for CAL/CANopen firmware
Date: Fri, 1 May 2015 22:21:57 +0200
Message-ID: <5543E065.6060000@pengutronix.de>
References: <5543C69C.5060508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xncDKQJh7NAveRki75tI5EuQGLlw3HUqU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbbEAUWO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 May 2015 16:22:14 -0400
in-reply-to: <5543C69C.5060508@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org
Cc: iws@ovro.caltech.edu

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xncDKQJh7NAveRki75tI5EuQGLlw3HUqU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/01/2015 08:31 PM, Andreas Gr=C3=B6ger wrote:
> in our department we are using some older Janz ICAN3-modules in our
> dekstop pcs. There we have slightly different carrier boards than the
> janz-cmodio supported in the kernel sources, called CAN-PCI2 with two
> submodules. But the pci configuration regions are identical. So
> extending the supported pci devices to the corresponding device ids
> is sufficient to get the drivers working. Great.
>=20
> I have two minor issues:
> * The old ICAN3-modules with firmware 1.28 need more then 250ms for
> the restart after reset. I've increased the timeout to 500ms.

Should be no problem, as it's a timeout.

> * The janz_ican3 module uses the raw can services of the
> Janz-firmware, this means firmware must be ICANOS/2. Our
> ICAN3-modules are equipped with CAL/CANopen-firmware, so I must use
> the appropriate commands for the layer management services.
> My proposal: the driver detects the firmware after module reset and
> selects the commands matching the firmware. This affects the bus
> on/off-command (ican3_set_bus_state) and the configuration of the
> bittiming (ican3_set_bittiming). For better diagnostics the detected

Is it possible to move the set_bittiming for both firmwares into the
ican3_set_bus_state() function? For various reasons I don't like the
fact that the bitrate is written into the hardware while the interface
is down.

> firmware string is presented as sysfs attribute (fwinfo).

Please document the new sysfs entry, see
Documentation/ABI/testing/sysfs-platform-at91 as an example. Please be
so kind and document the already existing termination attribute, too.

> Currently my system works great. Are there any possibilities to get
> my changes into the linux kernel? Here are my changes based on a
> linux-3.19.6 vanilla kernel. Is this the right place for my request,
> is there any maintainer I can ask? I would be grateful for any help.

Ira, can you have a look at the changes and give your Acked-by?

The changes look quite good, some minor nitpicks inline. In the next
patch iteration add add your S-o-b, see [1].

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L407=


> ---
>  drivers/mfd/janz-cmodio.c    |    4 +
>  drivers/net/can/janz-ican3.c |   97 ++++++++++++++++++++++++++++++++++=
+--------
>  2 files changed, 84 insertions(+), 17 deletions(-)
>=20
> diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/=
mfd/janz-cmodio.c linux-3.19.me/drivers/mfd/janz-cmodio.c
> --- linux-3.19.6/drivers/mfd/janz-cmodio.c	2015-04-29 10:30:26.00000000=
0 +0200
> +++ linux-3.19.me/drivers/mfd/janz-cmodio.c	2015-04-30 19:24:44.7291935=
34 +0200
> @@ -267,6 +267,10 @@
>  static const struct pci_device_id cmodio_pci_ids[] =3D {
>  	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x01=
01 },
>  	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x01=
00 },
> +	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x02=
01 },
> +	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x02=
02 },
> +	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x02=
01 },
> +	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x02=
02 },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, cmodio_pci_ids);
> diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/=
net/can/janz-ican3.c linux-3.19.me/drivers/net/can/janz-ican3.c
> --- linux-3.19.6/drivers/net/can/janz-ican3.c	2015-04-29 10:30:26.00000=
0000 +0200
> +++ linux-3.19.me/drivers/net/can/janz-ican3.c	2015-04-30 19:54:20.2231=
46411 +0200
> @@ -83,6 +83,7 @@
>  #define MSG_COFFREQ		0x42
>  #define MSG_CONREQ		0x43
>  #define MSG_CCONFREQ		0x47
> +#define MSG_LMTS		0xb4
> =20
>  /*
>   * Janz ICAN3 CAN Inquiry Message Types
> @@ -215,6 +216,10 @@
>  	struct completion buserror_comp;
>  	struct can_berr_counter bec;
> =20
> +	/* firmware type: 0=3DICANOS, 1=3DCAN/CALopen */
> +	unsigned int fwtype;

please create an enum, make it readable, so that you don't need the
comments anymore :) Something like this:

enum ican3_fwtype {
	ICAN3_FWTYPE_ICANOS,	// or RAW
	ICAN3_FWTYPE_CALOPEN,
};

> +	char fwinfo[0x20];

Nitpick, I'd prefer a plain decimal 32 instead. Where does the length
come from?

> +
>  	/* old and new style host interface */
>  	unsigned int iftype;
> =20
> @@ -270,6 +275,26 @@
>  }
> =20
>  /*
> + * This routine was stolen from drivers/net/can/sja1000/sja1000.c
> + *
> + * The bittiming register command for the ICAN3 just sets the bit timi=
ng
> + * registers on the SJA1000 chip directly
> + */
> +static inline void ican3_calc_bittiming(struct ican3_dev *mod, u8 *btr=
0, u8 *btr1)
> +{
> +	struct can_bittiming *bt =3D &mod->can.bittiming;
> +
> +	if (!btr0 || !btr1)
> +		return;
> +
> +	*btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> +	*btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
> +		(((bt->phase_seg2 - 1) & 0x7) << 4);
> +	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +		*btr1 |=3D 0x80;
> +}
> +
> +/*
>   * ICAN3 "old-style" host interface
>   */
> =20
> @@ -751,12 +776,37 @@
>  static int ican3_set_bus_state(struct ican3_dev *mod, bool on)
>  {
>  	struct ican3_msg msg;
> +	u8 btr0, btr1;
> =20
>  	memset(&msg, 0, sizeof(msg));
> -	msg.spec =3D on ? MSG_CONREQ : MSG_COFFREQ;
> -	msg.len =3D cpu_to_le16(0);
> =20
> -	return ican3_send_msg(mod, &msg);
> +	/* raw CAN firmware */
make use of the enum
> +	if (mod->fwtype =3D=3D 0) {
> +		msg.spec =3D on ? MSG_CONREQ : MSG_COFFREQ;
> +		msg.len =3D cpu_to_le16(0);
> +
> +		return ican3_send_msg(mod, &msg);
> +	}
> +
> +	/* CAL firmware */
> +	if (mod->fwtype =3D=3D 1) {

else if + use enum

> +		msg.spec =3D MSG_LMTS;
> +		if (on) {
> +			ican3_calc_bittiming(mod, &btr0, &btr1);
> +			msg.len =3D cpu_to_le16(4);
> +			msg.data[0] =3D 0;
> +			msg.data[1] =3D 0;
> +			msg.data[2] =3D btr0;
> +			msg.data[3] =3D btr1;
> +		} else {
> +			msg.len =3D cpu_to_le16(2);
> +			msg.data[0] =3D 1;
> +			msg.data[1] =3D 0;
> +		}
> +
> +		return ican3_send_msg(mod, &msg);
> +	}
> +	return -ENOTSUPP;
>  }
> =20
>  static int ican3_set_termination(struct ican3_dev *mod, bool on)
> @@ -1401,7 +1451,7 @@
>  			return 0;
> =20
>  		msleep(10);
> -	} while (time_before(jiffies, start + HZ / 4));
> +	} while (time_before(jiffies, start + HZ / 2));
> =20
>  	netdev_err(mod->ndev, "failed to reset CAN module\n");
>  	return -ETIMEDOUT;
> @@ -1426,6 +1476,15 @@
>  		return ret;
>  	}
> =20
> +	/* detect firmware */
> +	memcpy_fromio(mod->fwinfo, mod->dpm + 0x60, sizeof(mod->fwinfo) - 1);=

> +	if (strncmp(mod->fwinfo, "JANZ-ICAN3", 10)) {
> +		netdev_err(mod->ndev, "ICAN3 not detected (found %s)\n", mod->fwinfo=
);
> +		return -ENODEV;
> +	}
> +	if (strstr(mod->fwinfo, "CAL/CANopen"))
> +		mod->fwtype =3D 1;
> +

Is there a saner way of identifying one or the other card than doing
these string comparisons?

>  	/* re-enable interrupts so we can send messages */
>  	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
> =20
> @@ -1614,24 +1673,17 @@
>  	.brp_inc =3D 1,
>  };
> =20
> -/*
> - * This routine was stolen from drivers/net/can/sja1000/sja1000.c
> - *
> - * The bittiming register command for the ICAN3 just sets the bit timi=
ng
> - * registers on the SJA1000 chip directly
> - */
>  static int ican3_set_bittiming(struct net_device *ndev)
>  {
>  	struct ican3_dev *mod =3D netdev_priv(ndev);
> -	struct can_bittiming *bt =3D &mod->can.bittiming;
>  	struct ican3_msg msg;
>  	u8 btr0, btr1;
> =20
> -	btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> -	btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
> -		(((bt->phase_seg2 - 1) & 0x7) << 4);
> -	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> -		btr1 |=3D 0x80;
> +	/* with CAL firmware bittiming is set in ican3_set_bus_state  */
> +	if (mod->fwtype =3D=3D 1)
> +		return 0;
> +
> +	ican3_calc_bittiming(mod, &btr0, &btr1);
> =20
>  	memset(&msg, 0, sizeof(msg));
>  	msg.spec =3D MSG_CBTRREQ;
> @@ -1731,11 +1783,22 @@
>  	return count;
>  }
> =20
> +static ssize_t ican3_sysfs_show_fwinfo(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct ican3_dev *mod =3D netdev_priv(to_net_dev(dev));
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", mod->fwinfo);
> +}
> +
>  static DEVICE_ATTR(termination, S_IWUSR | S_IRUGO, ican3_sysfs_show_te=
rm,
>  						   ican3_sysfs_set_term);
> +static DEVICE_ATTR(fwinfo, S_IRUSR | S_IRUGO, ican3_sysfs_show_fwinfo,=
 NULL);
> =20
>  static struct attribute *ican3_sysfs_attrs[] =3D {
>  	&dev_attr_termination.attr,
> +	&dev_attr_fwinfo.attr,
>  	NULL,
>  };
> =20
> @@ -1867,7 +1930,7 @@
>  		goto out_free_irq;
>  	}
> =20
> -	dev_info(dev, "module %d: registered CAN device\n", pdata->modno);
> +	netdev_info(mod->ndev, "module %d: registered CAN device\n", pdata->m=
odno);
>  	return 0;
> =20
>  out_free_irq:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xncDKQJh7NAveRki75tI5EuQGLlw3HUqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQ+BlAAoJECte4hHFiupUm0wP/jqGKNeZMWbSrxEtYQe/X7Da
Zt3dPczncd0Uksel1P5sfuVRc19grMU3XH8DTl0lHOFfJfaYaJQftiIFoj0ciNHp
+u7nlYQESkdFbg5wWGWbehBC7gYl9C8rd7gUn77Nq4FlrMgrlHQ34ExZjZ1tY30g
tloRKwYruALfF2TKBoQK/DKkysXaRWBJNuQVArIgh9DZTVxit7ApMdpw08q2m/+P
S7v2Ox11tFz6VdU12Gtafv2r1/lynZDp2RHaKhOg8UrB6T2KhyuVQZtOulNQ8xEb
fOCg/waCnv0qTOhp/tmeOrrFrtPnEgFb8UoESSpoAB3j9k79UdmaxvPiHxaXOmV0
B/dbJDRgzj4Oc1pi/i0vYEw9jLJaJ789MX8QrrbHZACHB3MH/6P7aQ+Zrvv2/0kC
Q5+r2eAfFxq4hr4G3ieUocRa51+TGNSzeB4255Rb3h2TVJVfvCNvp8kjYInNqlm5
BrggQgR/wA+HM7uVaOs3UZRmIU75aLrCIRt3fdGEBHvYBa0+L+fGhTqpc8nwwI17
jLt4gLsic1R0SkQUe0a02HrtHpaSbiVw2K7joG4nZxANDu2WoZwRb7NPSJDscd0v
8qL7OpaFgtx8rgH8I4SDJlK2TKHCOUkPNrY+pgdgjfNJGwGCVi4if3PVkgX6knTD
sAV6grl3mXjslqGSzUew
=kbV7
-----END PGP SIGNATURE-----

--xncDKQJh7NAveRki75tI5EuQGLlw3HUqU--
