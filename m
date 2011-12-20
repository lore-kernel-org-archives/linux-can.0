From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: API calls
Date: Tue, 20 Dec 2011 14:49:43 +0000 (UTC)
Message-ID: <loom.20111220T150849-247@post.gmane.org>
References: <20111215120434.GD321@e-circ.dyndns.org> <loom.20111215T142642-767@post.gmane.org> <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111216083708.GA323@e-circ.dyndns.org> <loom.20111216T095547-967@post.gmane.org> <20111216093308.GB669@e-circ.dyndns.org> <loom.20111216T150333-707@post.gmane.org> <20111217192038.GA309@e-circ.dyndns.org> <loom.20111220T112550-205@post.gmane.org> <20111220110059.GA311@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37506 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab1LTOt5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 09:49:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rd10t-0001Ng-Pr
	for linux-can@vger.kernel.org; Tue, 20 Dec 2011 15:49:55 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 15:49:55 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 15:49:55 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> man socket
> man bind
> man sendto
> man recv

I've forgotten those, thanks.

 
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
              
       
    if (bind(s, (void *)&addr, sizeof(addr))<0)
    {
    perror ("bind failed");
    }

    
    if (send(s, data, sizeof(data), 0) < 0)
    {
    perror ("send failed");
    }
    
return 0;
}

I changed the program, but I am wondering how to send an entire j1939 frame with
the data?

--Wolfgang


