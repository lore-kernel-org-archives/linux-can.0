From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils] trivial: fix typos concerning "separation"
 and "useful"
Date: Thu, 15 Aug 2013 21:12:13 +0200
Message-ID: <520D280D.5040506@hartkopp.net>
References: <1376593166-8560-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:46077 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3HOTMR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Aug 2013 15:12:17 -0400
In-Reply-To: <1376593166-8560-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 15.08.2013 20:59, Uwe Kleine-K=C3=B6nig wrote:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied.

Thanks Uwe!


> ---
>  can-calc-bit-timing.c | 2 +-
>  candump.c             | 2 +-
>  canlogserver.c        | 2 +-
>  cansend.c             | 2 +-
>  lib.c                 | 2 +-
>  lib.h                 | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> index a9fb992..ecf5cb6 100644
> --- a/can-calc-bit-timing.c
> +++ b/can-calc-bit-timing.c
> @@ -26,7 +26,7 @@
>  #define ENOTSUPP	524	/* Operation is not supported */
>  #endif
> =20
> -/* usefull defines */
> +/* useful defines */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> =20
>  #define do_div(a,b) a =3D (a) / (b)
> diff --git a/candump.c b/candump.c
> index b489cd9..c865bd7 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -701,7 +701,7 @@ int main(int argc, char **argv)
>  					/* log CAN frame with absolute timestamp & device */
>  					fprintf(logfile, "(%010ld.%06ld) ", tv.tv_sec, tv.tv_usec);
>  					fprintf(logfile, "%*s ", max_devname_len, devname[idx]);
> -					/* without seperator as logfile use-case is parsing */
> +					/* without separator as logfile use-case is parsing */
>  					fprint_canframe(logfile, &frame, "\n", 0, maxdlen);
>  				}
> =20
> diff --git a/canlogserver.c b/canlogserver.c
> index 6ad2078..e3350b7 100644
> --- a/canlogserver.c
> +++ b/canlogserver.c
> @@ -97,7 +97,7 @@ void print_usage(char *prg)
>  	fprintf(stderr, "       <received_can_id> & mask =3D=3D value & mas=
k\n");
>  	fprintf(stderr, "\n");
>  	fprintf(stderr, "When using more than one CAN interface the options=
\n");
> -	fprintf(stderr, "m/v/i/e have comma seperated values e.g. '-m 0,7FF=
,0'\n");
> +	fprintf(stderr, "m/v/i/e have comma separated values e.g. '-m 0,7FF=
,0'\n");
>  	fprintf(stderr, "\nUse interface name '%s' to receive from all CAN =
interfaces.\n\n", ANYDEV);
>  }
> =20
> diff --git a/cansend.c b/cansend.c
> index f12e924..aec64a5 100644
> --- a/cansend.c
> +++ b/cansend.c
> @@ -79,7 +79,7 @@ int main(int argc, char **argv)
>  		fprintf(stderr, "    <can_id>##<flags>{data}    for CAN FD frames\=
n\n");
>  		fprintf(stderr, "<can_id> can have 3 (SFF) or 8 (EFF) hex chars\n"=
);
>  		fprintf(stderr, "{data} has 0..8 (0..64 CAN FD) ASCII hex-values (=
optionally");
> -		fprintf(stderr, " seperated by '.')\n");
> +		fprintf(stderr, " separated by '.')\n");
>  		fprintf(stderr, "<flags> a single ASCII Hex value (0 .. F) which d=
efines");
>  		fprintf(stderr, " canfd_frame.flags\n\n");
>  		fprintf(stderr, "e.g. 5A1#11.2233.44556677.88 / 123#DEADBEEF / 5AA=
# / ");
> diff --git a/lib.c b/lib.c
> index 9fb1056..2755c80 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -192,7 +192,7 @@ int parse_canframe(char *cs, struct canfd_frame *=
cf) {
> =20
>  	for (i=3D0, dlen=3D0; i < maxdlen; i++){
> =20
> -		if(cs[idx] =3D=3D DATA_SEPERATOR) /* skip (optional) seperator */
> +		if(cs[idx] =3D=3D DATA_SEPERATOR) /* skip (optional) separator */
>  			idx++;
> =20
>  		if(idx >=3D len) /* end of string =3D> end of data */
> diff --git a/lib.h b/lib.h
> index 805914c..4f73743 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -102,7 +102,7 @@ int parse_canframe(char *cs, struct canfd_frame *=
cf);
>   * CAN FD frames
>   * - string layout <can_id>##<flags>{data}
>   * - <flags> a single ASCII Hex value (0 .. F) which defines canfd_f=
rame.flags
> - * - {data} has 0 to 64 hex-values that can (optionally) be seperate=
d by '.'
> + * - {data} has 0 to 64 hex-values that can (optionally) be separate=
d by '.'
>   * - return value on successful parsing: CANFD_MTU
>   *
>   * Return value on detected problems: 0
> @@ -146,7 +146,7 @@ void fprint_canframe(FILE *stream , struct canfd_=
frame *cf, char *eol, int sep,
>  void sprint_canframe(char *buf , struct canfd_frame *cf, int sep, in=
t maxdlen);
>  /*
>   * Creates a CAN frame hexadecimal output in compact format.
> - * The CAN data[] is seperated by '.' when sep !=3D 0.
> + * The CAN data[] is separated by '.' when sep !=3D 0.
>   *
>   * The type of the CAN frame (CAN 2.0 / CAN FD) is specified by maxd=
len:
>   * maxdlen =3D 8 -> CAN2.0 frame
>=20

