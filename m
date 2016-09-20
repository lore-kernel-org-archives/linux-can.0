From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 20 Sep 2016 10:01:21 +0200
Message-ID: <eac1fe82-5925-b01f-65b7-c591f05cc472@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20160920092234.7accf5f8@erd980>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DKaA8qMgdAiWc2j6bGjTIpl7HKrPxNIku"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37771 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752070AbcITIBd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2016 04:01:33 -0400
In-Reply-To: <20160920092234.7accf5f8@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DKaA8qMgdAiWc2j6bGjTIpl7HKrPxNIku
Content-Type: multipart/mixed; boundary="BCHHgWl3ffx5dfO4abWmJ9VUnmLHBQ3qO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>
Cc: linux-can <linux-can@vger.kernel.org>,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <eac1fe82-5925-b01f-65b7-c591f05cc472@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20160920092234.7accf5f8@erd980>
In-Reply-To: <20160920092234.7accf5f8@erd980>

--BCHHgWl3ffx5dfO4abWmJ9VUnmLHBQ3qO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2016 09:22 AM, David Jander wrote:
>> Is here someone with insight and can tell if the code is correct this =
way?
> Looks correct to me. I have yet to test it though.

Thanks for your input, the diff to the previous version is this:

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 56bc5bf36090..5d878b5aaf0a 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -979,7 +979,7 @@ static int j1939tp_txnext(struct session *session)
>                 j1939tp_set_rxtimeout(session, 1250);
>                 break;
>         case tp_cmd_rts:
> -       case etp_cmd_rts:
> +       case etp_cmd_rts: /* fallthrough */
>                 if (!j1939tp_im_receiver(session->skb))
>                         break;
>   tx_cts:
> @@ -1028,9 +1028,10 @@ static int j1939tp_txnext(struct session *sessio=
n)
>                         j1939tp_set_rxtimeout(session, 1250);
>                         session->pkt.tx =3D session->pkt.done;
>                 }
> -       case tp_cmd_cts:
> -       case 0xff: /* did some data */
> -       case etp_cmd_dpo:
> +               /* fallthrough */
> +       case tp_cmd_cts: /* fallthrough */
> +       case 0xff: /* did some data */                  /* FIXME: let D=
avid Jander recheck this */
> +       case etp_cmd_dpo: /* fallthrough */
>                 if ((session->extd || !j1939cb_is_broadcast(session->cb=
)) &&
>                     j1939tp_im_receiver(session->skb)) {
>                         if (session->pkt.done >=3D session->pkt.total) =
{
> @@ -1061,6 +1062,7 @@ static int j1939tp_txnext(struct session *session=
)
>                                 goto tx_cts;
>                         }
>                 }
> +               break;
>         case tp_cmd_bam:
>                 if (!j1939tp_im_transmitter(session->skb))
>                         break;

For completeness, the whole function:

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
> 	case etp_cmd_rts: /* fallthrough */
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
> 		/* fallthrough */
> 	case tp_cmd_cts: /* fallthrough */
> 	case 0xff: /* did some data */			/* FIXME: let David Jander recheck th=
is */
> 	case etp_cmd_dpo: /* fallthrough */
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
> 		break;
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

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BCHHgWl3ffx5dfO4abWmJ9VUnmLHBQ3qO--

--DKaA8qMgdAiWc2j6bGjTIpl7HKrPxNIku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX4OzRAAoJED07qiWsqSVqsaIIAK1ygwrJGQ4IdkSprgwuIi1G
sZr2HaMDnB+DsnCmMqcMPHiaYxA/OE8kcP9kXDgwscH4D0zieUeqh8QWjHRFHJIa
plV4siDwVHCyHhVls/CbaEd+Mwdjr4F2gLK3fZcWPRcSjFf1jvBdK8TAoMv5cbes
DYnrl0l2HUeyq4nHTHFnY1jCTGeUm42yE4yBTPVVZ3laqTNzdyUhQ515VZ4/xYy+
00FFIQ/T+94LBZfT9IttmAhr0PPpqKOuT9mXSa1f4HaLaJj+cXeoyBVrkDRoVTIn
eAd9DOoQ2MnkY/LvFjY/AYBQYUI/zrzoFxRLc7WKpr51Q1NySMWH+bo2x0Px5bg=
=04YZ
-----END PGP SIGNATURE-----

--DKaA8qMgdAiWc2j6bGjTIpl7HKrPxNIku--
