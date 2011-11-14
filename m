From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 BasicCAN mode
Date: Mon, 14 Nov 2011 21:02:09 +0100
Message-ID: <4EC173C1.7020408@hartkopp.net>
References: <4EC157FA.7080701@hartkopp.net> <CAF8b2jLH8CTOU5ZBTdH7yFhhb0=QmP2Y_Lkom80Bxfw0AvjA6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:57303 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab1KNUCW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2011 15:02:22 -0500
In-Reply-To: <CAF8b2jLH8CTOU5ZBTdH7yFhhb0=QmP2Y_Lkom80Bxfw0AvjA6g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yuriy Kiselev <kiselev.yuriy@gmail.com>
Cc: linux-can@vger.kernel.org


> 
>     what's your motivation for the BasicCAN mode support?
> 
> BasicCAN is used for current version of protocol in our network.


Hm, are you sure that you are not mixing up the BasicCAN mode of the SJA1000
controller with standard frame format CAN frames??

BasicCAN/FullCAN is usually a misleading and therefore outdated classification
for CAN controllers having different filter and receive message box layouts.

What kind of SJA1000 CAN controller are you using?

- SJA1000
- 82C200
- FPGA implementaion from opencores
- ???

Regards,
Oliver
