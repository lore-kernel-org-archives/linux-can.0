From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Tue, 3 Jan 2017 15:08:29 +0100
Message-ID: <f0815d4c-fe69-458a-73f7-38ae865a57b3@pengutronix.de>
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0BPCJlOakrQ1Vhafbs2h2Vk6Fxqf6V4eG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53111 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752774AbdACOJG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Jan 2017 09:09:06 -0500
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0BPCJlOakrQ1Vhafbs2h2Vk6Fxqf6V4eG
Content-Type: multipart/mixed; boundary="VQtU37fvLErpexUsSLLnltCdpGfOWEquB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <f0815d4c-fe69-458a-73f7-38ae865a57b3@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>

--VQtU37fvLErpexUsSLLnltCdpGfOWEquB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 01:34 PM, Stephane Grosjean wrote:
> This patch adds the support of the PCAN-PCI Express FD boards made
> by PEAK-System, for computers using the PCI Express slot.
>=20
> The PCAN-PCI Express FD has one or two CAN FD channels, depending
> on the model. A galvanic isolation of the CAN ports protects
> the electronics of the card and the respective computer against
> disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operate=
d
> with ambient temperatures in a range of -40 to +85 =C2=B0C.
>=20
> Such boards run an extented version of the CAN-FD IP running into USB
> CAN-FD interfaces from PEAK-System, so this patch adds several new comm=
ands
> and their corresponding data types to the PEAK CAN-FD common definition=
s
> header file too.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

[...]

> +static void *pucan_add_cmd(struct peak_canfd_priv *priv, int cmd_op)
> +{
> +	struct pucan_command *cmd;
> +
> +	if (priv->cmd_len + sizeof(*cmd) > priv->cmd_maxlen)
> +		return NULL;
> +
> +	cmd =3D priv->cmd_buffer + priv->cmd_len;
> +
> +	/* reset all unused bit to default */
> +	*(u64 *)cmd =3D 0;

pease use memset() instead.

> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(priv->index, cmd_op)=
;
> +	priv->cmd_len +=3D sizeof(*cmd);
> +
> +	return cmd;
> +}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VQtU37fvLErpexUsSLLnltCdpGfOWEquB--

--0BPCJlOakrQ1Vhafbs2h2Vk6Fxqf6V4eG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhrsF0ACgkQPTuqJayp
JWpp8Af5AcmZaJjL7c5s3F3iV9xjBjZIeV1CpkTZzdqRsnoKazwT4TJcB7tuniKh
yHVDq1wOFZ1NLGiuB2bJioV0wZNNFYLPCsSjBrjN+dlvS+H1hGaqyt7iUx2yj+RN
LGmaNJUXQa9prXE9VPb/MGdLJSGuTwux3GlKnK9RKS5nHxaAmhW1HoYniUH7vDD1
rniomK7/V6Zi1IFSxZqKWMPuVIldwofGAsfXC14ko534nNe1ZHSynhOWVqdZslMo
eiSlPUhYSgQ5D7sdr5HMjFKoFVhHllir6gPVyNkFdYHqZiFKybspEqm2FIR7Rb+g
6XKKGSCEaByup/EDocjf2Ob3JqDinA==
=Sb6R
-----END PGP SIGNATURE-----

--0BPCJlOakrQ1Vhafbs2h2Vk6Fxqf6V4eG--
