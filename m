From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Bit rate configuration of PEAK USB devices
Date: Tue, 15 Nov 2011 15:13:18 +0100
Message-ID: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:53810 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755880Ab1KOONY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Nov 2011 09:13:24 -0500
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Hello,

I tried
 ip link set can0 type can bitrate 125000
and I tried socketcanlib
can_set_bitrate("can0", 125000);
but everytime got the error 
RTNETLINK answers: Operation not permitted.
Reading the "PCAN driver for Linux - User Manual" v7.1
I could not find instructions to set the bit rate for netdev.
 
Who knows the best and/or correct way?

 Regards
   Heinz
