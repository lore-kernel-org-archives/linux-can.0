From: Wolfgang <wutz@unterderbruecke.de>
Subject: recv list
Date: Wed, 4 Jan 2012 16:28:46 +0000 (UTC)
Message-ID: <loom.20120104T160223-182@post.gmane.org>
References: <20111220150545.GC311@e-circ.dyndns.org> <loom.20111220T160841-487@post.gmane.org> <20111220163247.GE311@e-circ.dyndns.org> <loom.20111221T111539-419@post.gmane.org> <20111221134302.GA12050@e-circ.dyndns.org> <loom.20111221T153828-216@post.gmane.org> <20111221155314.GC12050@e-circ.dyndns.org> <loom.20111222T115004-22@post.gmane.org> <20111223110445.GB12091@e-circ.dyndns.org> <loom.20111228T114009-686@post.gmane.org> <20120104094715.GB320@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43086 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab2ADQ3D (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Jan 2012 11:29:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RiTi0-00066R-Go
	for linux-can@vger.kernel.org; Wed, 04 Jan 2012 17:29:00 +0100
Received: from p549CDCE8.dip.t-dialin.net ([84.156.220.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Jan 2012 17:29:00 +0100
Received: from wutz by p549CDCE8.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 04 Jan 2012 17:29:00 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

OK, I create 1 socket for one source address (what is the maximum of pgns per 
socket?). 
So if I use recvfrom for one specific pgn - while waiting for that specific pgn
the other pgns from that src address are stored in the buffer of the socket and
will be later "recvfrom"? So no can frame will be lost?

Am I right, with this, only the j1939 frame with id<0x19233000> should be
received, but nothing is done, (just waiting for anything), what have I done 
wrong?

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
   
   
	struct can_frame frame      	
   
   struct sockaddr_can dest_addr;
   
   memset(&dest_addr, 0, sizeof(dest_addr));
   dest_addr.can_family = AF_CAN;
   dest_addr.can_addr.j1939.name = J1939_NO_NAME;
   dest_addr.can_addr.j1939.addr = 0x30;
   dest_addr.can_addr.j1939.pgn = 0x12300;
   
    	if (recvfrom(s, frame.data, sizeof(frame.data), 0, (void *)&dest_addr,\
 sizeof(dest_addr))<0)
		{
  	 	perror ("recvfrom failed");
  	 	}
   		 
  return 0;
}


Wolfgang



