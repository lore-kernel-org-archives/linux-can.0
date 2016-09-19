From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: j1939
Date: Mon, 19 Sep 2016 18:54:43 +0200
Message-ID: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RPArjnwHGnNkW0CWL6lF1ErRfruWEgJPn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55771 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750898AbcISQyz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 12:54:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RPArjnwHGnNkW0CWL6lF1ErRfruWEgJPn
Content-Type: multipart/mixed; boundary="fKJTAV7JP9CD5P9d04aNtFRI7KV8CRtd9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Subject: j1939

--fKJTAV7JP9CD5P9d04aNtFRI7KV8CRtd9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I've ported Kurt's latest j1939 patches to linux-4.7. I've squashed all
patches into one. Then a patch to undo unused modifications and a bunch
of patches to make checkpatch happy.

I've pushed the result to

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?=
h=3Dj1939

The remaining warning is about a case statement without fall through
annotations and/or breaks:

> WARNING: Possible switch case/default not preceeded by break or fallthr=
ough comment
> #4017: FILE: net/can/j1939/transport.c:1031:
> +	case tp_cmd_cts:
>=20
> WARNING: Possible switch case/default not preceeded by break or fallthr=
ough comment
> #4018: FILE: net/can/j1939/transport.c:1032:
> +	case 0xff: /* did some data */
>=20
> WARNING: Possible switch case/default not preceeded by break or fallthr=
ough comment
> #4019: FILE: net/can/j1939/transport.c:1033:
> +	case etp_cmd_dpo:

The code in question is:

> /* transmit function */
> static int j1939tp_txnext(struct session *session)
> {
> 	u8 dat[8];
> 	const u8 *tpdat;
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
> 			dat[1] =3D (session->skb->len >> 0) & 0xff;
> 			dat[2] =3D (session->skb->len >> 8) & 0xff;
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
>  tx_cts:
> 		ret =3D 0;
> 		len =3D session->pkt.total - session->pkt.done;
> 		len =3D min(max(len, session->pkt.block), block ?: 255);
>=20
> 		if (session->extd) {
> 			pkt =3D session->pkt.done + 1;
> 			dat[0] =3D etp_cmd_cts;
> 			dat[1] =3D len;
> 			dat[2] =3D (pkt >>  0) & 0xff;
> 			dat[3] =3D (pkt >>  8) & 0xff;
> 			dat[4] =3D (pkt >> 16) & 0xff;
> 		} else {
> 			dat[0] =3D tp_cmd_cts;
> 			dat[1] =3D len;
> 			dat[2] =3D session->pkt.done + 1;
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
> 		    j1939tp_im_receiver(session->skb)) {
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
> 			dat[0] =3D session->pkt.tx - session->pkt.dpo + 1;
> 			offset =3D session->pkt.tx * 7;
> 			len =3D session->skb->len - offset;
> 			if (len > 7)
> 				len =3D 7;
> 			memcpy(&dat[1], &tpdat[offset], len);
> 			ret =3D j1939tp_tx_dat(session->skb, session->extd,
> 					     dat, len + 1);
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
>  failed:
> 	put_session(session);
> 	return ret;
> }

Is here someone with insight and can tell if the code is correct this way=
?

Another thing that IMHO has to be sorted out is the use of module
parameters:

> ./main.c:49:MODULE_PARM_DESC(padding, "Pad all packets to 8 bytes, and =
stuff with 0xff");
> ./transport.c:60:MODULE_PARM_DESC(transport_burst_count, "Number of pac=
kets to send in burst between flow control (1..255, default 255)");
> ./transport.c:61:MODULE_PARM_DESC(transport_max_size, "Maximum packet s=
ize (default 100k)");
> ./transport.c:62:MODULE_PARM_DESC(transport_retry_time, "Packet retrans=
mission timeout in msecs, used in case of buffer full. (default 20)");
> ./transport.c:63:MODULE_PARM_DESC(transport_packet_delay, "Delay betwee=
n packets to avoid buffer overruns (default 0)");

Better convert them to netlink options.

Next think I'll do is to establish some communication with an external
j1939 component. I'll keep you updated.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fKJTAV7JP9CD5P9d04aNtFRI7KV8CRtd9--

--RPArjnwHGnNkW0CWL6lF1ErRfruWEgJPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX4BhTAAoJED07qiWsqSVq+MEH/RVUVdmZXdbUEtElKjE7465t
c8Ma/QbiM0GCiI9vRjx9Xu9XSKCAZpDRqdcz+9ed2boQln62eciSkmfAvngc+I8B
4vbxnBSZPHIsqdXRdtyO8ITesANzHaLwZ8nCdxLuWPv0cQkNdxV7Kiu+hIoK8PqS
ZOqogYiGWLIe/YjnInlYNCKQs9rB2clVNf7DzeaOmqwK3PJ6EBTO9eEnCljAcbWI
V8cN5eBJFmIDr8QL+I8GACwbWYeMu45F9m3DJobMQ+om9kC4P1+yctFsHPg/4rtH
k6h6FbY5XYsbQhQkeHTVNulcU+yPqmq/eeVPbOd8OLbMtqJQNYh3IDhuNBsvry8=
=TFRD
-----END PGP SIGNATURE-----

--RPArjnwHGnNkW0CWL6lF1ErRfruWEgJPn--
