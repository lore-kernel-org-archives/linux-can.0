From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Losing CAN messages with socket-CAN
Date: Fri, 05 Apr 2013 15:31:40 +0200
Message-ID: <20130405133140.17A179B5161E0@bmail04.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:35819 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161177Ab3DENbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Apr 2013 09:31:42 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Wolfgang,

Thanks for your response. Still working just before midnight ...
Unfortunatelly it doesn't work yet.
I've collected test results and pasted them below.

Best Regards,

Jeroen Lammertink

-----------------------------------------------------------------------=
---

<><><> We are sending batches of 80 CAN messages using socket CAN to tr=
ansfer an
<><><> image for download. After the 80 messages we wait for a response

<><><Are you evaluating the return value of the write() or sendmsg() sy=
stemcall?

<><> We do evaluate the write call to the socket with an assert. I=E2=80=
=99ve included
<><> the code below. (See CCanPort::Write()). I=E2=80=99ve also include=
d the code in
<><> which the socket is created, just to be complete. When the problem=
 (of
<><> losing CAN messages) happens, the Assert is not triggered. So I de=
duce
<><> that the socket remains unaware of the losing of messages.

<><><> consisting of a single CAN message. Within the messages we have =
coded a
<><><> sequence number, so that we can detect lost messages. Besides th=
e CAN
<><><> device that is subject of download, we have also a (hardware) CA=
N sniffer
<><><> on the CAN bus. We typically log CAN messages when we put them i=
n the
<><><> socket. With this set-up we typically detect losing a short seri=
es of
<><><> (mostly 5) CAN messages, somewhere halfway the batch of 80. No o=
ther
<><><> devices are present on the CAN bus.

<><><> I've dumped below some version and set-up info of Ubuntu, socket=
-can and
<><><> ifconfig.

<><><> Is this problem known?
<><><> May this problem be related to using an old version of socket ca=
n?

<><>< This is either a userspace problem or a buggy driver. The driver =
problem
<><>< may have been fixed in the meantime.

<><><> How can I upgrade Ubuntu to the latest versions of socket-can?

<><>< First we have to figure out what's broken.

<><><> ----------------------------------------------------------------=
----------
<><><> bmterra@q7buntu:~/user/jla$ uname -a
<><><> Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 1=
1 22:19:42
<><><> UTC 2013 i686 i686 i386 GNU/Linux
<><><> bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
<><><> rev 20090105 abi 8
<><><> bmterra@q7buntu:~/user/jla$ ifconfig can0
<><><> can0      Link encap:UNSPEC  HWaddr
<><><> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
<><><>           UP RUNNING NOARP  MTU:16  Metric:1
<><><>           RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
<><><>           TX packets:4400 errors:0 dropped:0 overruns:0 carrier:=
0
<><><>           collisions:0 txqueuelen:1024
<><><>           RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
<><><>           Interrupt:18
<><><> ----------------------------------------------------------------=
----------

<><>< Which CAN hardware are you using?

<><>Qseven module PQ7-M105IT
<><>with Intel Platform Controller HUB EG20T IOH
<><>with a =E2=80=9CBOSCH CAN Protocol Version 2.0B Active=20
<><>    (ISO 11519, ISO 11898, and SAEJ2411)=E2=80=9D CAN controller

<>< Which driver do you use? (check "ip -d -s link show can0").

<>---------------------------------------------------------------------=
-----
<>bmterra@q7buntu:~/user/jla$ ip -d -s link show can0
<>3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNO=
WN qlen 1024
<>    link/can=20
<>    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0=20
<>    bitrate 500000 sample-point 0.850=20
<>    tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 1
<>    pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
<>    clock 50000000
<>    re-started bus-errors arbit-lost error-warn error-pass bus-off
<>    0          0          0          0          0          0        =20
<>    RX: bytes  packets  errors  dropped overrun mcast  =20
<>    7464       933      0       0       0       0     =20
<>    TX: bytes  packets  errors  dropped carrier collsns=20
<>    220064     27508    0       0       0       0
<>---------------------------------------------------------------------=
-----
<>Textdump above contains "pch_can:" ...

<><>This CAN controller identifies itself (according to data sheet) as =
follows:
<><>    Vendor Identification Register    8086h
<><>    Device Identification Register    8818h
<><>    Revision Identification Register  00h
<><>    Class Code Register               0C0900h

<>< Ah, the "pch_can" driver does have known issues. End of last year I=
 sent
<>< some patches to improve the "pch_can" or, even better, make the "c_=
can"
<>< driver work on the EG20T as well. See:

<><   http://marc.info/?l=3Dlinux-can&m=3D135531975013055&w=3D2

<>< Are you able to build and use a recent mainline kernel? I need to f=
igure
<>< out how to help you best.

<>Currently a colleage of mine is attempting to build the kernel (to be=
 able to
<>apply patches to solve a display issue). I expect he will succeed one=
 of these
<>days.

We succeeded in buildin the kernel.

<>Wouldn't it be simplest just to use the latest sources of this driver=
?

< These patches are not yet mainline because they do not fix all issues=
=2E I
< do not have a system at hand and therefore somebody else needs to tak=
e
< care. We actually want to drop the pch_can driver in favor of an upda=
ted
< c_can driver. If you go over the patch series I pointed out you will =
get
< more information. Anyway, we got positive feedback especially with th=
e
< c_can driver for the EG20T.

<>Can you tell me which sources I should look for? (Probably I've downl=
oaded them
<>already, but I wish to replace only the files that make the differenc=
e)

< I think that patch 1/7 of the series may already fix your TX problems=
:

<   http://marc.info/?l=3Dlinux-can&m=3D135526076021515&w=3D2
< =C2=B4
< If you apply the remaining patches, you can select the "c_can_pci"
< driver. If you get trouble with these patches I need to adapt them to=
 a
< more recent kernel version.

My colleage has applied the patch you mentioned above. The patching was=
=20
straightforward without any problems. Also building went fine (->pch_ca=
n.ko).
I've installed the module with:
    sudo rmmod pch_can
    sudo insmod pch_can.ko=20
Unfortunatelly, running the test application resulted in an assert. To =
obtain
additional information I addapted the function CCanPort::Write() (See b=
elow).
Running gave the following result:

write returned -1
errno =3D 64
CCanPort.cpp[116]: ASSERT(ret =3D=3D sizeof(*pFrame)) FAILED=20

The errno 64 is not mentioned in man write
#define ENONET 64 /* Machine is not on the network */

At the end of this E-mail I've also included messages of dmesg.

Do you recognize these errors?
Should we continue with the pch_can driver and also apply remaining pat=
ches,
or should we switch to c_can?

<><>-------------------------------------------------------------------=
-------

<><>size_t CCanPort::Write(can_frame *pFrame)
<><>{
<><>    ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
<><>    ASSERT(ret =3D=3D sizeof(*pFrame));
<><>    return ret;
<><>}

<><>CCanPort::CCanPort()
<><>{
<><>    int rcvbuf_size =3D BUFFER_SIZE;

<><>    m_Sock =3D socket( PF_CAN, SOCK_RAW, CAN_RAW );

<><>    struct ifreq ifr;
<><>    strcpy(ifr.ifr_name, "can0");
<><>    ioctl(m_Sock, SIOCGIFINDEX, &ifr);

<><>    struct sockaddr_can addr;
<><>    addr.can_family =3D AF_CAN;
<><>    addr.can_ifindex =3D ifr.ifr_ifindex;

<><>    // Set receive buffer size
<><>    setsockopt(m_Sock, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(=
rcvbuf_size));

<><>    // Bind
<><>    bind( m_Sock, (struct sockaddr*)&addr, sizeof(addr) );
<><>}

-----------------------------------------------------------------------=
---

size_t CCanPort::Write(can_frame *pFrame)
{
    ssize_t ret =3D write(m_Sock, pFrame, sizeof(*pFrame));

    switch(ret)
    {
    case 0:
        std::cout << "write return 0" << std::endl;
        break;
    case -1:
        std::cout << "write returned -1" << std::endl;
        switch(errno)
        {
        case EAGAIN:
            std::cout << "errno =3D EAGAIN (=3DEWOULDBLOCK)" << std::en=
dl;
            break;
        case EBADF:
            std::cout << "errno =3D EBADF" << std::endl;
            break;
        case EDESTADDRREQ:
            std::cout << "errno =3D EDESTADDRREQ" << std::endl;
            break;
        case EFAULT:
            std::cout << "errno =3D EFAULT" << std::endl;
            break;
        case EFBIG:
            std::cout << "errno =3D EFBIG" << std::endl;
            break;
        case EINTR:
            std::cout << "errno =3D EINTR" << std::endl;
            break;
        case EINVAL:
            std::cout << "errno =3D EINVAL" << std::endl;
            break;
        case EIO:
            std::cout << "errno =3D EIO" << std::endl;
            break;
        case ENOSPC:
            std::cout << "errno =3D ENOSPC" << std::endl;
            break;
        case EPIPE:
            std::cout << "errno =3D EPIPE" << std::endl;
            break;
        default:
            std::cout << "errno =3D " << errno << std::endl;
            break;
        }
        break;
    default:
        std::cout << "write returned " << ret << std::endl;
    };

    ASSERT(ret =3D=3D sizeof(*pFrame));
    return ret;
}

-----------------------------------------------------------------------=
---

bmterra@q7buntu:~/user/jla$ dmesg | grep can
[    0.181560] [Firmware Bug]: ACPI: No _BQC method, cannot determine i=
nitial brightness
[    1.316862] isapnp: Scanning for PnP cards...
[    2.885786] rtc_cmos 00:08: RTC can wake from S4
[   11.119391] pch_can 0000:02:0c.3: irq 47 for MSI/MSI-X
[   11.119435] pch_can 0000:02:0c.3: (unregistered net_device): PCH CAN=
 opened with MSI
[   11.119537] pch_can 0000:02:0c.3: setting latency timer to 64
[  635.622115] can: controller area network core (rev 20090105 abi 8)
[  635.628256] can: raw protocol (rev 20090105)
[  660.069395] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  660.069561] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  660.069583] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  660.069602] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  660.069622] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  660.069641] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[ 3148.202568] pch_can 0000:02:0c.3: irq 47 for MSI/MSI-X
[ 3148.202618] pch_can 0000:02:0c.3: (unregistered net_device): PCH CAN=
 opened with MSI
[ 3148.202639] pch_can 0000:02:0c.3: setting latency timer to 64
