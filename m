From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-utils: AOSP build improvements
Date: Mon, 18 Feb 2013 09:15:10 +0100
Message-ID: <5121E30E.1050305@pengutronix.de>
References: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2EDWGVCSUDBEIIRAPLAKH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52602 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3BRIPb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Feb 2013 03:15:31 -0500
In-Reply-To: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2EDWGVCSUDBEIIRAPLAKH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/18/2013 09:06 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Add local headers and GCC flags for all can-utils targets.

Can you create a variable PRIVATE_LOCAL_CFLAGS or whatever to hold the
-O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN

and reuse that?

Marc

>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  Android.mk |  148 ++++++++++++++++++++++++++++++++++++++++++++--------=
--------
>  1 files changed, 109 insertions(+), 39 deletions(-)
>=20
> diff --git a/Android.mk b/Android.mk
> index 56a80c1..db83bbb 100755
> --- a/Android.mk
> +++ b/Android.mk
> @@ -8,7 +8,11 @@ include $(CLEAR_VARS)
> =20
>  LOCAL_SRC_FILES :=3D lib.c
>  LOCAL_MODULE :=3D libcan
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_STATIC_LIBRARY)
> =20
> @@ -22,8 +26,11 @@ LOCAL_SRC_FILES :=3D candump.c
>  LOCAL_MODULE :=3D candump
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -37,8 +44,11 @@ LOCAL_SRC_FILES :=3D cansend.c
>  LOCAL_MODULE :=3D cansend
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -51,8 +61,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D bcmserver.c
>  LOCAL_MODULE :=3D bcmserver
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -66,8 +79,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D can-calc-bit-timing.c
>  LOCAL_MODULE :=3D can-calc-bit-timing
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -80,8 +96,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D canbusload.c
>  LOCAL_MODULE :=3D canbusload
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -94,8 +113,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D canfdtest.c
>  LOCAL_MODULE :=3D canfdtest
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -109,8 +131,11 @@ LOCAL_SRC_FILES :=3D cangen.c
>  LOCAL_MODULE :=3D cangen
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -123,8 +148,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D cangw.c
>  LOCAL_MODULE :=3D cangw
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -138,8 +166,11 @@ LOCAL_SRC_FILES :=3D canlogserver.c
>  LOCAL_MODULE :=3D canlogserver
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -153,8 +184,11 @@ LOCAL_SRC_FILES :=3D canplayer.c
>  LOCAL_MODULE :=3D canplayer
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -167,8 +201,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D cansniffer.c
>  LOCAL_MODULE :=3D cansniffer
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -182,7 +219,10 @@ LOCAL_SRC_FILES :=3D isotpdump.c
>  LOCAL_MODULE :=3D isotpdump
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -196,7 +236,10 @@ LOCAL_SRC_FILES :=3D isotprecv.c
>  LOCAL_MODULE :=3D isotprecv
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -210,7 +253,10 @@ LOCAL_SRC_FILES :=3D isotpsend.c
>  LOCAL_MODULE :=3D isotpsend
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -224,7 +270,10 @@ LOCAL_SRC_FILES :=3D isotpserver.c
>  LOCAL_MODULE :=3D isotpserver
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -238,7 +287,10 @@ LOCAL_SRC_FILES :=3D isotpsniffer.c
>  LOCAL_MODULE :=3D isotpsniffer.c
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -252,7 +304,10 @@ LOCAL_SRC_FILES :=3D isotptun.c
>  LOCAL_MODULE :=3D isotptun
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -266,8 +321,11 @@ LOCAL_SRC_FILES :=3D log2asc.c
>  LOCAL_MODULE :=3D log2asc
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -281,8 +339,11 @@ LOCAL_SRC_FILES :=3D log2long.c
>  LOCAL_MODULE :=3D log2long
>  LOCAL_MODULE_TAGS :=3D optional
>  LOCAL_STATIC_LIBRARIES :=3D libcan
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -295,8 +356,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D slcan_attach.c
>  LOCAL_MODULE :=3D slcan_attach
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -309,8 +373,11 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D slcand.c
>  LOCAL_MODULE :=3D slcand
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
> =20
> @@ -323,7 +390,10 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES :=3D slcanpty.c
>  LOCAL_MODULE :=3D slcanpty
>  LOCAL_MODULE_TAGS :=3D optional
> -LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS)
> -LOCAL_CFLAGS :=3D -O2 -g -W -Wall
> +LOCAL_C_INCLUDES :=3D $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
> +LOCAL_CFLAGS :=3D -O2 -g -W -Wall \
> +	    -DSO_RXQ_OVFL=3D40 \
> +	    -DPF_CAN=3D29 \
> +	    -DAF_CAN=3DPF_CAN
> =20
>  include $(BUILD_EXECUTABLE)
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2EDWGVCSUDBEIIRAPLAKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEh4xoACgkQjTAFq1RaXHPRBQCfdGiQBxmpUloNR55G6txJ3TqE
eowAn0CYXvghh8PlP1VfO1z/4l2rjKwi
=BHyh
-----END PGP SIGNATURE-----

------enig2EDWGVCSUDBEIIRAPLAKH--
