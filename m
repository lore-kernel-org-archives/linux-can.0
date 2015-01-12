From: Viktor Babrian <v@renyi.hu>
Subject: c_can: (newbie) high system load when frame not acked?
Date: Mon, 12 Jan 2015 18:18:26 +0100
Message-ID: <alpine.DEB.2.02.1501121751530.28201@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55738 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbbALRZG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 Jan 2015 12:25:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YAijf-00031K-Jo
	for linux-can@vger.kernel.org; Mon, 12 Jan 2015 18:25:03 +0100
Received: from login.renyi.hu ([193.224.79.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Jan 2015 18:25:03 +0100
Received: from v by login.renyi.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Jan 2015 18:25:03 +0100
In-Reply-To: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I am new to linux with can though I have had some experience with both 
separately.

I have here an am3359 board (having DCAN CAN controller). CAN transciever 
is terminated by a 60R resistor, no other party connected (no cables etc). 
I set up a can transmission using cansend:
# ip link set can1 type can bitrate 500000 triple-sampling on
# ip link set can1 up
# cansend can1 5A1#11.2233.44556677.88

Oscilloscope probe is on canh.

Everything works just fine, except:
- Frame is retransmitted for ever (seen on bus)
- user experience drops (serial terminal hardly echoes)
- load is up
- top shows sirq level of 75-80%

after bringing down can1 with
# ip link set can1 down,
I see that load is fine again (=0), however frame retransmission is going 
on still (observed by oscilloscope).
Transmission stops only after enabling can1 again:
# ip link set can1 up

Is this expected? Has anybody seen similar behavior?

I am using linux kernel 3.14.26. I have also tried c_can driver from 
3.19rc3 ("backported"=copied), same results.

Thanks in advance,
Viktor babrian

