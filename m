From: Wolfgang <wutz@unterderbruecke.de>
Subject: API calls
Date: Tue, 20 Dec 2011 10:35:05 +0000 (UTC)
Message-ID: <loom.20111220T112550-205@post.gmane.org>
References: <20111215092018.GB321@e-circ.dyndns.org> <loom.20111215T114301-18@post.gmane.org> <20111215120434.GD321@e-circ.dyndns.org> <loom.20111215T142642-767@post.gmane.org> <20111215140012.GA10848@e-circ.dyndns.org> <loom.20111215T152334-981@post.gmane.org> <20111216083708.GA323@e-circ.dyndns.org> <loom.20111216T095547-967@post.gmane.org> <20111216093308.GB669@e-circ.dyndns.org> <loom.20111216T150333-707@post.gmane.org> <20111217192038.GA309@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52342 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab1LTKfT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 05:35:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rcx2U-0005rP-J9
	for linux-can@vger.kernel.org; Tue, 20 Dec 2011 11:35:18 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 11:35:18 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Dec 2011 11:35:18 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

I am sorry, but I am not too much in socket programming yet, and I can't find 
much information about socketCAN. I am using the j1939.txt.

I am trying to create a socket and send something, the addr 0x80 I have defined
before. What have I done wrong or how is it made right?

#include <sys/ioctl.h>
#include <net/if.h>
#include <string.h>
#include <linux/can/j1939.h>
#include <unistd.h>
#include <sys/socket.h>
#include <stdio.h>



int main ()
{
    int s;
    s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	    
    struct sockaddr_can addr;

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = ifindex("can0");
    addr.can_addr.j1939.name = TEST;
    addr.can_addr.j1939.addr = 0x80;
    addr.can_addr.j1939.pgn = 0x12300;

    bind(s, (void *)&addr, sizeof(addr));
    
    sendto(s, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
    
}


Kind regards,
Wolfgang

