From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: j1939: j1939tp_txnext(): review switch (session->last_cmd)
Date: Tue, 6 Sep 2016 13:01:29 +0200
Message-ID: <c86ef659-b37f-611e-9515-4c11686ea0f6@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Mxqxg6UOK9jpwIk55J7C0luVBWhtsB7Li"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47044 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932996AbcIFLBl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Sep 2016 07:01:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, kurt.van.dijck@eia.be

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mxqxg6UOK9jpwIk55J7C0luVBWhtsB7Li
Content-Type: multipart/mixed; boundary="GKA58ATdnRh3oQbLpkwBk3uAu2i23fCF8"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>,
 kurt.van.dijck@eia.be
Message-ID: <c86ef659-b37f-611e-9515-4c11686ea0f6@pengutronix.de>
Subject: j1939: j1939tp_txnext(): review switch (session->last_cmd)

--GKA58ATdnRh3oQbLpkwBk3uAu2i23fCF8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm currently reviewing Kurt's et al. j1939 patches and checkpatch
stumbled over this switch():

> /*
>  * transmit function
>  */
> static int j1939tp_txnext(struct session *session)
> {
> 	uint8_t dat[8];
> 	const uint8_t *tpdat;
> 	int ret, offset, pkt_done, pkt_end;
> 	unsigned int pkt, len, pdelay;
>=20
> 	memset(dat, 0xff, sizeof(dat));
> 	get_session(session); /* do not loose it */
>=20
> 	switch (session->last_cmd) {
> 	case 0:
> 		if (!j1939tp_im_transmitter(session->skb))
> 			break;
> 		dat[1] =3D (session->skb->len >> 0) & 0xff;
> 		dat[2] =3D (session->skb->len >> 8) & 0xff;
> 		dat[3] =3D session->pkt.total;
> 		if (session->extd) {
> 			dat[0] =3D etp_cmd_rts;
> 			dat[1] =3D (session->skb->len >>  0) & 0xff;
> 			dat[2] =3D (session->skb->len >>  8) & 0xff;
> 			dat[3] =3D (session->skb->len >> 16) & 0xff;
> 			dat[4] =3D (session->skb->len >> 24) & 0xff;
> 		} else if (j1939cb_is_broadcast(session->cb)) {
> 			dat[0] =3D tp_cmd_bam;
> 			/* fake cts for broadcast */
> 			session->pkt.tx =3D 0;
> 		} else {
> 			dat[0] =3D tp_cmd_rts;
> 			dat[4] =3D dat[3];
> 		}
> 		if (dat[0] =3D=3D session->last_txcmd)
> 			/* done already */
> 			break;
> 		ret =3D j1939tp_tx_ctl(session, 0, dat);
> 		if (ret < 0)
> 			goto failed;
> 		session->last_txcmd =3D dat[0];
> 		/* must lock? */
> 		if (tp_cmd_bam =3D=3D dat[0])
> 			j1939tp_schedule_txtimer(session, 50);
> 		j1939tp_set_rxtimeout(session, 1250);
> 		break;
> 	case tp_cmd_rts:
> 	case etp_cmd_rts:
> 		if (!j1939tp_im_receiver(session->skb))
> 			break;
> tx_cts:
> 		ret =3D 0;
> 		len =3D session->pkt.total - session->pkt.done;
> 		len =3D min(max(len, session->pkt.block), block ?: 255);
>=20
> 		if (session->extd) {
> 			pkt =3D session->pkt.done+1;
> 			dat[0] =3D etp_cmd_cts;
> 			dat[1] =3D len;
> 			dat[2] =3D (pkt >>  0) & 0xff;
> 			dat[3] =3D (pkt >>  8) & 0xff;
> 			dat[4] =3D (pkt >> 16) & 0xff;
> 		} else {
> 			dat[0] =3D tp_cmd_cts;
> 			dat[1] =3D len;
> 			dat[2] =3D session->pkt.done+1;
> 		}
> 		if (dat[0] =3D=3D session->last_txcmd)
> 			/* done already */
> 			break;
> 		ret =3D j1939tp_tx_ctl(session, 1, dat);
> 		if (ret < 0)
> 			goto failed;
> 		if (len)
> 			/* only mark cts done when len is set */
> 			session->last_txcmd =3D dat[0];
> 		j1939tp_set_rxtimeout(session, 1250);
> 		break;
> 	case etp_cmd_cts:
> 		if (j1939tp_im_transmitter(session->skb) && session->extd &&
> 		    (etp_cmd_dpo !=3D session->last_txcmd)) {
> 			/* do dpo */
> 			dat[0] =3D etp_cmd_dpo;
> 			session->pkt.dpo =3D session->pkt.done;
> 			pkt =3D session->pkt.dpo;
> 			dat[1] =3D session->pkt.last - session->pkt.done;
> 			dat[2] =3D (pkt >>  0) & 0xff;
> 			dat[3] =3D (pkt >>  8) & 0xff;
> 			dat[4] =3D (pkt >> 16) & 0xff;
> 			ret =3D j1939tp_tx_ctl(session, 0, dat);
> 			if (ret < 0)
> 				goto failed;
> 			session->last_txcmd =3D dat[0];
> 			j1939tp_set_rxtimeout(session, 1250);
> 			session->pkt.tx =3D session->pkt.done;
> 		}
> 	case tp_cmd_cts:
> 	case 0xff: /* did some data */
> 	case etp_cmd_dpo:
> 		if ((session->extd || !j1939cb_is_broadcast(session->cb)) &&
> 		     j1939tp_im_receiver(session->skb)) {
> 			if (session->pkt.done >=3D session->pkt.total) {
> 				if (session->extd) {
> 					dat[0] =3D etp_cmd_eof;
> 					dat[1] =3D session->skb->len >> 0;
> 					dat[2] =3D session->skb->len >> 8;
> 					dat[3] =3D session->skb->len >> 16;
> 					dat[4] =3D session->skb->len >> 24;
> 				} else {
> 					dat[0] =3D tp_cmd_eof;
> 					dat[1] =3D session->skb->len;
> 					dat[2] =3D session->skb->len >> 8;
> 					dat[3] =3D session->pkt.total;
> 				}
> 				if (dat[0] =3D=3D session->last_txcmd)
> 					/* done already */
> 					break;
> 				ret =3D j1939tp_tx_ctl(session, 1, dat);
> 				if (ret < 0)
> 					goto failed;
> 				session->last_txcmd =3D dat[0];
> 				j1939tp_set_rxtimeout(session, 1250);
> 				/* wait for the EOF packet to come in */
> 				break;
> 			} else if (session->pkt.done >=3D session->pkt.last) {
> 				session->last_txcmd =3D 0;
> 				goto tx_cts;
> 			}
> 		}
> 	case tp_cmd_bam:
> 		if (!j1939tp_im_transmitter(session->skb))
> 			break;
> 		tpdat =3D session->skb->data;
> 		ret =3D 0;
> 		pkt_done =3D 0;
> 		pkt_end =3D (!session->extd && j1939cb_is_broadcast(session->cb))
> 			? session->pkt.total : session->pkt.last;
>=20
> 		while (session->pkt.tx < pkt_end) {
> 			dat[0] =3D session->pkt.tx - session->pkt.dpo+1;
> 			offset =3D session->pkt.tx * 7;
> 			len =3D session->skb->len - offset;
> 			if (len > 7)
> 				len =3D 7;
> 			memcpy(&dat[1], &tpdat[offset], len);
> 			ret =3D j1939tp_tx_dat(session->skb, session->extd,
> 					dat, len+1);
> 			if (ret < 0)
> 				break;
> 			session->last_txcmd =3D 0xff;
> 			++pkt_done;
> 			++session->pkt.tx;
> 			pdelay =3D j1939cb_is_broadcast(session->cb) ?  50 :
> 				packet_delay;
> 			if ((session->pkt.tx < session->pkt.total) && pdelay) {
> 				j1939tp_schedule_txtimer(session, pdelay);
> 				break;
> 			}
> 		}
> 		if (pkt_done)
> 			j1939tp_set_rxtimeout(session, 250);
> 		if (ret)
> 			goto failed;
> 		break;
> 	}
> 	put_session(session);
> 	return 0;
> failed:
> 	put_session(session);
> 	return ret;
> }

The question is, are there missing any break statements? If not, I'm
going to add fall-though comments.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--GKA58ATdnRh3oQbLpkwBk3uAu2i23fCF8--

--Mxqxg6UOK9jpwIk55J7C0luVBWhtsB7Li
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXzqIMAAoJED07qiWsqSVqkrYH/21HdgkKjSsa10WvI4HXa35l
s2qFKupYtxlNsUVb+i2N3gZt3U89vO46L4rDCBg8mp+DCMplmqHvjDc2o2wv7eHJ
xJckyrrYw7/fMgwzJowuxQJIhqGlLPoWmddO9S6v0kYsEgnYBoy52tm3r8pZgwOK
3TOwAFBZCTjy3Ud3HtrCoXB7cf+6XtAodgtqS+VFLFmxF2P9naP/NnBptxe5h3RC
0aMgCmhM8cqX3EAzTFyhfi3NvWCS+S44y/knNEbQROSgjC1MFaX3znT1LmaTzWva
5m+cDQqtSkbN6Dfj1UlQwV3AeaDAYulwLuN1k/t5MRznncznR7Cb08M4wkJRb8U=
=s5Db
-----END PGP SIGNATURE-----

--Mxqxg6UOK9jpwIk55J7C0luVBWhtsB7Li--
