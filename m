From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Losing CAN messages with socket-CAN
Date: Sun, 07 Apr 2013 15:13:27 +0200
Message-ID: <516170F7.5040400@grandegger.com>
References: <20130405133140.17A179B5161E0@bmail04.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50972 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933564Ab3DGNNb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 7 Apr 2013 09:13:31 -0400
In-Reply-To: <20130405133140.17A179B5161E0@bmail04.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

Hi Jeroen,

On 04/05/2013 03:31 PM, j.p.lammertink wrote:
> Hi Wolfgang,
>=20
> Thanks for your response. Still working just before midnight ...
> Unfortunatelly it doesn't work yet.
> I've collected test results and pasted them below.
>=20
> Best Regards,
>=20
> Jeroen Lammertink
>=20
> ---------------------------------------------------------------------=
-----
=2E..
> <>Can you tell me which sources I should look for? (Probably I've dow=
nloaded them
> <>already, but I wish to replace only the files that make the differe=
nce)
>=20
> < I think that patch 1/7 of the series may already fix your TX proble=
ms:
>=20
> <   http://marc.info/?l=3Dlinux-can&m=3D135526076021515&w=3D2
> < =B4
> < If you apply the remaining patches, you can select the "c_can_pci"
> < driver. If you get trouble with these patches I need to adapt them =
to a
> < more recent kernel version.
>=20
> My colleage has applied the patch you mentioned above. The patching w=
as=20
> straightforward without any problems. Also building went fine (->pch_=
can.ko).
> I've installed the module with:
>     sudo rmmod pch_can
>     sudo insmod pch_can.ko=20

What kernel version did you finally use? Could you show your pch_can.c?

> Unfortunatelly, running the test application resulted in an assert. T=
o obtain
> additional information I addapted the function CCanPort::Write() (See=
 below).
> Running gave the following result:
>=20
> write returned -1
> errno =3D 64
> CCanPort.cpp[116]: ASSERT(ret =3D=3D sizeof(*pFrame)) FAILED=20
>=20
> The errno 64 is not mentioned in man write
> #define ENONET 64 /* Machine is not on the network */

Hm, I'm also puzzled where this errno comes from? If you send a lot of
messages without delay I would expect an errno ENOBUFS. Could you pleas=
e
handle the error code properly. In case of an ENOBUF errno just sleep
for a shot time (e.g. usleep(10000)) and then retry.

> At the end of this E-mail I've also included messages of dmesg.
>=20
> Do you recognize these errors?

See above.

> Should we continue with the pch_can driver and also apply remaining p=
atches,
> or should we switch to c_can?

Probably yes. I do not really want to care about the pch_can driver.

> <><>-----------------------------------------------------------------=
---------
>=20
> <><>size_t CCanPort::Write(can_frame *pFrame)
> <><>{
> <><>    ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
> <><>    ASSERT(ret =3D=3D sizeof(*pFrame));
> <><>    return ret;
> <><>}
>=20
> <><>CCanPort::CCanPort()
> <><>{
> <><>    int rcvbuf_size =3D BUFFER_SIZE;
>=20
> <><>    m_Sock =3D socket( PF_CAN, SOCK_RAW, CAN_RAW );
>=20
> <><>    struct ifreq ifr;
> <><>    strcpy(ifr.ifr_name, "can0");
> <><>    ioctl(m_Sock, SIOCGIFINDEX, &ifr);
>=20
> <><>    struct sockaddr_can addr;
> <><>    addr.can_family =3D AF_CAN;
> <><>    addr.can_ifindex =3D ifr.ifr_ifindex;
>=20
> <><>    // Set receive buffer size
> <><>    setsockopt(m_Sock, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeo=
f(rcvbuf_size));
>=20
> <><>    // Bind
> <><>    bind( m_Sock, (struct sockaddr*)&addr, sizeof(addr) );
> <><>}
>=20
> ---------------------------------------------------------------------=
-----
>=20
> size_t CCanPort::Write(can_frame *pFrame)
> {
>     ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
>=20
>     switch(ret)
>     {
>     case 0:
>         std::cout << "write return 0" << std::endl;
>         break;
>     case -1:
>         std::cout << "write returned -1" << std::endl;
>         switch(errno)
>         {
>         case EAGAIN:
>             std::cout << "errno =3D EAGAIN (=3DEWOULDBLOCK)" << std::=
endl;
>             break;
>         case EBADF:
>             std::cout << "errno =3D EBADF" << std::endl;
>             break;
>         case EDESTADDRREQ:
>             std::cout << "errno =3D EDESTADDRREQ" << std::endl;
>             break;
>         case EFAULT:
>             std::cout << "errno =3D EFAULT" << std::endl;
>             break;
>         case EFBIG:
>             std::cout << "errno =3D EFBIG" << std::endl;
>             break;
>         case EINTR:
>             std::cout << "errno =3D EINTR" << std::endl;
>             break;
>         case EINVAL:
>             std::cout << "errno =3D EINVAL" << std::endl;
>             break;
>         case EIO:
>             std::cout << "errno =3D EIO" << std::endl;
>             break;
>         case ENOSPC:
>             std::cout << "errno =3D ENOSPC" << std::endl;
>             break;
>         case EPIPE:
>             std::cout << "errno =3D EPIPE" << std::endl;
>             break;
>         default:
>             std::cout << "errno =3D " << errno << std::endl;
>             break;
>         }
>         break;
>     default:
>         std::cout << "write returned " << ret << std::endl;
>     };
>=20
>     ASSERT(ret =3D=3D sizeof(*pFrame));
>     return ret;
> }
>=20
> ---------------------------------------------------------------------=
-----
>=20
> bmterra@q7buntu:~/user/jla$ dmesg | grep can
> [    0.181560] [Firmware Bug]: ACPI: No _BQC method, cannot determine=
 initial brightness
> [    1.316862] isapnp: Scanning for PnP cards...
> [    2.885786] rtc_cmos 00:08: RTC can wake from S4
> [   11.119391] pch_can 0000:02:0c.3: irq 47 for MSI/MSI-X
> [   11.119435] pch_can 0000:02:0c.3: (unregistered net_device): PCH C=
AN opened with MSI
> [   11.119537] pch_can 0000:02:0c.3: setting latency timer to 64
> [  635.622115] can: controller area network core (rev 20090105 abi 8)
> [  635.628256] can: raw protocol (rev 20090105)
> [  660.069395] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!
> [  660.069561] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!
> [  660.069583] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!
> [  660.069602] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!
> [  660.069622] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!
> [  660.069641] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! ech=
o_skb is occupied!

These are real problems. Did you see them without the patch as well?

Wolfgang.

