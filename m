From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Losing CAN messages with socket-CAN
Date: Thu, 04 Apr 2013 18:16:08 +0200
Message-ID: <20130404161608.8B2BF3E5B2D4A@bmail02.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:54295 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762839Ab3DDQQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Apr 2013 12:16:10 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Wolfgang,

It looks like you can help us out. That would realy be great!
I've collected answers to your questions and pasted them below.

Best Regards,

Jeroen Lammertink

-----------------------------------------------------------------------=
---

<><> We are sending batches of 80 CAN messages using socket CAN to tran=
sfer an
<><> image for download. After the 80 messages we wait for a response

<><Are you evaluating the return value of the write() or sendmsg() syst=
emcall?

<> We do evaluate the write call to the socket with an assert. I=E2=80=99=
ve included
<> the code below. (See CCanPort::Write()). I=E2=80=99ve also included =
the code in
<> which the socket is created, just to be complete. When the problem (=
of
<> losing CAN messages) happens, the Assert is not triggered. So I dedu=
ce
<> that the socket remains unaware of the losing of messages.

<><> consisting of a single CAN message. Within the messages we have co=
ded a
<><> sequence number, so that we can detect lost messages. Besides the =
CAN
<><> device that is subject of download, we have also a (hardware) CAN =
sniffer
<><> on the CAN bus. We typically log CAN messages when we put them in =
the
<><> socket. With this set-up we typically detect losing a short series=
 of
<><> (mostly 5) CAN messages, somewhere halfway the batch of 80. No oth=
er
<><> devices are present on the CAN bus.

<><> I've dumped below some version and set-up info of Ubuntu, socket-c=
an and
<><> ifconfig.

<><> Is this problem known?
<><> May this problem be related to using an old version of socket can?

<>< This is either a userspace problem or a buggy driver. The driver pr=
oblem
<>< may have been fixed in the meantime.

<><> How can I upgrade Ubuntu to the latest versions of socket-can?

<>< First we have to figure out what's broken.

<><> ------------------------------------------------------------------=
--------
<><> bmterra@q7buntu:~/user/jla$ uname -a
<><> Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 11 =
22:19:42
<><> UTC 2013 i686 i686 i386 GNU/Linux
<><> bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
<><> rev 20090105 abi 8
<><> bmterra@q7buntu:~/user/jla$ ifconfig can0
<><> can0      Link encap:UNSPEC  HWaddr
<><> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
<><>           UP RUNNING NOARP  MTU:16  Metric:1
<><>           RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
<><>           TX packets:4400 errors:0 dropped:0 overruns:0 carrier:0
<><>           collisions:0 txqueuelen:1024
<><>           RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
<><>           Interrupt:18
<><> ------------------------------------------------------------------=
--------

<>< Which CAN hardware are you using?

<>Qseven module PQ7-M105IT
<>with Intel Platform Controller HUB EG20T IOH
<>with a =E2=80=9CBOSCH CAN Protocol Version 2.0B Active=20
<>    (ISO 11519, ISO 11898, and SAEJ2411)=E2=80=9D CAN controller

< Which driver do you use? (check "ip -d -s link show can0").

-----------------------------------------------------------------------=
---
bmterra@q7buntu:~/user/jla$ ip -d -s link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen 1024
    link/can=20
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0=20
    bitrate 500000 sample-point 0.850=20
    tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1
    pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    7464       933      0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    220064     27508    0       0       0       0
-----------------------------------------------------------------------=
---
Textdump above contains "pch_can:" ...

<>This CAN controller identifies itself (according to data sheet) as fo=
llows:
<>    Vendor Identification Register    8086h
<>    Device Identification Register    8818h
<>    Revision Identification Register  00h
<>    Class Code Register               0C0900h

< Ah, the "pch_can" driver does have known issues. End of last year I s=
ent
< some patches to improve the "pch_can" or, even better, make the "c_ca=
n"
< driver work on the EG20T as well. See:

<   http://marc.info/?l=3Dlinux-can&m=3D135531975013055&w=3D2

< Are you able to build and use a recent mainline kernel? I need to fig=
ure
< out how to help you best.

Currently a colleage of mine is attempting to build the kernel (to be a=
ble to
apply patches to solve a display issue). I expect he will succeed one o=
f these
days.
Wouldn't it be simplest just to use the latest sources of this driver?
Can you tell me which sources I should look for? (Probably I've downloa=
ded them
already, but I wish to replace only the files that make the difference)

<>---------------------------------------------------------------------=
-----

<>size_t CCanPort::Write(can_frame *pFrame)
<>{
<>    ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
<>    ASSERT(ret =3D=3D sizeof(*pFrame));
<>    return ret;
<>}

<>CCanPort::CCanPort()
<>{
<>    int rcvbuf_size =3D BUFFER_SIZE;

<>    m_Sock =3D socket( PF_CAN, SOCK_RAW, CAN_RAW );

<>    struct ifreq ifr;
<>    strcpy(ifr.ifr_name, "can0");
<>    ioctl(m_Sock, SIOCGIFINDEX, &ifr);

<>    struct sockaddr_can addr;
<>    addr.can_family =3D AF_CAN;
<>    addr.can_ifindex =3D ifr.ifr_ifindex;

<>    // Set receive buffer size
<>    setsockopt(m_Sock, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(rc=
vbuf_size));

<>    // Bind
<>    bind( m_Sock, (struct sockaddr*)&addr, sizeof(addr) );
<>}
