From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Memory corruption
Date: Wed, 20 Jul 2016 09:36:19 +0200
Message-ID: <20160720073619.GC5233@airbook>
References: <CA+8_ywZWX9ECCvsRM5NOXaD9TvL1Sg=WuSGELfmAhzYRn6Z_GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:38162 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbcGTHtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2016 03:49:15 -0400
Content-Disposition: inline
In-Reply-To: <CA+8_ywZWX9ECCvsRM5NOXaD9TvL1Sg=WuSGELfmAhzYRn6Z_GA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: linux-can@vger.kernel.org

Hey Maxime,

I added linux-can in CC:
I appreciate your comments.
I will try to provide you with proper answers.
I'll first fresh up my memory, and look into the code.
I hope to come back on this before the weekend.

Kind regards,
Kurt

--- Original message ---
> Date: Tue, 19 Jul 2016 15:15:24 +0200
> From: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> To: kurt@vandijck-laurijssen.be
> Subject: J1939 Memory corruption
>=20
>    Hello Kurt,
>    I am a user of your J1939 implementation for linux. Previously I w=
as
>    using it with a linux 2.6.32 with success. Recently we moved to a =
4.1
>    kernel, so I am currently testing the new J1939 implementation (th=
e
>    'direct' one). I merged the linux j1939d-v4.1 branch into my tree =
and
>    it works correctly. Not having to patch and use iproute2 is greatl=
y
>    appreciated.
>    However, I am able to reliably reproduce a kernel panic, or at lea=
st a
>    kref warning which leads to a random kernel crash some time later.
>    I have attached a C program reproducing the problem, but here is a
>    quick description:
>    - I bind a J1939 socket to source address 0x80 with name
>    0x7777777777777777
>    - I send an address claim for this source address
>    - Another "external" ECU sends an address claim for 0x80 with name
>    0x1111111111111111 (which has higher priority, so "wins" the sourc=
e
>    address).
>    - I re-bind my J1939 socket to source address 0x81.
>    This leads to:
>    ------------[ cut here ]------------
>    WARNING: CPU: 0 PID: 861 at include/linux/kref.h:47
>    j1939_name_local_get+0x128/0x13c()
>    Modules linked in:
>    CPU: 0 PID: 861 Comm: j1939 Not tainted 4.1.24-linux4sam_5.3 #64
>    Hardware name: Atmel SAMA5
>    [<c001721c>] (unwind_backtrace) from [<c00145e8>]
>    (show_stack+0x20/0x24)
>    [<c00145e8>] (show_stack) from [<c0697db0>] (dump_stack+0x24/0x28)
>    [<c0697db0>] (dump_stack) from [<c0027a14>]
>    (warn_slowpath_common+0x94/0xc0)
>    [<c0027a14>] (warn_slowpath_common) from [<c0027afc>]
>    (warn_slowpath_null+0x2c/0x34)
>    [<c0027afc>] (warn_slowpath_null) from [<c05a00ec>]
>    (j1939_name_local_get+0x128/0x13c)
>    [<c05a00ec>] (j1939_name_local_get) from [<c05a42c8>]
>    (j1939sk_bind+0x208/0x360)
>    [<c05a42c8>] (j1939sk_bind) from [<c049aef4>] (SyS_bind+0x6c/0x9c)
>    [<c049aef4>] (SyS_bind) from [<c0010860>] (ret_fast_syscall+0x0/0x=
60)
>    ---[ end trace 93231ae522a8b287 ]---
>    FYI, candump during this:
>    (029.642505)=C2  can0=C2  18EEFF80=C2 =C2  [8]=C2  77 77 77 77 77 =
77 77 77
>    (001.001629)=C2  can0=C2  18EEFF80=C2 =C2  [8]=C2  11 11 11 11 11 =
11 11 11
>    (001.234503)=C2  can0=C2  18EEFF81=C2 =C2  [8]=C2  77 77 77 77 77 =
77 77 77
>    I tried to understand to problem and arrived to the following (and
>    incomplete) conclusions:
>    It seems to be a mismatch between the ecu list in priv->ecus and t=
he
>    refcounting of the ECUs.
>    When the external address claim is received, __j1939_ecu_unregiste=
r is
>    called by j1939_process_address_claim for my ECU and it is removed=
 from
>    the priv->ecus list but there are still some references to it, so =
it is
>    not freed.
>    Then, when re-binding the socket, j1939_name_local_put is called w=
hich
>    calls __j1939_ecu_get_register=C2  which does not find the name in=
 the
>    priv->ecus list, so it reallocates a new ECU and insert it in the
>    priv->ecus list. However j1939_name_local_put immediately drops th=
e ECU
>    reference, so the ECU is freed, but it is still in the priv->ecus =
list!
>    So the list contains a reference to a freed structure. The previou=
s
>    warning appears when kref tries to take a reference while the coun=
t is
>    already at zero. At this point the kernel panics, either when clos=
ing
>    the socket, or randomly a few seconds later because the memory is
>    corrupted.
>    I have trouble following where all the krefs to the ecus are taken=
 and
>    if it all makes sense everywhere. __j1939_ecu_get_register can eit=
her
>    allocate a new ECU and hold a reference (kref_init initializes at =
1),
>    or return an existing ECU without touching the reference count. Ho=
w is
>    it possible to know if the caller must call put_j1939_ecu when don=
e
>    with the ecu?
>    By the way, __j1939_ecu_get_register has a unused "create_if_neces=
sary"
>    parameter.
>    Although I probably could fix these issues with some time, I would
>    appreciate any help you can give me.
>    Thanks in advance,
>    --
>    Maxime Jayat

> #include <errno.h>
> #include <inttypes.h>
> #include <net/if.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/types.h>
> #include <unistd.h>
> /* linux can headers copied into currect directory */
> #include "can.h"
> #include "raw.h"
> #include "j1939.h"
>=20
>=20
> static int open_j1939_socket(const char *iface, uint64_t name, uint8_=
t sa)
> {
> 	int ret, sock;
> 	int value;
> 	struct sockaddr_can saddr =3D {
> 		.can_family =3D AF_CAN,
> 		.can_addr.j1939 =3D {
> 			.name =3D name,
> 			.addr =3D sa,
> 			.pgn =3D 0x0ee00,
> 		},
> 	};
>=20
> 	sock =3D ret =3D socket(PF_CAN, SOCK_DGRAM | SOCK_CLOEXEC, CAN_J1939=
);
> 	if (ret < 0) {
> 		goto fail;
> 	}
>=20
> 	ret =3D setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE,
> 			 iface, strnlen(iface, 40));
> 	if (ret < 0) {
> 		goto fail;
> 	}
>=20
> 	ret =3D bind(sock, (void *)&saddr, sizeof(saddr));
> 	if (ret < 0) {
> 		goto fail;
> 	}
> 	return sock;
>=20
>   fail:
> 	close(sock);
> 	return -1;
> }
>=20
> static int open_raw_socket(const char *iface)
> {
> 	int s;
> 	struct sockaddr_can addr;
> 	struct ifreq ifr;
> 	s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
>=20
> 	strcpy(ifr.ifr_name, iface);
> 	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> 		perror("SIOCGIFINDEX");
> 		return 1;
> 	}
> 	addr.can_family =3D AF_CAN;
> 	addr.can_ifindex =3D ifr.ifr_ifindex;
>=20
> 	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> 		perror("bind");
> 		return 1;
> 	}
>=20
> 	return s;
> }
>=20
>=20
> int main(void)
> {
> 	int s1939, sraw;
> 	uint64_t name =3D 0x7777777777777777ll;
> 	uint8_t buf[8];
>=20
> 	s1939 =3D open_j1939_socket("can0", name, /* src address */ 0x80);
> 	sraw =3D open_raw_socket("can0");
>=20
> 	memcpy(buf, &name, 8);
> 	/* Send address claim for src address 0x80 */
> 	send(s1939, buf, 8, 0);
> 	sleep(1);
> 	{
> 		/* Simulate an ecu claiming src address 0x80 with smaller NAME */
> 		struct can_frame frame =3D {
> 			.can_id =3D 0x18eeff80 | CAN_EFF_FLAG,
> 			.can_dlc =3D 8,
> 			.data =3D { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11 }
> 		};
> 		write(sraw, &frame, sizeof(frame));
> 	}
> 	sleep(1);
> 	/* Rebind to src address 0x81 */
> 	struct sockaddr_can saddr =3D {
> 		.can_family =3D AF_CAN,
> 		.can_addr.j1939 =3D {
> 			.name =3D name,
> 			.addr =3D 0x81,
> 			.pgn =3D 0x0ee00,
> 		},
> 	};
> 	bind(s1939, (void *)&saddr, sizeof(saddr));
> 	/* Memory corrupted */
>=20
> 	close(s1939);
> 	close(sraw);
> }

