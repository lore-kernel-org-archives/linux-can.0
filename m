From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Mon, 9 Jan 2012 14:26:38 +0100
Message-ID: <20120109132638.GI386@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:15806 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754160Ab2AIN0k (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jan 2012 08:26:40 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Mon, Jan 09, 2012 at 10:46:17AM +0000, Wolfgang wrote:
> Hi,
> 
> now it is saying 'sendto failed: Machine is not on the network', when I am 
> sending a message with id 0x15FFD000
I think what happens is that your engine ECU (0x00) does address claiming.
During recvfrom, its 8byte name is returned in src_addr too.
Since that name has not been seen on the second network, you get an error.

Try clearing the destination NAME by:

> 
> 		len = sizeof(src_addr);
> 		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
> 		
> 		
> 		if (ret < 0)
> 		perror ("recvfrom failed");
> 		
> 		src_addr.can_addr.j1939.addr = J1939_NO_ADDR;

+ 		src_addr.can_addr.j1939.name = J1939_NO_NAME;

> 
> 		
> 			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
> 				perror("sendto failed");
> 						
> 	}
> 

Kurt
