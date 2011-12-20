From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: API calls
Date: Tue, 20 Dec 2011 15:43:13 +0000 (UTC)
Message-ID: <loom.20111220T160841-487@post.gmane.org>
References: <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111216083708.GA323@e-circ.dyndns.org> <loom.20111216T095547-967@post.gmane.org> <20111216093308.GB669@e-circ.dyndns.org> <loom.20111216T150333-707@post.gmane.org> <20111217192038.GA309@e-circ.dyndns.org> <loom.20111220T112550-205@post.gmane.org> <20111220110059.GA311@e-circ.dyndns.org> <loom.20111220T150849-247@post.gmane.org> <20111220150545.GC311@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40163 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab1LTPna (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 10:43:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rd1qi-0003Fu-DJ
	for linux-can@vger.kernel.org; Tue, 20 Dec 2011 16:43:28 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 16:43:28 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 16:43:28 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I was a bit hasty. It is not working, but I don't get it. Eclipse is saying 
bind failed: Invalid argument
send failed: Destination address required

How is a frame send with id and data, like when you do $cansend can0 
-ei0x123ff80 0xFF. Because only data is sent now?


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
    addr.can_addr.j1939.pgn = 0x12300;
      
   
   struct can_frame frame;
   frame.data[1] = 0xFF;   
   
       
      
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    {
    perror ("bind failed");
    }
    
    
   if (send(s, frame.data, sizeof(frame.data), 0) < 0)
   {
   perror ("send failed");
   }
    
return 0;
}

