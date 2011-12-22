From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Thu, 22 Dec 2011 13:06:06 +0000 (UTC)
Message-ID: <loom.20111222T115004-22@post.gmane.org>
References: <20111217192038.GA309@e-circ.dyndns.org> <loom.20111220T112550-205@post.gmane.org> <20111220110059.GA311@e-circ.dyndns.org> <loom.20111220T150849-247@post.gmane.org> <20111220150545.GC311@e-circ.dyndns.org> <loom.20111220T160841-487@post.gmane.org> <20111220163247.GE311@e-circ.dyndns.org> <loom.20111221T111539-419@post.gmane.org> <20111221134302.GA12050@e-circ.dyndns.org> <loom.20111221T153828-216@post.gmane.org> <20111221155314.GC12050@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42086 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab1LVNGX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Dec 2011 08:06:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RdiLi-0000T4-Ad
	for linux-can@vger.kernel.org; Thu, 22 Dec 2011 14:06:20 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2011 14:06:18 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2011 14:06:18 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> You will want to create 1 socket per interface and per used source address.

OK, 2 source address, 2 interfaces = 4 sockets?!
 
> You bind with can_addr.j1939.addr = 0x80 and can_addr.j1939.pgn = J1939_NO_PGN
> then you can do sendto with dest_addr.j1939.sa = DEST address &
> dest_addr.j1939.pgn = YOUR_PGN.

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
    addr.can_addr.j1939.addr = 0x80;
    addr.can_addr.j1939.pgn = J1939_NO_PGN;
    addr.can_family = AF_CAN;  
   
   
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    	{
    		perror ("bind failed");
        	}     	
   
  		struct sockaddr_can dest_addr;
  		
  		memset(&dest_addr, 0, sizeof(dest_addr));
		dest_addr.can_addr.j1939.name = 0x9ABCDEFULL;
    	        dest_addr.can_addr.j1939.pgn = 0x12300;

	
	if (sendto(s, frame.data, sizeof (frame.data), 0, (void *)&dest_addr, \
sizeof(dest_addr))<0)
		{
			perror ("sendto failed");
		       }
  		 
 return 0;
}

I hope I get that right, with the new struct sockaddr_can. But anything is wrong
$sendto failed: Invalid argument. Sure I got the solution?!?


Thanks,
--Wolfgang




