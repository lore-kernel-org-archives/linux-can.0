From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: CAN messages being lost on i.MX25 with flexcan
Date: Thu, 19 Apr 2012 12:04:46 +0200
Message-ID: <jmonvu$nu8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39802 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab2DSKKI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Apr 2012 06:10:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SKoJP-0007Te-Bh
	for linux-can@vger.kernel.org; Thu, 19 Apr 2012 12:10:03 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 19 Apr 2012 12:10:03 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 19 Apr 2012 12:10:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
I'm using Voipac i.MX25 module with flexcan, kernel 2.6.38.9.
I'm sending the data at 250kbps, around 1100 msgs/sec. When I enable the 
canbus interface (canconfig can0 start), CPU load is higher, that is 
understandable, there are many interrupts. I'm not doing anything else 
then using recvmsg (or recvmmsg which is little better), but some 
messages are still lost (around 1500 messages lost from 467 000 being 
send from another source). When I start doing something (like  "cat 
/proc/interrupts",  or write to file), many more messages are lost.

Do you have any idea how to fix this? I need to make some CAN messages 
logger and I cannot lose any message (idealy :) So I made big buffer in 
my program so that I don't need to write the messages into the file 
while "recording" is enabled, after "recording" is switched off, I write 
the buffer into the file, but that is still not good enough.
Is there any way how to write to some buffer directly in flexcan driver 
(the best would be in the IRQ routine) and then read messages from this 
buffer in my program?
Or are just interrupts lost when doing something else in the system and 
I cannot fix this? Or can I somehow specify that "can rx interrupts" has 
highest prioroty?

Thanks,
Martin

