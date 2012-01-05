From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Thu, 5 Jan 2012 13:09:30 +0100
Message-ID: <20120105120930.GA372@e-circ.dyndns.org>
References: <20111221134302.GA12050@e-circ.dyndns.org>
 <loom.20111221T153828-216@post.gmane.org>
 <20111221155314.GC12050@e-circ.dyndns.org>
 <loom.20111222T115004-22@post.gmane.org>
 <20111223110445.GB12091@e-circ.dyndns.org>
 <loom.20111228T114009-686@post.gmane.org>
 <20120104094715.GB320@e-circ.dyndns.org>
 <loom.20120104T160223-182@post.gmane.org>
 <20120104204151.GA306@e-circ.dyndns.org>
 <loom.20120105T113439-912@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:60879 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756531Ab2AEMJd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jan 2012 07:09:33 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120105T113439-912@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Jan 05, 2012 at 10:55:19AM +0000, Wolfgang wrote:
> OK, I hope I understood it right now, 'recvfrom' returns me more information 
> than 'recv', I thought I can filter with it. But I have to do this before with 
> struct 'j1939_filter' and 'setsockopt' to choose which frames from the bus are 
> cared about.
right!
> 
> So if I unterstand it right this should bridge from can0 to can1 and if the 
> sender is 0x30 it prints the first data byte?
pretty good. I did point a few minor remarks.
> 
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
>     addr.can_addr.j1939.addr = 0x00;
>     addr.can_addr.j1939.pgn = J1939_NO_PGN;
>     addr.can_family = AF_CAN;  
>    
>    
>     if (bind(s, (void *)&addr, sizeof(addr))<0)
>     	{
>     		perror ("bind failed");
>         	}
>         	
>      
>     int s2;
> 	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> 	
> 	struct sockaddr_can addr2;	
> 	   
>     memset(&addr2, 0, sizeof(addr2));
>     addr2.can_ifindex = if_nametoindex("can1");
>     addr2.can_addr.j1939.name = J1939_NO_NAME;    
>     addr2.can_addr.j1939.addr = 0x3D;
>     addr2.can_addr.j1939.pgn = J1939_NO_PGN;
>     addr2.can_family = AF_CAN;  
>    
>    
>     if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
>     	{
>     		perror ("bind2 failed");
>         	}
>         	
>     int ret;
> 	socklen_t len; 
> 	struct sockaddr_can src_addr;
> 	char buf[128];
> 	src_addr.can_family = AF_CAN;
This assignment is useless...
> 
> 
> 	while (1) {
> 		len = sizeof(src_addr);
> 		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
> 		
> 		if (ret < 0)
> 		perror ("recvfrom failed");
> 
> 		/*if the frame is sent by 0x30 do this*/
> 		if (src_addr.can_addr.j1939.addr == 0x30)
> 		{
you could test if 'ret' > 0, since 'ret' may be 0.
Altough sending frames without data is rare in j1939...
> 			printf("%x\n", buf[0]);
> 			
In this example, the remainder of the 'if' is equal as the 'else' ...
> 			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
> 				perror("sendto failed");
> 						
> 		}
> 		
> 		/*else just bridge it*/
> 		else 
> 		{
> 			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
> 				perror("sendto failed");
> 		}
> 
> 	}
> 
>   		 
>   return 0;
> }
> 
> 
> Thanks so far!

Note that this bridge puts the originating source address as bridged destination address.
This does not matter for PDU2 type of PGN's (== PDU-specific is not the destination address),
it may not be completely right.

I'd expect to 'empty' (== put J1939_NO_ADDR) the src_addr.can_addr.j1939.addr member
before sendto(), resulting in a broadcasted PGN.

In a later iteration, You could (if necessary, since I have no clue what kind of
traffic you will bridge):
* make the receiving socket (s) 'promiscuous', i.e. receiving all traffic.
* fetch the original destination by using recvmsg() as illustrated in jspy.

I think you're bridge will work. great job!

Kurt
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
