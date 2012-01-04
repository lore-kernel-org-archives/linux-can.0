From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Wed, 4 Jan 2012 21:41:51 +0100
Message-ID: <20120104204151.GA306@e-circ.dyndns.org>
References: <20111220163247.GE311@e-circ.dyndns.org>
 <loom.20111221T111539-419@post.gmane.org>
 <20111221134302.GA12050@e-circ.dyndns.org>
 <loom.20111221T153828-216@post.gmane.org>
 <20111221155314.GC12050@e-circ.dyndns.org>
 <loom.20111222T115004-22@post.gmane.org>
 <20111223110445.GB12091@e-circ.dyndns.org>
 <loom.20111228T114009-686@post.gmane.org>
 <20120104094715.GB320@e-circ.dyndns.org>
 <loom.20120104T160223-182@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:12865 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755425Ab2ADUlz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jan 2012 15:41:55 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120104T160223-182@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Jan 04, 2012 at 04:28:46PM +0000, Wolfgang wrote:
> Hi,
> 
> OK, I create 1 socket for one source address (what is the maximum of pgns per 
> socket?). 
a bit unlimited, use filters there.
> So if I use recvfrom for one specific pgn - while waiting for that specific pgn
Nope,
man recvfrom ....

can-j1939 will store the source address & PGN into the 'src_addr' (called dest_addr
in your example).
You cannot pick a specific PGN from the incoming queue.

> the other pgns from that src address are stored in the buffer of the socket and
> will be later "recvfrom"? So no can frame will be lost?
> 
> Am I right, with this, only the j1939 frame with id<0x19233000> should be
> received, but nothing is done, (just waiting for anything), what have I done 
> wrong?
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
> 	struct can_frame frame      	

you should do now:
	int ret;
	socklen_t len; 
	struct sockaddr_can src_addr;
	char buf[128];

	while (1) {
		len = sizeof(src_addr);
		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
		if (ret < 0)
			perror ("recvfrom failed");
		/* now, ret contains the received size */ 
		/* do things with data */
		/* set broadcast */
		src_addr.can_addr.j1939.addr = J1939_NO_ADDR;
		src_addr.can_addr.j1939.name = J1939_NO_NAME;
		if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
			perror("sendto failed");
	}
>    
>    struct sockaddr_can dest_addr;
>    
>    memset(&dest_addr, 0, sizeof(dest_addr));
>    dest_addr.can_family = AF_CAN;
>    dest_addr.can_addr.j1939.name = J1939_NO_NAME;
>    dest_addr.can_addr.j1939.addr = 0x30;
>    dest_addr.can_addr.j1939.pgn = 0x12300;
>    
>     	if (recvfrom(s, frame.data, sizeof(frame.data), 0, (void *)&dest_addr,\
>  sizeof(dest_addr))<0)
> 		{
>   	 	perror ("recvfrom failed");
>   	 	}
>    		 
>   return 0;
> }
> 
> 
> Wolfgang
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
