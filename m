From: Nikhil Kamath <Nikhil.Kamath@lnties.com>
Subject: RE: [Socketcan-users] CAN Data Transfer not happening at 1Mbps
Date: Fri, 3 Feb 2012 04:11:58 +0000
Message-ID: <4ED62A07621E9C41B8CB2F608655EF4505375D5A@POCITMSEXMB02.LntUniverse.com>
References: <4ED62A07621E9C41B8CB2F608655EF45053759D1@POCITMSEXMB02.LntUniverse.com>
 <4F2AA2B4.2090906@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout2.ltindia.com ([125.18.18.171]:35816 "EHLO
	mailout2.ltindia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2BCEMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2012 23:12:01 -0500
In-Reply-To: <4F2AA2B4.2090906@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hi Wolfgang,
Below are the details you asked for:

-This means you are not using a mainline kernel, right? Are you using Freescale's ltib linux-2.6.35 tree?
Yes , I am not using a mainline kernel , it's from the Freescale's LTIB tree.


- From what kernel version is the Flexcan driver derived?
I integrated the FlexCAN driver present in linux-2.6.38 mainline Kernel. I am not using the FlexCAN driver given by Freescale since it had issues , for e.g. I used to get the following error -RTNETLINK answers: Operation not supported.

- What does "dmesg" report when you load the driver?
flexcan netdevice driver
flexcan flexcan.0: device registered (reg_base=c8978000, irq=43)
flexcan flexcan.0: writing ctrl=0x25292004

-What does "ip -d -s link show can0" report after an unsuccessful
  transfer?
root@freescale ~$ ip -d -s link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-PASSIVE restart-ms 0
    bitrate 1007575 sample-point 0.727
    tq 90 prop-seg 3 phase-seg1 4 phase-seg2 3 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 66500000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          1          1          0
    RX: bytes  packets  errors  dropped overrun mcast
    19         5        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    2          0        0       0       0       0


-What does "candump -e any,0:0,#FFFFFFFF" report while sending
  messages?
I received a message saying invalid option for 'e' in the above command, I tried using  'L' option instead to check if something gets logged , but at 1 Mbps logging was not happening.


Further , this is the log I got when I executed the following command -
root@freescale ~$ ip link set can0 up type can bitrate 1000000
flexcan flexcan.0: bitrate error 0.7%
flexcan flexcan.0: writing ctrl=0x051ae052

Thanks and regards,
Nikhil


-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@grandegger.com]
Sent: Thursday, February 02, 2012 8:20 PM
To: Nikhil Kamath
Cc: socketcan-users@lists.berlios.de; Linux-CAN
Subject: Re: [Socketcan-users] CAN Data Transfer not happening at 1Mbps

On 02/02/2012 03:24 PM, Nikhil Kamath wrote:
> Hi,
> I am having a i.Mx35 PDK board   running linux-2.6.35 kernel. CAN communication is done using the socket CAN driver  taken from the mainline kernel.

This means you are not using a mainline kernel, right? Are you using Freescale's ltib linux-2.6.35 tree?

> Issue - Data transfer not happening at 1Mbps bitrate  , works fine on other bitrates.
>
> Please help in resolving the issue.

- From what kernel version is the Flexcan driver derived?
- What does "dmesg" report when you load the driver?
- What does "ip -d -s link show can0" report after an unsuccessful
  transfer?
- What does "candump -e any,0:0,#FFFFFFFF" report while sending
  messages?

Wolfgang.

PS:

please do not use this mailing list any longer but send your questions to the new "linux-can" mailing list address "linux-can@vger.kernel.org".
For subscription or mailing list archives please have a look to:

   http://vger.kernel.org/vger-lists.html#linux-can

Mail archives of the new linux-can mailing list can be found at:

   http://dir.gmane.org/gmane.linux.can
   http://marc.info/?l=linux-can&r=1&w=2


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
