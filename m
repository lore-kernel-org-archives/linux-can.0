From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Socketcan-users Digest, Vol 74, Issue 1
Date: Mon, 06 May 2013 09:54:03 +0200
Message-ID: <5187619B.1010406@pengutronix.de>
References: <mailman.18.1367056804.27051.socketcan-users@lists.berlios.de> <CANdmM3MJYNL_CtxAnTTkO9CLdNZR_=HEX6Vg6HoV2JHYbHkcww@mail.gmail.com> <517E215A.3060006@pengutronix.de> <CANdmM3PR9X8+qDoWZm+2XtzOuqsi9bpg9W0p0w=m2R=7UA8G5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XFVPJEFJWDSCTNSKOOST"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51101 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3EFHyO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 May 2013 03:54:14 -0400
In-Reply-To: <CANdmM3PR9X8+qDoWZm+2XtzOuqsi9bpg9W0p0w=m2R=7UA8G5A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XFVPJEFJWDSCTNSKOOST
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello kedari appana,

please don't send HTML mails, as they are not accepted on the linux-can
mailing-list.

On 05/06/2013 06:50 AM, kedari appana wrote:
>> Hi,
>>  =20
>>                  I am new to socket can  i downloaded the socketcan
> utilities
>> and when i try to run it i am getting the errors.
>> I compiled  iproute2-2.6.39.
>>
>> I made the following modifications
>>
>> In make file commented the below lines
>>
>> DESTDIR
>> DBM_INCLUDE
>> CC
>>
>> and the modifications  made are

It's good practice to illustrate your modifications with a diff.
I'm not sure if setenv works as you expected in Makefile....

>> setenv GNUEABI arm-xilinx-linux-gnueabi
>> setenv CC GNUEABI-gcc

You set CC to GNUEABI-gcc...

>> setenv LD GNUEABI-ld
>> setenv NM GNUEABI-nm
>> setenv AR GNUEABI-ar
>> setenv RANLIB GNUEABI-ranlib
>> setenv CXX GNUEABI-c++
>> setenv PREFIX /proj/epdsw/kedar/linux-xlnx/linux-xlnx/usr/
>> setenv CROSS_COMPILE_PREFIX PREFIX
>> setenv PATH /proj/epdsw/sadanand/arm-2010.09/bin:$PATH
>> setenv DBM_INCLUDE /usr/include
>> setenv INCLUDES /usr/include
>> setenv DESTDIR PREFIX


>>
>>
>> and after that i am using
>>  ./configure --host=3Darm-xilinx-linux-gnueabi  --prefix=3D$PREFIX
> --enable-debug
>> the above command
>> and it's output is
>> TC schedulers
>>  ATM    no
>>  IPT    using xtables
>> iptables modules directory: /lib/xtables
>>=20
>> when i try to use make command i am getting below error
>>
>> make[1]: Entering directory
> `/proj/epdsw/kedar/linux-xlnx/user/iproute2-2.6.39/lib'
>> GNUEABI-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes
>>  -Wall -I../include -DRESOLVE_HOSTNAMES -DLIBDIR=3D\"/usr/lib/\" -fPIC=
=20
> -c -o ll_map.o ll_map.c
>> make[1]: GNUEABI-gcc: Command not found

=2E..and make uses GNUEABI-gcc to compile your code. You probable have to=

use '$()' or '${}'. In a Makefile '$()' would be correct:

    setenv CC $(GNUEABI)-gcc

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XFVPJEFJWDSCTNSKOOST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGHYZ8ACgkQjTAFq1RaXHMPTQCbB/cBC8ElAe91TIiscW6pzIho
/4AAn1+2jLDtAGbpVpQ5zOFKAZTOC/gH
=IYkR
-----END PGP SIGNATURE-----

------enig2XFVPJEFJWDSCTNSKOOST--
