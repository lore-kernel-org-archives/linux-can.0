From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Fri, 6 Jan 2012 13:25:50 +0100
Message-ID: <20120106122550.GA17043@e-circ.dyndns.org>
References: <20111221155314.GC12050@e-circ.dyndns.org>
 <loom.20111222T115004-22@post.gmane.org>
 <20111223110445.GB12091@e-circ.dyndns.org>
 <loom.20111228T114009-686@post.gmane.org>
 <20120104094715.GB320@e-circ.dyndns.org>
 <loom.20120104T160223-182@post.gmane.org>
 <20120104204151.GA306@e-circ.dyndns.org>
 <loom.20120105T113439-912@post.gmane.org>
 <20120105120930.GA372@e-circ.dyndns.org>
 <loom.20120105T215714-788@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:6385 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab2AFMZy (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Jan 2012 07:25:54 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120105T215714-788@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Jan 05, 2012 at 09:24:25PM +0000, Wolfgang wrote:
> > Note that this bridge puts the originating source address as bridged
> destination address.
> > This does not matter for PDU2 type of PGN's (== PDU-specific is not the 
> > destination address), it may not be completely right.
> > 
> > I'd expect to 'empty' (== put J1939_NO_ADDR) the src_addr.can_addr.j1939.addr 
> > member before sendto(), resulting in a broadcasted PGN.
> 
> OK I hope I fixed that, I want to keep the originating source address and it 
> should stay PDU2 type.
The source address of outgoing packets is the one you gave with bind().

> 
> > In a later iteration, You could (if necessary, since I have no clue what kind
> > of traffic you will bridge):
> > * make the receiving socket (s) 'promiscuous', i.e. receiving all traffic.
> > * fetch the original destination by using recvmsg() as illustrated in jspy.
> 
> At the moment I am also not aware what particular traffic I will bridge, I am
> still 'playing' around. But the target is to place that bridge between an 
> existing engine bus and an existing ECU. So different source address' the 
> existing ECU is 'interested' in (but I think not in all in the network) and one 
> source address from the ECU.
> 
> In the example below, I wanted, if the pgn is 0xFEF5 (this is a pgn I will 
> definitely need) to print the first byte otherwise just bridge it. 
> But it is not working! Could you see an error? Sorry!
strange.
I see 1 problem still: you will need to bind with 0x00 on can1 & with 0x3d on can0
probably. In fact, there's no need yet to bind with a valid source address on can0
since you're listening only.
That does however not explain the problem.

tried 'jspy' yet?
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
>     if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
>     	{
>     		perror ("bind2 failed");
>         	}
>     int ret;
> 	socklen_t len; 
> 	struct sockaddr_can src_addr;
> 	char buf[128];
> 
> 
> 	while (1) {
> 		len = sizeof(src_addr);
> 		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
> 		
> 		if (ret < 0)
> 		perror ("recvfrom failed");
> 		
> 		src_addr.can_addr.j1939.addr = J1939_NO_ADDR;
> 
> 		/*if the frame is sent by 0x30 do this*/
> 		if (src_addr.can_addr.j1939.pgn == 0xFEF5)
> 		{
> 			if (ret < 0)
> 			perror ("no data");
> 			
> 			printf("%x\n", buf[0]);
> /*I didn't get it what you wanted to tell me with the remainder*/
> 			
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
> 
> --Wolfgang
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
