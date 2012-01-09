From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Mon, 9 Jan 2012 10:46:17 +0000 (UTC)
Message-ID: <loom.20120109T114204-932@post.gmane.org>
References: <20111221155314.GC12050@e-circ.dyndns.org> <loom.20111222T115004-22@post.gmane.org> <20111223110445.GB12091@e-circ.dyndns.org> <loom.20111228T114009-686@post.gmane.org> <20120104094715.GB320@e-circ.dyndns.org> <loom.20120104T160223-182@post.gmane.org> <20120104204151.GA306@e-circ.dyndns.org> <loom.20120105T113439-912@post.gmane.org> <20120105120930.GA372@e-circ.dyndns.org> <loom.20120105T215714-788@post.gmane.org> <20120106122550.GA17043@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39504 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854Ab2AIKqh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jan 2012 05:46:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RkCkK-0004MG-Mo
	for linux-can@vger.kernel.org; Mon, 09 Jan 2012 11:46:32 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Jan 2012 11:46:32 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 Jan 2012 11:46:32 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

now it is saying 'sendto failed: Machine is not on the network', when I am 
sending a message with id 0x15FFD000

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
    	   		perror ("bind failed");
    	   	else
        		printf("bind of s1 on can0 successful\n");
        	       	
       	
     
    int s2;
	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	
	struct sockaddr_can addr2;	
	   
    memset(&addr2, 0, sizeof(addr2));
    addr2.can_ifindex = if_nametoindex("can1");
    addr2.can_addr.j1939.name = J1939_NO_NAME;    
    addr2.can_addr.j1939.addr = 0x3d;
    addr2.can_addr.j1939.pgn = J1939_NO_PGN;
    addr2.can_family = AF_CAN;     
   
    if (bind(s2, (void *)&addr2, sizeof(addr2))<0)
    	   		perror ("bind2 failed");
        	else
        		printf("bind of s2 on can1 successful\n");
        	
    int ret;
	socklen_t len; 
	struct sockaddr_can src_addr;
	char buf[128];


	while (1) {
		len = sizeof(src_addr);
		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
		
		
		if (ret < 0)
		perror ("recvfrom failed");
		
		src_addr.can_addr.j1939.addr = J1939_NO_ADDR;

		
			if (sendto(s2, buf, ret, 0, (void *)&src_addr, len) < 0)
				perror("sendto failed");
						
	}

  		 
  return 0;
}


