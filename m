From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Fri, 23 Dec 2011 12:04:45 +0100
Message-ID: <20111223110445.GB12091@e-circ.dyndns.org>
References: <20111220110059.GA311@e-circ.dyndns.org>
 <loom.20111220T150849-247@post.gmane.org>
 <20111220150545.GC311@e-circ.dyndns.org>
 <loom.20111220T160841-487@post.gmane.org>
 <20111220163247.GE311@e-circ.dyndns.org>
 <loom.20111221T111539-419@post.gmane.org>
 <20111221134302.GA12050@e-circ.dyndns.org>
 <loom.20111221T153828-216@post.gmane.org>
 <20111221155314.GC12050@e-circ.dyndns.org>
 <loom.20111222T115004-22@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:19845 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab1LWLEu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Dec 2011 06:04:50 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111222T115004-22@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 22, 2011 at 01:06:06PM +0000, Wolfgang wrote:
> > You will want to create 1 socket per interface and per used source address.
> 
> OK, 2 source address, 2 interfaces = 4 sockets?!
I assume you utilize 2 source addresses, one on each interface? In that case, you
need only 2 sockets.
>  
> > You bind with can_addr.j1939.addr = 0x80 and can_addr.j1939.pgn = J1939_NO_PGN
> > then you can do sendto with dest_addr.j1939.sa = DEST address &
> > dest_addr.j1939.pgn = YOUR_PGN.
> 
> #include <sys/ioctl.h>
> #include <net/if.h>
> #include <string.h>
> #include <linux/can/j1939.h>
> #include <linux/can.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <stdio.h>
> #include <sys/types.h>
> 
> 
> int main (void)
> {
> 	int s;
> 	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> 	    
> 	struct sockaddr_can addr;
> 
>     memset(&addr, 0, sizeof(addr));
>     addr.can_ifindex = if_nametoindex("can0");
>     addr.can_addr.j1939.name = J1939_NO_NAME;    
>     addr.can_addr.j1939.addr = 0x80;
>     addr.can_addr.j1939.pgn = J1939_NO_PGN;
>     addr.can_family = AF_CAN;  
>    
>    
>     if (bind(s, (void *)&addr, sizeof(addr))<0)
>     	{
>     		perror ("bind failed");
>         	}     	
>    
>   		struct sockaddr_can dest_addr;
>   		
>   		memset(&dest_addr, 0, sizeof(dest_addr));
please set the can_family type, to avoid EINVAL
		dest_addr.can_family = AF_CAN;  
Since I suppose you do not use dynamic address claiming, do:
		dest_addr.can_addr.j1939.name = J1939_NO_NAME;
for broadcasted messages:
		dest_addr.can_addr.j1939.addr = J1939_NO_ADDR;
for destination specific messages, set .addr to the destination address.

> 		dest_addr.can_addr.j1939.name = 0x9ABCDEFULL;
>     	        dest_addr.can_addr.j1939.pgn = 0x12300;
> 
> 	
> 	if (sendto(s, frame.data, sizeof (frame.data), 0, (void *)&dest_addr, \
> sizeof(dest_addr))<0)
> 		{
> 			perror ("sendto failed");
> 		       }
>   		 
>  return 0;
> }
> 
> I hope I get that right, with the new struct sockaddr_can. But anything is wrong
> $sendto failed: Invalid argument. Sure I got the solution?!?
We're getting there ...
Kurt
> 
> 
> Thanks,
> --Wolfgang
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
