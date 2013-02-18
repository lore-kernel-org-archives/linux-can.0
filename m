From: =?iso-8859-1?Q?H=E5kan_Engblom?= <H.Engblom@tele-radio.com>
Subject: SV: SV: Fwd: can-utils at
 http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Mon, 18 Feb 2013 10:21:41 +0100
Message-ID: <7073D121A5DFE9448648C0E083BEA9C96C7AA6333E@vsrv6.tele-radio.ad>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad>
 <511E1170.6040409@pengutronix.de> <511E5EA3.70804@hartkopp.net>
 <7073D121A5DFE9448648C0E083BEA9C96C7AA632B2@vsrv6.tele-radio.ad>
 <511E6E4E.4040502@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.vingael.se ([195.10.211.16]:19217 "EHLO mail.smtp.se"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab3BRJV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Feb 2013 04:21:56 -0500
In-Reply-To: <511E6E4E.4040502@hartkopp.net>
Content-Language: sv-SE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

Seems good from my point of view. Also, see blow.

Br H=E5kan Engblom

> -----Ursprungligt meddelande-----
> Fr=E5n: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
> Skickat: den 15 februari 2013 18:20
> Till: H=E5kan Engblom
> Kopia: Marc Kleine-Budde; linux-can@vger.kernel.org
> =C4mne: Re: SV: Fwd: can-utils at http://gitorious.org/+linux-can-
> developers/linux-can/can-utils
>=20
> On 15.02.2013 17:49, H=E5kan Engblom wrote:
>=20
> > Yes, the RTR is not recommended, you're right.
> >
> > In any case it would be nice to have it there as I have a slave tha=
t discards
> remote frames unless the DLC is the same as in the requested data.
> >
> > To take away the error-check would be fine for me. Is something lik=
e this
> what you mean, just making sure I did not missunderstand you:
>=20
>=20
> Yes this is what i also thought of.
>=20
> >
> > 	if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */
> > 		cf->can_id |=3D CAN_RTR_FLAG;
> > 		cf->can_dlc =3D 0;
>=20
>=20
> This is superfluous, as the struct can_frame is always initialized to=
 zero.
>=20
>=20
> > 		if(cs[++idx] && (tmp =3D asc2nibble(cs[idx])) <=3D
> 0x08) /* 8 is max dlc */
> > 			cf->can_dlc =3D tmp;
>=20
>=20
> The latest can-utils use struct canfd_frames =3D> 'can_dlc' moved to =
'len'
>=20
> > 		return 0;
> > 	}
> >
> >
> > This would be perfictly fine with me, I've also done a quick test o=
f this, and
> it seems to work. And it does not give any fault when node additional=
 length
> argument is given.
>=20
>=20
> Yep.
>=20
> I wonder if it makes sense to the length 'len' too, before accessing =
cs[++idx]
> ... but when cs[++idx] is zero your code is correct too.
>=20
>=20
> Here's my suggestion:
>=20
> If it's ok for you, i can add your Signed-off-by ...

OK for me.


>=20
> diff --git a/lib.c b/lib.c
> index 4857e80..c2baa77 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -169,6 +169,11 @@ int parse_canframe(char *cs, struct canfd_frame
> *cf) {
>=20
>  	if((cs[idx] =3D=3D 'R') || (cs[idx] =3D=3D 'r')){ /* RTR frame */
>  		cf->can_id |=3D CAN_RTR_FLAG;
> +
> +		/* check for optional DLC value for CAN 2.0B
> frames */
> +		if(cs[++idx] && (tmp =3D asc2nibble(cs[idx])) <=3D
> CAN_MAX_DLC)
> +			cf->len =3D tmp;
> +
>  		return ret;
>  	}
>=20
> @@ -236,7 +241,11 @@ void sprint_canframe(char *buf , struct canfd_fr=
ame
> *cf, int sep, int maxdlen) {
>=20
>  	/* standard CAN frames may have RTR enabled. There are no
> ERR frames with RTR */
>  	if (maxdlen =3D=3D CAN_MAX_DLEN && cf->can_id &
> CAN_RTR_FLAG) {
> -		sprintf(buf+offset, "R");
> +		if (cf->len <=3D CAN_MAX_DLC)
> +			sprintf(buf+offset, "R%d", cf-
> >len);
> +		else
> +			sprintf(buf+offset, "R");
> +
>  		return;
>  	}
>=20
>=20
>=20
> Regards,
> Oliver
