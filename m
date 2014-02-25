From: =?iso-8859-1?Q?Sascha_M=FCnzberg?= <samu0007@stud.fh-kl.de>
Subject: Any chance to get the Vector CANcardXL working with SocketCAN?
Date: Tue, 25 Feb 2014 13:52:36 +0000
Message-ID: <D91D9A33E1E2B046B8FBA4F6EDF45FD53D056D5D@kgtz-mb01.ds.fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gw2.fh-kl.de ([143.93.17.225]:59700 "EHLO
	mail-gw2.fh-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaBYOHk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2014 09:07:40 -0500
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I wonder if I could get the CANcardXL from Vector working with SocketCAN. 
Reading the info for the kernel module 'softing_cs' gave me some hope. 
However, I did not succeed. Here are some details about the hardware:

-----
Type: CANcardXL
Controller: Phillips SJA 1000 (another small pice of hope, since softing_cs.c 
                                               explicitly lists a 'Vector-CANcard-SJA')
Transceiver: CANcab 251 opto (Highspeed)

wusel:~/# pccardctl ident

Socket 0:
product info: "VECTOR
", "CANcardXL
", "", ""
manfid: 0x02e6, 0x0100
-----

As the manfid/prod in question is not explicitly list in the source, I started 
experimenting replacing the manfid in the source with my appropriate 
manfid. This led me to the 'Vector-CANcard-2' device from softing_cs.c 
(all others gave me 'dpram failed at 0x0000'), which gave me some kind 
of "further progress" but did not worked at all. The relevant messages 
from dmesg are:

-----
softing.0: firmware: agent loaded softing-4.6/bcard2.bin into memory
softing.0: firmware: agent loaded softing-4.6/ldcard2.bin into memory
softing.0: bootloader card boot failed (-110)
-----

It seems to me that this is due to the wrong firmware for that card. So 
my question is, if there is any chance to get this card working (with the 
softing driver module). Maybe I just would need the appropriate firmware?
 At least I would be allowed to hope. ;)

Further I found no other informations about real Vector devices, which 
are listed in softing_cs.c as working: "Vector-CANcard", 
"Vector-CANcard-SJA" and "Vector-CANcard-2". Are that some older 
devices, or what does the deviation from the real product names mean?

Best regards,

Sascha