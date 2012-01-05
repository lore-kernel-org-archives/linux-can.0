From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Thu, 5 Jan 2012 10:55:19 +0000 (UTC)
Message-ID: <loom.20120105T113439-912@post.gmane.org>
References: <20111220163247.GE311@e-circ.dyndns.org> <loom.20111221T111539-419@post.gmane.org> <20111221134302.GA12050@e-circ.dyndns.org> <loom.20111221T153828-216@post.gmane.org> <20111221155314.GC12050@e-circ.dyndns.org> <loom.20111222T115004-22@post.gmane.org> <20111223110445.GB12091@e-circ.dyndns.org> <loom.20111228T114009-686@post.gmane.org> <20120104094715.GB320@e-circ.dyndns.org> <loom.20120104T160223-182@post.gmane.org> <20120104204151.GA306@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51766 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898Ab2AEKzf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jan 2012 05:55:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rikyr-0006NL-Af
	for linux-can@vger.kernel.org; Thu, 05 Jan 2012 11:55:33 +0100
Received: from p549CCB0B.dip.t-dialin.net ([84.156.203.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Jan 2012 11:55:33 +0100
Received: from wutz by p549CCB0B.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Jan 2012 11:55:33 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

OK, I hope I understood it right now, 'recvfrom' returns me more information 
than 'recv', I thought I can filter with it. But I have to do this before with 
struct 'j1939_filter' and 'setsockopt' to choose which frames from the bus are 
cared about.

So if I unterstand it right this should bridge from can0 to can1 and if the 
sender is 0x30 it prints the first data byte?


#include <sys/ioctl.h>
#include <net/if.h>
#include <string.h>
#include <linux/can/j1939.h>
#include <linux/can.h>
#include <unistd.h>
#include <sys/socket.h>
#include <stdio.h>
#include <sys/types.h>


int main (void)
{
	int s;
	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	    
	struct sockaddr_can addr;

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = if_nametoindex("can0");
    addr.can_addr.j1939.name = J1939_NO_NAME;    
    addr.can_addr.j1939.addr = 0x00;
    addr.can_addr.j1939.pgn = J1939_NO_PGN;
    addr.can_family = AF_CAN;  
   
   
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    	{
    		perror ("bind failed");
        	}
        	
     
    int s2;
	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	
	struct sockaddr_can addr2;	
	   
    memset(&addr2, 0, sizeof(addr2));
    addr2.can_ifindex = if_nametoindex("can1");
    addr2.can_addr.j1939.name = J1939_NO_NAME;    
    addr2.can_addr.j1939.addr = 0x3D;
    addr2.can_addr.j1939.pgn = J1939_NO_PGN;
    addr2.can_family = AF_CAN;  
   
   
    if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
    	{
    		perror ("bind2 failed");
        	}
        	
    int ret;
	socklen_t len; 
	struct sockaddr_can src_addr;
	char buf[128];
	src_addr.can_family = AF_CAN;


	while (1) {
		len = sizeof(src_addr);
		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
		
		if (ret < 0)
		perror ("recvfrom failed");

		/*if the frame is sent by 0x30 do this*/
		if (src_addr.can_addr.j1939.addr == 0x30)
		{
			printf("%x\n", buf[0]);
			
			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
				perror("sendto failed");
						
		}
		
		/*else just bridge it*/
		else 
		{
			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
				perror("sendto failed");
		}

	}

  		 
  return 0;
}


Thanks so far!


