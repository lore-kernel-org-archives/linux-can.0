From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 16:32:33 +0100
Message-ID: <50ACF411.1050201@pengutronix.de>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or
 g> <loom.20121121T162041-774@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB3C609C50041593596D0848F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33302 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab2KUPco (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 10:32:44 -0500
In-Reply-To: <loom.20121121T162041-774@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3C609C50041593596D0848F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 04:25 PM, Michael Pellegrini wrote:
> Michael Pellegrini <mikep86 <at> gmail.com> writes:
>=20
>> This driver is working very well so far.  ifconfig shows that I am sen=
ding and
>> receiving CAN messages successfully.  This is confirmed externally by =
the CAN
>> Monitor system.
>>
>> I will start a more intensive test now and report the results.
>=20
> I shouldn't have spoken so soon.  Running my application on the PCH-Sys=
tem
> caused the original problem within minutes.  Message transmission stopp=
ed
> and and my application started printing the error "No buffer space avai=
lable".
> The only way to recover was to reset the interface.

Can you try this patch (ontop of Wolfgang's)?

Marc

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.=
c
index 5233b8f..2849224 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -543,8 +543,6 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *s=
kb,

        msg_obj_no =3D get_tx_next_msg_obj(priv);

-       /* prepare message object for transmission */
-       c_can_write_msg_object(dev, 0, frame, msg_obj_no);
        can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);

        /*
@@ -556,6 +554,9 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *s=
kb,
                        (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) =3D=3D =
0)
                netif_stop_queue(dev);

+       /* prepare message object for transmission */
+       c_can_write_msg_object(dev, 0, frame, msg_obj_no);
+
        return NETDEV_TX_OK;
 }



--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB3C609C50041593596D0848F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCs9BoACgkQjTAFq1RaXHOnogCeKFzwf9x+YYHVDD1Ecmakksf6
RlsAn3D65w4uIeHTxzMKhqXerv+YKxjK
=GKp2
-----END PGP SIGNATURE-----

--------------enigB3C609C50041593596D0848F--
