From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: raw: raw_setsockopt: limit number of can_filter that
 can be set
Date: Tue, 6 Dec 2016 12:19:21 +0100
Message-ID: <ef096557-7bbc-296a-8418-30dbede85065@pengutronix.de>
References: <20161205105536.23668-1-mkl@pengutronix.de>
 <d807d5f3-632f-e5c1-dc71-7acb75717af0@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sa1cav5liidB7B8rOr72GR8WnXDjxd5Wn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43877 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751959AbcLFLTl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2016 06:19:41 -0500
In-Reply-To: <d807d5f3-632f-e5c1-dc71-7acb75717af0@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@google.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sa1cav5liidB7B8rOr72GR8WnXDjxd5Wn
Content-Type: multipart/mixed; boundary="UvrG6DprsIBwwXOk9XPINX9nCU0cHiO3m";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@google.com>
Message-ID: <ef096557-7bbc-296a-8418-30dbede85065@pengutronix.de>
Subject: Re: [PATCH] can: raw: raw_setsockopt: limit number of can_filter that
 can be set
References: <20161205105536.23668-1-mkl@pengutronix.de>
 <d807d5f3-632f-e5c1-dc71-7acb75717af0@hartkopp.net>
In-Reply-To: <d807d5f3-632f-e5c1-dc71-7acb75717af0@hartkopp.net>

--UvrG6DprsIBwwXOk9XPINX9nCU0cHiO3m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 09:44 PM, Oliver Hartkopp wrote:

> On 12/05/2016 11:55 AM, Marc Kleine-Budde wrote:
>> This patch adds a check to limit the number of can_filters that can be=
 ser via
>=20
> Typo: ser -> set

Doh!

>> setsockopt on CAN_RAW sockets.
>>
>> Otherwise allocations > MAX_ORDER are not prevented resulting in the f=
ollowing
>> warning found by Andrey Konovalov:
>=20
> Indeed I got a different warning on my machine:
>=20
> [ 7570.747275] ------------[ cut here ]------------
> [ 7570.747283] WARNING: CPU: 5 PID: 3134 at mm/slab_common.c:861=20
> kmalloc_slab+0x86/0xa0
> [ 7570.747283] Modules linked in: can_raw can ...
> [ 7570.747334] CPU: 5 PID: 3134 Comm: setsockopt-kmal Not tainted=20
> 4.9.0-rc7-00198-g0cb65c8 #1
> [ 7570.747335] Hardware name: Hewlett-Packard HP ZBook 17
> [ 7570.747337]  0000000000000000 ffffffff819b7d20 0000000000000000=20
> 0000000000000000
> [ 7570.747341]  ffffffff810f1fa8 ffffffff0000035d fffffffffffffff4=20
> 0000000018000000
> [ 7570.747344]  00000000024000c0 0000000018000000 ffff8803e35b7f20=20
> ffffffffa0244200
> [ 7570.747347] Call Trace:
> [ 7570.747354]  [<ffffffff819b7d20>] ? dump_stack+0x46/0x66
> [ 7570.747358]  [<ffffffff810f1fa8>] ? __warn+0x168/0x1a0
> [ 7570.747361]  [<ffffffff8143a276>] ? kmalloc_slab+0x86/0xa0
> [ 7570.747364]  [<ffffffff814cb2a3>] ? __kmalloc_track_caller+0x23/0x54=
0
> [ 7570.747366]  [<ffffffff814c9c9d>] ? kmem_cache_alloc+0xcd/0x530
> [ 7570.747371]  [<ffffffffa0241d0b>] ? raw_setsockopt+0x25b/0x810 [can_=
raw]
> [ 7570.747373]  [<ffffffff814c9c9d>] ? kmem_cache_alloc+0xcd/0x530
> [ 7570.747376]  [<ffffffff814299c8>] ? memdup_user+0x28/0x80
> [ 7570.747379]  [<ffffffffa0241d0b>] ? raw_setsockopt+0x25b/0x810 [can_=
raw]
> [ 7570.747382]  [<ffffffffa0241ab0>] ? raw_rcv+0x720/0x720 [can_raw]
> [ 7570.747386]  [<ffffffff82291a40>] ? sock_splice_read+0x130/0x130
> [ 7570.747390]  [<ffffffff8156c890>] ? get_unused_fd_flags+0xd0/0xd0
> [ 7570.747393]  [<ffffffff8156c384>] ? __alloc_fd+0x94/0x4d0
> [ 7570.747396]  [<ffffffff82294f1c>] ? sockfd_lookup_light+0x1c/0x150
> [ 7570.747399]  [<ffffffff82299b80>] ? SyS_setsockopt+0x110/0x1d0
> [ 7570.747401]  [<ffffffff82299a70>] ? SyS_recv+0x10/0x10
> [ 7570.747403]  [<ffffffff8229931d>] ? SyS_socket+0xed/0x180
> [ 7570.747406]  [<ffffffff8112ad9c>] ? sys_setsid+0x14c/0x330
> [ 7570.747409]  [<ffffffff8268cea4>] ? entry_SYSCALL_64_fastpath+0x17/0=
x98
> [ 7570.747411] ---[ end trace acabb2bee46c9bf4 ]---
>=20
> which points to a different check in mm/slab_common.c:861.
>=20
> I think it is generally a sane idea to limit the number of can_filters.=

>=20
> I would suggest to write a
>=20
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
>=20
> without giving a detailed example of a WARNING.

good point.

>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 4009 at mm/page_alloc.c:3511
>> __alloc_pages_slowpath+0x3d4/0x1bf0
>> Modules linked in:
>> CPU: 0 PID: 4009 Comm: a.out Not tainted 4.9.0-rc6+ #54
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/0=
1/2011
>>  ffff88006832f8a8 ffffffff81c73b14 0000000000000000 0000000000000000
>>  ffffffff842c6320 0000000000000000 ffff88006832f8f0 ffffffff8123dc57
>>  ffff880067d86000 ffffffff00000db7 ffffffff842c6320 0000000000000db7
>> Call Trace:
>>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>>  [<ffffffff81c73b14>] dump_stack+0xb3/0x10f lib/dump_stack.c:51
>>  [<ffffffff8123dc57>] __warn+0x1a7/0x1f0 kernel/panic.c:550
>>  [<ffffffff8123de6c>] warn_slowpath_null+0x2c/0x40 kernel/panic.c:585
>>  [<ffffffff81559b04>] __alloc_pages_slowpath+0x3d4/0x1bf0 mm/page_allo=
c.c:3511
>>  [<ffffffff8155b8e2>] __alloc_pages_nodemask+0x5c2/0x710 mm/page_alloc=
=2Ec:3781
>>  [<ffffffff816236a4>] alloc_pages_current+0xf4/0x400 mm/mempolicy.c:20=
72
>>  [<     inline     >] alloc_pages ./include/linux/gfp.h:469
>>  [<ffffffff815a834f>] kmalloc_order+0x1f/0x70 mm/slab_common.c:1015
>>  [<ffffffff815a83bf>] kmalloc_order_trace+0x1f/0x160 mm/slab_common.c:=
1026
>>  [<     inline     >] kmalloc_large ./include/linux/slab.h:422
>>  [<ffffffff81635e67>] __kmalloc_track_caller+0x227/0x2a0 mm/slub.c:423=
3
>>  [<ffffffff8159932c>] memdup_user+0x2c/0xa0 mm/util.c:137
>>  [<ffffffff8369e0de>] raw_setsockopt+0x1be/0x9f0 net/can/raw.c:506
>>  [<     inline     >] SYSC_setsockopt net/socket.c:1757
>>  [<ffffffff82ca10c4>] SyS_setsockopt+0x154/0x240 net/socket.c:1736
>>  [<ffffffff840f2901>] entry_SYSCALL_64_fastpath+0x1f/0xc2
>> arch/x86/entry/entry_64.S:209
>> ---[ end trace bc80556cca970089 ]---
>>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  include/uapi/linux/can.h | 1 +
>>  net/can/raw.c            | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>> index 9692cda5f8fc..c48d93a28d1a 100644
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -196,5 +196,6 @@ struct can_filter {
>>  };
>>
>>  #define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id =
*/
>> +#define CAN_RAW_FILTER_MAX 512 /* maximum number of can_filter set vi=
a setsockopt() */
>>
>>  #endif /* !_UAPI_CAN_H */
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 972c187d40ab..b075f028d7e2 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -499,6 +499,9 @@ static int raw_setsockopt(struct socket *sock, int=
 level, int optname,
>>  		if (optlen % sizeof(struct can_filter) !=3D 0)
>>  			return -EINVAL;
>>
>> +		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
>> +			return -EINVAL;
>=20
> What about -E2BIG instead of -EINVAL here?

I copied the concept from the readv/writev implementation:

http://lxr.free-electrons.com/source/fs/read_write.c#L756

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UvrG6DprsIBwwXOk9XPINX9nCU0cHiO3m--

--sa1cav5liidB7B8rOr72GR8WnXDjxd5Wn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhGnrwACgkQPTuqJayp
JWohOQf8DvzpwWU5ZoKuxvhGSnWWv9adUC/XJLi5wlqjMKIOkQCyrNWe4hgx2fxL
omZqa3ahJ9/vEyFfmkkDlKUL6QBXmAy3JVa501HHxRJuHqpjNJ+EyputqIBBPwf6
Ni6RWpAlXPYjhX0SoQCHDA8EX2k0jKSLE9iHX5lnA2ZJ/0PD05odtqcGvDwsw2/C
MLsFvgTeH9c4iF9MWw4T/Voy+VpGWqAmCxymNCKa9cdXb4NbfF9BsAUnM92oUZVW
eJv6Urd4Wc6tWRBtAzmEgMN90yajYKiiYtHNGO8OidBUJhAY8hIvBGa/yfCA/WTV
s5NdTeevBJGuZ5R9gLHduX0BoGMx6w==
=vqPN
-----END PGP SIGNATURE-----

--sa1cav5liidB7B8rOr72GR8WnXDjxd5Wn--
