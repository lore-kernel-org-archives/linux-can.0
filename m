From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: GS_USB
Date: Mon, 09 Dec 2013 11:52:21 +0100
Message-ID: <52A5A0E5.4020605@pengutronix.de>
References: <1380889887.22484.2.camel@blackbox>	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>	 <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>	 <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>	 <1384135835.3749.31.camel@blackbox>	 <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>	 <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>	 <528150F3.8090406@hartkopp.net> <1384511999.3561.8.camel@blackbox> <1385222752.3602.6.camel@blackbox> <52A2F30B.6010905@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="o4FeKGrTx2maUchgCvbX6xAOKmEeNNeum"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35287 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761147Ab3LIKwa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 05:52:30 -0500
In-Reply-To: <52A2F30B.6010905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o4FeKGrTx2maUchgCvbX6xAOKmEeNNeum
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Wolfgang,

thanks for reviewing the driver.

On 12/07/2013 11:06 AM, Wolfgang Grandegger wrote:
>> +static struct gs_can *gs_make_candev(unsigned int channel,
>> > +	struct usb_interface *intf)

This function returns a struct gs_can pointer...

>> > +{
>> > +	struct gs_can *dev;
>> > +	struct net_device *netdev;
>> > +	int rc;
>> > +	struct gs_device_bt_const *bt_const;
>> > +
>> > +	bt_const =3D kmalloc(sizeof(*bt_const), GFP_KERNEL);
>> > +	if (!bt_const)
>> > +		return ERR_PTR(-ENOMEM);
> This function does not return an error code, therefore just:
>=20
> 		return -ENOMEM;

=2E...so ERR_PTR(-ENOMEM) is correct. The error value "-ENOMEM" has to be=

converted to a pointer and this is what ERR_PTR does. The same is true
for the rest of this function.

>=20
>> > +
>> > +	/* fetch bit timing constants */
>> > +	rc =3D usb_control_msg(interface_to_usbdev(intf),
>> > +			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
>> > +			GS_USB_BREQ_BT_CONST,
>> > +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
>> > +			channel,
>> > +			0,
>> > +			bt_const,
>> > +			sizeof(*bt_const),
>> > +			1000);
>> > +
>> > +	if (rc < 0) {
>> > +		dev_err(&intf->dev,
>> > +			"Couldn't get bit timing const for channel (err=3D%d)\n",
>> > +			rc);
>> > +		kfree(bt_const);
>> > +		return ERR_PTR(rc);
> 		return rc; !
>=20
> Puh, at a closer look there are quite some issues with returning a
> proper return code.
>=20
>> > +	}
>> > +
>> > +	/* create netdev */
>> > +	netdev =3D alloc_candev(sizeof(struct gs_can), GS_MAX_TX_URBS);
>> > +	if (!netdev) {
>> > +		dev_err(&intf->dev, "Couldn't alloc candev\n");
>> > +		kfree(bt_const);
>> > +		return ERR_PTR(-ENOMEM);
> This function does not return an error code, therefore just:
>=20
> 		return -ENOMEM;
>=20
>> > +	}
>> > +
>> > +	dev =3D netdev_priv(netdev);
>> > +
>> > +	netdev->netdev_ops =3D &gs_usb_netdev_ops;
>> > +
>> > +	netdev->flags |=3D IFF_ECHO; /* we support full roundtrip echo */
>> > +
>> > +	/* dev settup */
>> > +	strcpy(dev->bt_const.name, "gs_usb");
>> > +	dev->bt_const.tseg1_min =3D bt_const->tseg1_min;
>> > +	dev->bt_const.tseg1_max =3D bt_const->tseg1_max;
>> > +	dev->bt_const.tseg2_min =3D bt_const->tseg2_min;
>> > +	dev->bt_const.tseg2_max =3D bt_const->tseg2_max;
>> > +	dev->bt_const.sjw_max =3D bt_const->sjw_max;
>> > +	dev->bt_const.brp_min =3D bt_const->brp_min;
>> > +	dev->bt_const.brp_max =3D bt_const->brp_max;
>> > +	dev->bt_const.brp_inc =3D bt_const->brp_inc;
>> > +
>> > +	dev->udev =3D interface_to_usbdev(intf);
>> > +	dev->iface =3D intf;
>> > +	dev->netdev =3D netdev;
>> > +	dev->channel =3D channel;
>> > +
>> > +	init_usb_anchor(&dev->tx_submitted);
>> > +	atomic_set(&dev->active_tx_urbs, 0);
>> > +	spin_lock_init(&dev->tx_ctx_lock);
>> > +	for (rc =3D 0; rc < GS_MAX_TX_URBS; rc++) {
>> > +		dev->tx_context[rc].dev =3D dev;
>> > +		dev->tx_context[rc].echo_id =3D GS_MAX_TX_URBS;
>> > +	}
>> > +
>> > +	/* can settup */
>> > +	dev->can.state =3D CAN_STATE_STOPPED;
>> > +	dev->can.clock.freq =3D bt_const->fclk_can;
>> > +	dev->can.bittiming_const =3D &dev->bt_const;
>> > +	dev->can.do_set_bittiming =3D gs_usb_set_bittiming;
>> > +
>> > +	dev->can.ctrlmode_supported =3D 0;
>> > +
>> > +	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
>> > +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LISTENONLY;
>> > +
>> > +	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
>> > +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LOOPBACK;
>> > +
>> > +	if (bt_const->feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
>> > +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
>> > +
>> > +	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
>> > +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_ONE_SHOT;
>> > +
>> > +	kfree(bt_const);
>> > +
>> > +	SET_NETDEV_DEV(netdev, &intf->dev);
>> > +
>> > +	rc =3D register_candev(dev->netdev);
>> > +	if (rc) {
>> > +		free_candev(dev->netdev);
>> > +		dev_err(&intf->dev, "Couldn't register candev\n");
>> > +		return ERR_PTR(rc);
> 		return rc; !!!
>=20
>> > +	}
>> > +
>> > +	return dev;
>> > +}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--o4FeKGrTx2maUchgCvbX6xAOKmEeNNeum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKloOUACgkQjTAFq1RaXHMw0gCgici7rvVx3Op3CfoJxlS+iel4
YzMAmwZmiXZlsPgK+v8wfZdoHuHuVTve
=aVhy
-----END PGP SIGNATURE-----

--o4FeKGrTx2maUchgCvbX6xAOKmEeNNeum--
