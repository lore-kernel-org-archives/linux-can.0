From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] Bit rate configuration of PEAK USB devices
Date: Tue, 15 Nov 2011 19:09:28 +0100
Message-ID: <4EC2AAD8.6080907@hartkopp.net>
References: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:49651 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab1KOSJd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2011 13:09:33 -0500
In-Reply-To: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Heinz,

On 15.11.2011 15:13, Heinz-J=FCrgen Oertel wrote:

> I tried
>  ip link set can0 type can bitrate 125000
> and I tried socketcanlib
> can_set_bitrate("can0", 125000);
> but everytime got the error=20
> RTNETLINK answers: Operation not permitted.
> Reading the "PCAN driver for Linux - User Manual" v7.1
> I could not find instructions to set the bit rate for netdev.

>

> Who knows the best and/or correct way?


Me :-)

The netdev support inside the PEAK driver is a bit like an add-on to th=
e
original character device driver.

Since PCAN Linux driver 6.0 you can compile the PEAK driver with netdev
support which means that for each detected CAN device an 'additional'
netdevice is being created.

Unfortunately these netdevices only support the sending and receiving o=
f CAN
frames BUT no configuration of the CAN devices. This is still to be don=
e via
the chardev inodes in /dev/pcanXX ..

See "PCAN driver for Linux - User Manual" v7.1, page 22

---

The 'ndev' column shows the network device assignment. For
assignment of bitrates to network devices you can either set the
desired bit rate as module load parameter or you can assign the bit
rate after loading the driver with a simple command line invocation
like:

    echo "i 0x4914 e" > /dev/pcan0

=46or this reason it is important to create the chardev-device-entries,
too. If your target does no create the device files automatically with
UDEV you have to run with the script

    ./pcan_make_devices 2

even if only the netdev driver is used.

---

Indeed i was already thinking about the integration of the netlink-base=
d
configuration interface (of the mainline kernel) into the PCAN driver.

But finally this would be another add-on ... IMHO the better approach w=
ould be
to support the PEAK hardware in the form of mainline drivers, like we a=
lready
have for the PCAN PCI and PCAN ISA hardware. A future PCAN USB driver c=
ould be
created on the basis of the existing USB CAN adapter from ESD and EMS.

Best regards,
Oliver
