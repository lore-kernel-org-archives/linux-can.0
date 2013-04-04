From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Losing CAN messages with socket-CAN
Date: Thu, 04 Apr 2013 16:44:12 +0200
Message-ID: <20130404144412.8D1AC7DAB3329@bmail06.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out1.one.com ([91.198.169.16]:38680 "EHLO
	webmail-out1.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761960Ab3DDOwU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Apr 2013 10:52:20 -0400
Received: from bmail06.one.com (bmail06.one.com [91.198.169.71])
	by webmail-out1.b-one.net (Postfix) with ESMTP id 904D66AA2F
	for <linux-can@vger.kernel.org>; Thu,  4 Apr 2013 16:44:12 +0200 (CEST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Marc,

Thanks for the fast response. I've collected answers to your questions =
and=20
pasted them below.

Best Regards,

Jeroen Lammertink

-----------------------------------------------------------------------=
---

<> We are sending batches of 80 CAN messages using socket CAN to transf=
er an
<> image for download. After the 80 messages we wait for a response

<Are you evaluating the return value of the write() or sendmsg() system=
call?

We do evaluate the write call to the socket with an assert. I=E2=80=99v=
e included
the code below. (See CCanPort::Write()). I=E2=80=99ve also included the=
 code in
which the socket is created, just to be complete. When the problem (of
losing CAN messages) happens, the Assert is not triggered. So I deduce
that the socket remains unaware of the losing of messages.

<> consisting of a single CAN message. Within the messages we have code=
d a
<> sequence number, so that we can detect lost messages. Besides the CA=
N
<> device that is subject of download, we have also a (hardware) CAN sn=
iffer
<> on the CAN bus. We typically log CAN messages when we put them in th=
e
<> socket. With this set-up we typically detect losing a short series o=
f
<> (mostly 5) CAN messages, somewhere halfway the batch of 80. No other
<> devices are present on the CAN bus.

<> I've dumped below some version and set-up info of Ubuntu, socket-can=
 and
<> ifconfig.

<> Is this problem known?
<> May this problem be related to using an old version of socket can?

< This is either a userspace problem or a buggy driver. The driver prob=
lem
< may have been fixed in the meantime.

<> How can I upgrade Ubuntu to the latest versions of socket-can?

< First we have to figure out what's broken.

<> --------------------------------------------------------------------=
------
<> bmterra@q7buntu:~/user/jla$ uname -a
<> Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 11 22=
:19:42
<> UTC 2013 i686 i686 i386 GNU/Linux
<> bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
<> rev 20090105 abi 8
<> bmterra@q7buntu:~/user/jla$ ifconfig can0
<> can0      Link encap:UNSPEC  HWaddr
<> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
<>           UP RUNNING NOARP  MTU:16  Metric:1
<>           RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
<>           TX packets:4400 errors:0 dropped:0 overruns:0 carrier:0
<>           collisions:0 txqueuelen:1024
<>           RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
<>           Interrupt:18
<> --------------------------------------------------------------------=
------

< Which CAN hardware are you using?

Qseven module PQ7-M105IT
with Intel Platform Controller HUB EG20T IOH
with a =E2=80=9CBOSCH CAN Protocol Version 2.0B Active=20
    (ISO 11519, ISO 11898, and SAEJ2411)=E2=80=9D CAN controller
This CAN controller identifies itself (according to data sheet) as foll=
ows:
    Vendor Identification Register    8086h
    Device Identification Register    8818h
    Revision Identification Register  00h
    Class Code Register               0C0900h

-----------------------------------------------------------------------=
---

size_t CCanPort::Write(can_frame *pFrame)
{
    ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
    ASSERT(ret =3D=3D sizeof(*pFrame));
    return ret;
}

CCanPort::CCanPort()
{
    int rcvbuf_size =3D BUFFER_SIZE;

    m_Sock =3D socket( PF_CAN, SOCK_RAW, CAN_RAW );

    struct ifreq ifr;
    strcpy(ifr.ifr_name, "can0");
    ioctl(m_Sock, SIOCGIFINDEX, &ifr);

    struct sockaddr_can addr;
    addr.can_family =3D AF_CAN;
    addr.can_ifindex =3D ifr.ifr_ifindex;

    // Set receive buffer size
    setsockopt(m_Sock, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(rcvb=
uf_size));

    // Bind
    bind( m_Sock, (struct sockaddr*)&addr, sizeof(addr) );
}
