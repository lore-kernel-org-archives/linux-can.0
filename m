From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Broadcast manager documentation
Date: Tue, 08 Oct 2013 16:03:42 +0200
Message-ID: <525410BE.5080307@pengutronix.de>
References: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AavMngDXAOiGK9AGOhEJhkdPGRmopt2oI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36981 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab3JHODu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 10:03:50 -0400
In-Reply-To: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brian Thorne <hardbyte@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AavMngDXAOiGK9AGOhEJhkdPGRmopt2oI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2013 02:56 AM, Brian Thorne wrote:
> Hi all,
>=20
> I wanted to use the bcm module and ended up putting together some basic=
 findings
> that might be a useful addition to the can.txt documentation.

YEAY! documentation!

> I haven't tried submitting any patches before so please point out any m=
istakes.

=46rom the howto submit patches point of view, it's preferred to send
matches inline, "git send-email" is your friend.

I cannot say anything to the contents, as I've never used the bcm so
far. However a nitpick inline:

> 0001-net-Update-the-CAN-broadcast-manager-documentation.patch
>=20
>=20
> From 282b4d202b580d57c384dc84aeb7bbb08dff556f Mon Sep 17 00:00:00 2001
> From: Brian Thorne <hardbyte@gmail.com>
> Date: Tue, 8 Oct 2013 12:10:43 +1300
> Subject: [PATCH] net: Update the CAN broadcast manager documentation
>=20
> Add content to empty section in controller area network
> documentation.
>=20
> Signed-off-by: Brian Thorne <hardbyte@gmail.com>
> ---
>  Documentation/networking/can.txt | 132 +++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 132 insertions(+)
>=20
> diff --git a/Documentation/networking/can.txt b/Documentation/networkin=
g/can.txt
> index 820f553..38b1d7e 100644
> --- a/Documentation/networking/can.txt
> +++ b/Documentation/networking/can.txt
> @@ -593,6 +593,138 @@ solution for a couple of reasons:
>        In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be=
 set.
> =20
>    4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
> +
> +  The Broadcast Manager protocol provides an interface to filter and s=
end
> +  cyclic CAN packets in kernel space.
> +
> +  Periodic transmissions can be modified at runtime; both the message =
content
> +  and the interval can be altered. Periodic transmissions can use mult=
iple
> +  intervals, sending N messages at a interval, then continuing to send=
 at
> +  another given interval.
> +
> +  Receive filters can be used to down sample frequent messages; detect=
 events
> +  such as message contents changes, packet length changes, and do time=
-out
> +  monitoring of received messages.
> +
> +  A BCM socket is not used for sending individual can frames, instead =
a new
> +  special message is defined. The basic BCM frame structure used to
> +  communicate with the broadcast manager and the available operations =
are
> +  defined in include/linux/can/bcm.h. The basic BCM frame consists of =
a

It's "include/uapi/linux/can/bcm.h" in recent kernel trees.

> +  message header with an opcode command followed by zero or more can f=
rames.
> +  The broadcast manager sends responses to user space in the same form=
:
> +
> +    struct bcm_msg_head {
> +            __u32 opcode;                   /* command */
> +            __u32 flags;                    /* special flags */
> +            __u32 count;                    /* run 'count' times with =
ival1 */
> +            struct timeval ival1, ival2;    /* count and subsequent in=
terval */
> +            canid_t can_id;                 /* unique can_id for task =
*/
> +            __u32 nframes;                  /* number of can_frames fo=
llowing */
> +            struct can_frame frames[0];
> +    };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AavMngDXAOiGK9AGOhEJhkdPGRmopt2oI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJUEL4ACgkQjTAFq1RaXHMBvgCeLlxx6gDaNj43Un0I8hzsJJKK
5DcAn2zVa3vW2bKXQxJca44G5OoyfY+6
=JiNS
-----END PGP SIGNATURE-----

--AavMngDXAOiGK9AGOhEJhkdPGRmopt2oI--
