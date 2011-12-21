From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: API calls
Date: Wed, 21 Dec 2011 10:46:44 +0000 (UTC)
Message-ID: <loom.20111221T111539-419@post.gmane.org>
References: <20111216083708.GA323@e-circ.dyndns.org> <loom.20111216T095547-967@post.gmane.org> <20111216093308.GB669@e-circ.dyndns.org> <loom.20111216T150333-707@post.gmane.org> <20111217192038.GA309@e-circ.dyndns.org> <loom.20111220T112550-205@post.gmane.org> <20111220110059.GA311@e-circ.dyndns.org> <loom.20111220T150849-247@post.gmane.org> <20111220150545.GC311@e-circ.dyndns.org> <loom.20111220T160841-487@post.gmane.org> <20111220163247.GE311@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36725 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab1LUKrD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Dec 2011 05:47:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RdJhM-0000Kr-Sh
	for linux-can@vger.kernel.org; Wed, 21 Dec 2011 11:47:00 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2011 11:47:00 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2011 11:47:00 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

#include <sys/ioctl.h>
#include <net/if.h>
#include <string.h>
#include <linux/can/j1939.h>
#include <linux/can.h>
#include <unistd.h>
#include <sys/socket.h>
#include <stdio.h>


int main (void)
{
	int s;
	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	    
	struct sockaddr_can addr;

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = if_nametoindex("can0");
    
    addr.can_addr.j1939.name = J1939_NO_NAME;
    addr.can_addr.j1939.addr = 0x80;
    addr.can_addr.j1939.pgn = 0xFFD0;
    addr.can_family = AF_CAN;  
   
	struct can_frame frame;
	   
      
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    {
    perror ("bind failed");
    }
      		
	  if (send(s, frame.data, sizeof(frame.data), 0)<0)
   		{
  		 perror ("send failed");
  		 }
   
return 0;
}

It is working, the ID is composed 18FFD080, thanks. I also tried recv() - it is 
working as well. 
Is it possible to implement only the bytes you really need from the data array,
because the dlc is always 8.
So sendto() is used to send to a specific address, at the moment I am always
doing broadcast?

--Wolfgang


