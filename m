From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Flexcan - timestamp from message buffer to userspace
Date: Fri, 18 Oct 2013 11:56:43 +0200
Message-ID: <l3r0ki$hde$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37702 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab3JRJ5D (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 18 Oct 2013 05:57:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VX6nh-0001Jl-GD
	for linux-can@vger.kernel.org; Fri, 18 Oct 2013 11:56:57 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 18 Oct 2013 11:56:57 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 18 Oct 2013 11:56:57 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
is there any official way how to read timestamp from flexcans message 
buffer?
I see there is a macro defined FLEXCAN_MB_CNT_TIMESTAMP in flexcan.c, 
but not used.
I would modify function flecan_read_fifo like

+ u32 timestamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);

but what to do with timestamp variable next and how to read it in 
userspace? :) I could change structure can_frame and add  u32 timestamp 
into it, but it wouldn't be very nice hack I think.

BTW: is timestamp read with SO_TIMESTAMP  actualy taken when CAN message 
arrives?

Thanks,
Martin

