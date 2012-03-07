From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 7 Mar 2012 16:17:42 +0300
Message-ID: <20120307131741.GD674@mwanda>
References: <20120306112108.GA4362@elgon.mountain>
 <20120307122112.GC674@mwanda>
 <4F57549F.3050309@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:41606 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757745Ab2CGNPp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 08:15:45 -0500
Content-Disposition: inline
In-Reply-To: <4F57549F.3050309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: s.grosjean@peak-system.com, linux-can@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 01:29:19PM +0100, Marc Kleine-Budde wrote:
> On 03/07/2012 01:21 PM, Dan Carpenter wrote:
> > On Tue, Mar 06, 2012 at 02:21:08PM +0300, Dan Carpenter wrote:
> >> Hello Stephane Grosjean,
> >>
> >> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB=20
> >> specific part" from Mar 2, 2012, leads to the following warning:
> >>
> >> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
> >> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
> >>
> >> drivers/net/can/usb/peak_usb/pcan_usb.c
> >>    742          /* can id */
> >>    743          if (cf->can_id & CAN_EFF_FLAG) {
> >>    744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id & CAN_=
ERR_MASK);
> >>    745 =20
> >>    746                  tmp32 <<=3D 3;
> >=20
> > Also we can't be doing this shift on little endian data.
>=20
> This should be first shift, then convert to little endian, isn't it?
>=20

That's my guess too.
		__le32 tmp32 =3D cpu_to_le32((cf->can_id & CAN_ERR_MASK) << 3);

Btw, it's slightly odd to me that CAN_EFF_MASK and CAN_ERR_MASK are
the same.  I wouldn't comment on it except that I was wondering if
it might be a copy and paste bug.

#define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
#define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */

regards,
dan carpenter


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV1/1AAoJEOnZkXI/YHqRvD8QAIrsUhUmQMg4V+mnYe4c5gbX
x2oU0luffytDMaqrCCsAMoMGIYNIfVns5Uwis4wwoArKikLy8oGwu220SX3/Llhg
qpN9uuxUvbnxIiRkSl0ko5DheRXJBy0+h0qT9gd5J+NOscCUV3Vri3ppqG4yS0Vx
NzWPCbcF0pRm0YrtfS6gXS6ZtlGhlDTxtRTERHXgs23x94cpmqoFqfn0/lBCa9u1
Qe0LzrVJTmyh9IV2c4DsiTZd5FkKAZWdMFkS6x6FzEjffhM9ftAY2BmOCBgSdz/4
Aq9DniwpF4A9azMoRKxjz9ml3OAoglnzd375gKfBnjQ4jFG6vpOiMJSIdGUDCkQO
XVgDc7Fs9hlRhlva594Qc/BGI4NTlVJV91fENw2qjX7qdh5Q7E7snBv+g7x5vOWM
LfhqY7MO/nOQ9HG5LOk8L/5WbJuOYZhF6R6TNyc4W5DFJnVFFl3xefgV0s0x3alb
FVr1DcjhHxle2HlYdIdb6aJAr7tlgkAkWK/UzZWd0bQKxGTA5z7WSXKodyfoM4u1
IM8VRBB4JiNTXQ9+xtuclkZ4ew0KpJEupauvHaMXlC9fLdq76vPqTvhimVY0vfN2
IcZdzXdFzkNDjgkeIocaEYu5yOigVhZsh73dO0/CeNAkI0GLP7yLlQOV9/tjx7LT
R2hja/HMEe5lzERo38pK
=NwQx
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
