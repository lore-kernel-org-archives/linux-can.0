From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 26 Jan 2015 16:51:41 +0100
Message-ID: <54C6628D.7010902@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XMQnjDLcXB1md3nCO5VetRPd0eiwdniRo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41032 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbbAZPvt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 10:51:49 -0500
In-Reply-To: <54C66063.9050500@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XMQnjDLcXB1md3nCO5VetRPd0eiwdniRo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2015 04:42 PM, Stephane Grosjean wrote:
> Le 26/01/2015 16:14, Marc Kleine-Budde a =C3=A9crit :
>> On 01/26/2015 04:11 PM, Stephane Grosjean wrote:
>>> Hi Mark,
>>>
>>> Well, the ISO/non-ISO feature is not available for all USB devices an=
d
>>> is currently always under development.
>>> So, we think that it's a bit early to add it in the peak_usb driver.
>> Which mode do the controller support then?
>>
>> Marc
>>
> Current versions of the fw run in non-ISO mode.

So we have to set .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO, analogue to

    6cfda7fbebe8 can: m_can: tag current CAN FD controllers as non-ISO

e.g.:

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
index b2f2694d7d5b..d00bc094b91d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -799,6 +799,7 @@ static int peak_usb_create_dev(struct peak_usb_adapte=
r *peak_usb_adapter,
        dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
        dev->can.do_set_mode =3D peak_usb_set_mode;
        dev->can.do_get_berr_counter =3D peak_usb_adapter->do_get_berr_co=
unter;
+       dev->can.ctrlmode =3D peak_usb_adapter->ctrlmode;
        dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_suppor=
ted;
=20
        netdev->netdev_ops =3D &peak_usb_netdev_ops;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.h
index 7c213b26f3fb..a8a71ebaa0b4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -46,6 +46,7 @@ struct peak_usb_device;
 struct peak_usb_adapter {
        char *name;
        u32 device_id;
+       u32 ctrlmode;
        u32 ctrlmode_supported;
        struct can_clock clock;
        const struct can_bittiming_const bittiming_const;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
index 8aad8f79fc1b..73c4be840dc7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -960,6 +960,7 @@ struct peak_usb_adapter pcan_usb_fd =3D {
        .name =3D "PCAN-USB FD",
        .device_id =3D PCAN_USBFD_PRODUCT_ID,
        .ctrl_count =3D PCAN_USBFD_CHANNEL_COUNT,
+       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
        .ctrlmode_supported =3D CAN_CTRLMODE_FD |
                        CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,=

        .clock =3D {
@@ -1028,6 +1029,7 @@ struct peak_usb_adapter pcan_usb_pro_fd =3D {
        .name =3D "PCAN-USB Pro FD",
        .device_id =3D PCAN_USBPROFD_PRODUCT_ID,
        .ctrl_count =3D PCAN_USBPROFD_CHANNEL_COUNT,
+       .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
        .ctrlmode_supported =3D CAN_CTRLMODE_FD |
                        CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,=

        .clock =3D {

Correct, Olver?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XMQnjDLcXB1md3nCO5VetRPd0eiwdniRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUxmKRAAoJECte4hHFiupUS+UP/1X7vyaoAQxbs0+NJyDNk/mn
5FKcQCSrY0FrB+gy/OFmgh4Un+vLRv63+DrDjPT8BQyUkzNyksPcmZkBwg3AoZl5
TofpfUNhQxqWzHENaA0jQzuNv/VRWDKeVJcbCmojQOkuOCPGg0mghGAG2+Usvg5V
3kP8AyT72DHW0reKrQ9ZwLhRu1wx3RFssCsGkIwfYwJViEQB6vAh7JL999ElkfIO
T4KPFMuClUV7Y9GuCg+bcnGO0BDkF64JFSM7TYe2XkzFz8pKVshwaFUvk+B4feuP
KfAbDJxsTDCSGLqTiOBadzTAMA7THW1dCqBhnFoGedHBfXdVcD5Z94WMN6IhDKQE
5meqgHwaVaRLUqDjiXsSaxc8AGUSI7DBkgEDufIMn6ub282Ii53+PGsrbexUwogB
TopNyRqIerbLtk6tsOdgZ8OeNZEEnHutKwoSUwtPZQS+NyERmcfdTKin+FK23GGr
AaDFB7cAmjrCLT2OGnKp7rAOrDWH6VDJdUSmelGey0Ww1ECmRXIss+B0FoX6OaPY
u0q3DQ05qwKL85MJ4ukC5T7d1G94sDsEpBXzPjNpSEA73xtCHSH2P9qwpg0PDgIG
u6fysd6Afhesm6ketq4f9HrOUHyFCA1/0aLCn3Hph6y/QUGHFD9RkFp+n3DoCL+K
7FrZ+k6SrFf0FDuOzJ8o
=5OKG
-----END PGP SIGNATURE-----

--XMQnjDLcXB1md3nCO5VetRPd0eiwdniRo--
