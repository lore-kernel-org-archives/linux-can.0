From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Losing CAN messages with socket-CAN
Date: Thu, 18 Apr 2013 12:34:02 +0200
Message-ID: <20130418103402.D48CAF34CDA0B@bmail06.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:49946 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966004Ab3DRKeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Apr 2013 06:34:05 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Wolfgang,

Yesterday I was able to pick-up the work on the CAN driver again.
Tomorrow morning I'll continue the search for the root cause.
I report my findings so far.

Best Regards,

Jeroen Lammertink

-----------------------------------------------------------------------=
---

<><><><> We are sending batches of 80 CAN messages using socket CAN to =
transfer an
<><><><> image for download. After the 80 messages we wait for a respon=
se
<><><><> consisting of a single CAN message.

<><><><Are you evaluating the return value of the write() or sendmsg() =
systemcall?

<><><> We do evaluate the write call to the socket with an assert. I=E2=
=80=99ve included
<><><> the code below. (See Appendix 4). I=E2=80=99ve also included the=
 code in
<><><> which the socket is created (See Appendix 3). When the problem (=
of
<><><> losing CAN messages) happens, the Assert is not triggered. So I =
deduce
<><><> that the socket remains unaware of the losing of messages.

<><><><> Within the messages we have coded a
<><><><> sequence number, so that we can detect lost messages. Besides =
the CAN
<><><><> device that is subject of download, we have also a (hardware) =
CAN sniffer
<><><><> on the CAN bus. We typically log CAN messages when we put them=
 in the
<><><><> socket. With this set-up we typically detect losing a short se=
ries of
<><><><> (mostly 5) CAN messages, somewhere halfway the batch of 80. No=
 other
<><><><> devices are present on the CAN bus.

<><><><> I've dumped below some version and set-up info of Ubuntu, sock=
et-can and
<><><><> ifconfig. (Appendix 1)

<><><><> Is this problem known?
<><><><> May this problem be related to using an old version of socket =
can?

<><><>< This is either a userspace problem or a buggy driver. The drive=
r problem
<><><>< may have been fixed in the meantime.

<><><><> How can I upgrade Ubuntu to the latest versions of socket-can?

<><><>< First we have to figure out what's broken.

<><><>< Which CAN hardware are you using?

See "HW version info below" in Appendix 2

<><>< Which driver do you use? (check "ip -d -s link show can0").

See "SW version info below" in Appendix 1

<><>Textdump below contains "pch_can:" ...

<><>< Ah, the "pch_can" driver does have known issues. End of last year=
 I sent
<><>< some patches to improve the "pch_can" or, even better, make the "=
c_can"
<><>< driver work on the EG20T as well. See:

<><><   http://marc.info/?l=3Dlinux-can&m=3D135531975013055&w=3D2>

<><>< Are you able to build and use a recent mainline kernel? I need to=
 figure
<><>< out how to help you best.

<><>Currently a colleage of mine is attempting to build the kernel (to =
be able to
<><>apply patches to solve a display issue). I expect he will succeed o=
ne of these
<><>days.

<> We succeeded in buildin the kernel.

<><>Wouldn't it be simplest just to use the latest sources of this driv=
er?

<>< These patches are not yet mainline because they do not fix all issu=
es. I
<>< do not have a system at hand and therefore somebody else needs to t=
ake
<>< care. We actually want to drop the pch_can driver in favor of an up=
dated
<>< c_can driver. If you go over the patch series I pointed out you wil=
l get
<>< more information. Anyway, we got positive feedback especially with =
the
<>< c_can driver for the EG20T.

<><>Can you tell me which sources I should look for? (Probably I've dow=
nloaded them
<><>already, but I wish to replace only the files that make the differe=
nce)

<>< I think that patch 1/7 of the series may already fix your TX proble=
ms:

<><   http://marc.info/?l=3Dlinux-can&m=3D135526076021515&w=3D2

<>< If you apply the remaining patches, you can select the "c_can_pci"
<>< driver. If you get trouble with these patches I need to adapt them =
to a
<>< more recent kernel version.

<> My colleage has applied the patch you mentioned above. The patching =
was=20
<> straightforward without any problems. Also building went fine (->pch=
_can.ko).
<> I've installed the module with:
<>     sudo rmmod pch_can
<>     sudo insmod pch_can.ko=20
<> Unfortunatelly, running the test application resulted in an assert. =
To obtain
<> additional information I addapted the function CCanPort::Write() (Se=
e below).
<> Running gave the following result:

<> write returned -1
<> errno =3D 64
<> CCanPort.cpp[116]: ASSERT(ret =3D=3D sizeof(*pFrame)) FAILED=20

<> The errno 64 is not mentioned in man write
<> #define ENONET 64 /* Machine is not on the network */

< Hm, I'm also puzzled where this errno comes from? If you send a lot o=
f
< messages without delay I would expect an errno ENOBUFS. Could you ple=
ase
< handle the error code properly. In case of an ENOBUF errno just sleep
< for a shot time (e.g. usleep(10000)) and then retry.

I've installed kernel and related stuff myself to be able to rebuild th=
e pch_can=20
module. I also applied the patch myself, but this time I do not get suc=
h errors=20
and also the ASSERT does not trigger. I think something must have gone =
wrong with=20
applying the patch the previous time. I sugest to forget about the errn=
o =3D 64=20
problem.

Unfortunatelly the patch does not solve the problem yet.

I also changed the code with a retry loop upon ENOBUFS. I've included t=
he code=20
below.

< $ man 3 errno
< says:
<        A common mistake is to do

<            if (somecall() =3D=3D -1) {
<                printf("somecall() failed\n");
<                if (errno =3D=3D ...) { ... }
<            }

< Maybe the real errno is overwritten already by the time it's actually=
 used?

Thanks for this sugestion. I've improved the code (See Appendix 4).

<> At the end of this E-mail I've also included messages of dmesg.

<> Do you recognize these errors?

< See above.

<> Should we continue with the pch_can driver and also apply remaining =
patches,
<> or should we switch to c_can?

< Probably yes. I do not really want to care about the pch_can driver.

I've instrument the pch_xmit() function with netdev_info() calls. I've
included the code in Appendix 5. I also added a=20
"dmesg | grep pch_can", see Appendix 6.

I ran the application while experiencing one sequence number mismatch e=
rror.
I have a strong feeling that the=20
"can_put_echo_skb: BUG! echo_skb is occupied!" messages are printed whi=
le
the application is loosing CAN messages. Probably once per lost message=
=20
(plus or minus 1). I also have the feeling that it is related to a
"netif_stop_queue(ndev)"

If you have any sugestions so far please let me know.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Appendices
-----------------------------------------------------------------------=
---
Appendix 1: SW version info

bmterra@q7buntu:~/user/jla$ uname -a
Linux q7buntu 3.5.0-27-generic #46~precise1-Ubuntu SMP Tue Mar 26 19:33=
:56=20
UTC 2013 i686 i686 i386 GNU/Linux

bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
rev 20090105 abi 8

bmterra@q7buntu:~/user/jla$ ifconfig can0
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00=
-00-00-00-00 =20
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:124877 errors:0 dropped:607 overruns:0 frame:0
          TX packets:240 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1024=20
          RX bytes:999016 (999.0 KB)  TX bytes:1920 (1.9 KB)
          Interrupt:18=20

bmterra@q7buntu:~/user/jla$ ip -d -s link show can0
6: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
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
    1064080    133010   0       607     0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    1920       240      0       0       0       0     =20

I applied patch 1 of http://marc.info/?l=3Dlinux-can&m=3D13552607602151=
5&w=3D2

-----------------------------------------------------------------------=
---
Appendix 2: HW version info

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
Appendix 3

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

-----------------------------------------------------------------------=
---
Appendix 4

size_t CCanPort::Write(can_frame *pFrame)
{
    ssize_t ret;
    int err;
    while(true)
    {
        ret =3D write(m_Sock, pFrame, sizeof(*pFrame));
        err =3D errno;
        if(err!=3DENOBUFS)
        {
            break;
        }
        usleep(1000);
    }

    switch(ret)
    {
    case sizeof(*pFrame):
        break;
    case 0:
        std::cout << "write return 0" << std::endl;
        break;
    case -1:
        std::cout << "write returned -1" << std::endl;
        switch(err)
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
            std::cout << "errno =3D " << err << std::endl;
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
Appendix 5

static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *nde=
v)
{
	struct pch_can_priv *priv =3D netdev_priv(ndev);
	struct can_frame *cf =3D (struct can_frame *)skb->data;
	unsigned long flags;
	int tx_obj_no;
	int i;
	u32 id2;

	netdev_info(ndev, "Jeroen! pch_xmit\n");

	if (can_dropped_invalid_skb(ndev, skb))
	{
	    netdev_info(ndev, "Jeroen! can_dropped_invalid_skb\n");
		return NETDEV_TX_OK;
	}

	spin_lock_irqsave(&priv->lock, flags);

	tx_obj_no =3D priv->tx_obj;
	if (priv->tx_obj =3D=3D PCH_TX_OBJ_END) {
		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
		{
			netdev_info(ndev, "Jeroen! netif_stop_queue(ndev)\n");
			netif_stop_queue(ndev);
		}

		priv->tx_obj =3D PCH_TX_OBJ_START;
	} else {
		priv->tx_obj++;
	}

	spin_unlock_irqrestore(&priv->lock, flags);

	/* Setting the CMASK register. */
	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);

	/* If ID extended is set. */
	if (cf->can_id & CAN_EFF_FLAG) {
		iowrite32(cf->can_id & 0xffff, &priv->regs->ifregs[1].id1);
		id2 =3D ((cf->can_id >> 16) & 0x1fff) | PCH_ID2_XTD;
	} else {
		iowrite32(0, &priv->regs->ifregs[1].id1);
		id2 =3D (cf->can_id & CAN_SFF_MASK) << 2;
	}

	id2 |=3D PCH_ID_MSGVAL;

	/* If remote frame has to be transmitted.. */
	if (!(cf->can_id & CAN_RTR_FLAG))
		id2 |=3D PCH_ID2_DIR;

	iowrite32(id2, &priv->regs->ifregs[1].id2);

	/* Copy data to register */
	for (i =3D 0; i < cf->can_dlc; i +=3D 2) {
		iowrite16(cf->data[i] | (cf->data[i + 1] << 8),
			  &priv->regs->ifregs[1].data[i / 2]);
	}

	can_put_echo_skb(skb, ndev, tx_obj_no - PCH_RX_OBJ_END - 1);

	/* Set the size of the data. Update if2_mcont */
	iowrite32(cf->can_dlc | PCH_IF_MCONT_NEWDAT | PCH_IF_MCONT_TXRQXT |
		  PCH_IF_MCONT_TXIE, &priv->regs->ifregs[1].mcont);

	pch_can_rw_msg_obj(&priv->regs->ifregs[1].creq, tx_obj_no);

	netdev_info(ndev, "Jeroen! normal exit\n");
	return NETDEV_TX_OK;
}

-----------------------------------------------------------------------=
---
Appendix 6

bmterra@q7buntu:~/user/jla$ dmesg | grep pch_can
[    6.935595] pch_can 0000:02:0c.3: irq 47 for MSI/MSI-X
[    6.935641] pch_can 0000:02:0c.3: (unregistered net_device): PCH CAN=
 opened with MSI
[    6.935741] pch_can 0000:02:0c.3: setting latency timer to 64
[   89.989304] pch_can 0000:02:0c.3: irq 47 for MSI/MSI-X
[   89.989356] pch_can 0000:02:0c.3: (unregistered net_device): PCH CAN=
 opened with MSI
[   89.989380] pch_can 0000:02:0c.3: setting latency timer to 64
[  102.234560] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.234584] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.911657] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.911682] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.912849] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.912867] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.912887] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.912900] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.912914] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.912927] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.912942] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.912951] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.912963] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913831] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913846] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913853] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913866] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913873] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913885] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913892] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913904] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913911] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913923] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.913930] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.913938] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.913951] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915313] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915327] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915334] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915347] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915353] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915366] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915373] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915385] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915392] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915405] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.915411] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.915419] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.915432] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916766] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916787] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916799] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916816] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916828] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916845] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916857] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916874] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916886] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916903] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.916915] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.916927] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.916944] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918209] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918229] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918242] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918260] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918272] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918290] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918302] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918319] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918331] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918348] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.918360] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.918374] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.918391] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919654] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919672] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919684] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919702] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919712] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919730] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919741] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919760] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919771] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919788] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.919799] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.919812] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.919830] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921120] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921141] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921154] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921172] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921184] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921201] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921213] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921230] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921242] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921260] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.921271] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.921283] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.921300] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922560] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922580] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922592] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922610] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922622] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922639] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922651] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922669] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922681] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922699] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.922711] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.922723] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.922739] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924042] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924068] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924086] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924111] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924129] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924153] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924168] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924191] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924202] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924218] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.924229] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.924241] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.924259] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925493] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925512] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925525] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925542] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925555] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925572] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925584] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925602] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925614] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925632] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.925644] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.925656] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.925673] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.926928] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.926951] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.926963] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.926981] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.926993] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.927010] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.927021] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.927038] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.927050] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.927066] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.927078] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.927091] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.927107] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928384] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928402] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928415] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928432] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928443] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928462] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928478] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928494] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928505] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928523] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.928533] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.928545] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.928564] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929841] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.929862] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929875] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.929892] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929904] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.929922] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929934] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.929951] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929963] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.929980] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.929992] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.930005] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.930021] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.931291] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.931311] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.931323] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.931341] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.931353] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.931369] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.936367] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.936390] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.937501] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.937526] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.937553] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.937566] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.937582] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938019] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938033] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938041] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938053] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938060] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938072] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938079] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938091] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938098] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938110] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.938116] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.938125] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.938137] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939475] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939489] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939496] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939509] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939516] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939528] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939535] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939547] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939554] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939566] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.939573] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.939581] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.939594] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941426] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941447] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941460] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941478] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941492] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941509] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941521] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941538] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941551] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941568] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.941580] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.941594] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.941611] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.942891] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.942910] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.942922] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.942940] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.942951] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.942969] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.942980] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.942998] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.943009] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.943027] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.943037] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.943049] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.943067] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944370] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944390] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944401] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944419] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944430] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944448] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944459] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944475] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944486] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944503] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.944514] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.944526] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.944545] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945834] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945854] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945866] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945884] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945895] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945910] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945920] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945938] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945950] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945968] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.945980] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.945993] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.946011] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947302] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947321] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947333] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947350] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947362] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947381] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947392] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947408] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947419] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947436] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.947447] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.947459] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.947475] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948763] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948783] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948794] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948810] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948821] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948838] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948849] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948865] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948876] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948893] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.948905] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.948918] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.948935] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950208] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950229] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950241] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950260] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950272] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950289] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950301] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950318] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950330] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950348] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.950360] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.950372] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.950389] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951646] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951665] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951677] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951694] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951706] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951723] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951735] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951751] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951762] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951779] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.951790] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.951802] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.951820] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953097] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953120] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953133] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953150] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953163] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953180] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953192] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953209] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953221] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953239] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.953251] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.953264] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.953281] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954550] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954569] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954582] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954600] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954613] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954630] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954643] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954660] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954672] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954689] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.954701] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.954712] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  102.954728] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.956038] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.956057] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.956068] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.956091] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.956109] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.956130] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.956145] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.956169] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  102.956185] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  102.956208] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003056] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003082] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003106] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003123] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003146] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003164] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003185] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003203] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003225] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003243] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003265] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003282] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003304] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003315] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.003337] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003352] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003373] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003388] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003402] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003423] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003437] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003451] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003472] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003485] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003500] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003523] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003537] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003555] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003577] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003592] pch_can 0000:02:0c.3: can0: can_put_echo_skb: BUG! echo_=
skb is occupied!
[  103.003607] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.003627] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.003641] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.003657] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005435] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005457] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005469] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005485] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005498] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005515] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005527] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005544] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005556] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005574] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.005586] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.005599] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.005616] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.006870] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.006889] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.006901] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.006919] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.006931] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.006949] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.006959] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.006976] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.006987] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.007004] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.007017] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.007028] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.007045] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008326] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008344] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008355] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008372] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008383] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008401] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008412] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008430] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008442] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008459] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.008471] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.008484] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.008502] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009778] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009797] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009809] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009828] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009840] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009858] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009869] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009887] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009898] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009914] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.009925] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.009938] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.009956] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011213] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011233] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011245] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011261] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011272] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011289] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011300] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011318] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011329] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011346] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.011358] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.011370] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.011387] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012663] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012682] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012695] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012712] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012724] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012741] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012753] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012779] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012791] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012809] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.012821] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.012833] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.012850] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014114] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014136] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014149] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014166] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014179] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014196] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014209] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014226] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014238] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014255] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.014267] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.014281] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.014299] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015565] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015581] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015588] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015601] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015608] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015620] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015627] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015640] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015647] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015659] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.015666] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.015675] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.015688] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017038] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017057] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017069] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017084] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017096] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017114] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017126] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017143] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017155] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017172] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.017184] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.017197] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.017214] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018492] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018512] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018524] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018541] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018552] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018568] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018577] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018594] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018605] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018624] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.018635] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.018647] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.018664] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.019947] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.019966] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.019978] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.019995] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.020044] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.020060] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.020070] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.020093] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.020111] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.020135] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.020153] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.020175] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.020207] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.021395] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.021416] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.026893] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.026916] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.027018] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.027038] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.027062] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.027081] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.027104] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.027122] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
[  103.027144] pch_can 0000:02:0c.3: can0: Jeroen! pch_xmit
[  103.027155] pch_can 0000:02:0c.3: can0: Jeroen! netif_stop_queue(nde=
v)
[  103.027176] pch_can 0000:02:0c.3: can0: Jeroen! normal exit
