From: Rosemarie Sheehy <rsheehy@dairymaster.ie>
Subject: Re: SocketCAN on Intel Edison with MCP 2515
Date: Tue, 25 Aug 2015 14:49:15 +0000 (UTC)
Message-ID: <loom.20150825T164749-199@post.gmane.org>
References: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46749 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbbHYOzG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Aug 2015 10:55:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1ZUFct-0003ld-Jp
	for linux-can@vger.kernel.org; Tue, 25 Aug 2015 16:55:03 +0200
Received: from 71.165.146.213.realbroadband.com ([71.165.146.213.realbroadband.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2015 16:55:03 +0200
Received: from rsheehy by 71.165.146.213.realbroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2015 16:55:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Gallagher <mjg <at> isomorphdevelopment.com> writes:

> 
> Hello,
> 
> I am new to SocketCAN and have some basic questions, I'm hoping that
> someone might be able to point me in the right direction.
> 
> I have recompiled Yocto (uname - r returns 3.10.17-yocoto standard)
> and included the SocketCAN module as well as the drivers for the MCP
> 2515. I can see that the module has been installed, as dmesg | grep
> can returns:
> 
> [    0.754296] vcan: Virtual CAN interface driver
> [    2.033276] can: controller area network core (rev 20120528 abi 9)
> [    2.033429] can: raw protocol (rev 20120528)
> [    2.033447] can: broadcast manager protocol (rev 20120528 t)
> [    2.033476] can: netlink gateway (rev 20130117) max_hops=1
> 
> I believe I am running iproute2 because the which ip command returns 
/sbin/ip.
> 
> cat /proc/net/can/version returns :
> 
> rev 20120528 abi 9
> 
> I can also load all necessary (I think these are all the necessary
> drivers?) drivers by issuing the following modprobe commands:
> 
> modprobe can
> modprobe can-dev
> modprobe can-raw
> modprobe mcp251x
> 
> However, can0 is not recognized:
> 


Hi Michael

I am trying to trying to set the can bus on the Edison.
I have the expansion board and the can-bus shield 
(https://www.sparkfun.com/products/10039)
Can you tell me how you installed the SocketCAN module as well as the 
drivers for the MCP2515 please?

Thanks

Rosemarie




