From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: API calls
Date: Tue, 20 Dec 2011 12:00:59 +0100
Message-ID: <20111220110059.GA311@e-circ.dyndns.org>
References: <20111215120434.GD321@e-circ.dyndns.org>
 <loom.20111215T142642-767@post.gmane.org>
 <20111215140012.GA10848@e-circ.dyndns.org>
 <loom.20111215T152334-981@post.gmane.org>
 <20111216083708.GA323@e-circ.dyndns.org>
 <loom.20111216T095547-967@post.gmane.org>
 <20111216093308.GB669@e-circ.dyndns.org>
 <loom.20111216T150333-707@post.gmane.org>
 <20111217192038.GA309@e-circ.dyndns.org>
 <loom.20111220T112550-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:38973 "EHLO eia-vsv02.eia.lan"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752226Ab1LTLBE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 06:01:04 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111220T112550-205@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Dec 20, 2011 at 10:35:05AM +0000, Wolfgang wrote:
> Hi Kurt,
> 
> I am sorry, but I am not too much in socket programming yet, and I can't find 
> much information about socketCAN. I am using the j1939.txt.
man socket
man bind
man sendto
man recv
....

Socket programming (not CAN specific) wasn't very easy for me neither the first time.

Since you seem to have gottten pretty far with a first test program,
I've corrected some mistakes/bad practices.

> 
> I am trying to create a socket and send something, the addr 0x80 I have defined
> before. What have I done wrong or how is it made right?
> 
> #include <sys/ioctl.h>
> #include <net/if.h>
> #include <string.h>
#include <linux/can.h>
> #include <linux/can/j1939.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <stdio.h>
/* for if_nametoindex() */
#include <net/if.h>
> 
> 
> 
> int main ()
> {
>     int s;
>     s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> 	    
>     struct sockaddr_can addr;
> 
>     memset(&addr, 0, sizeof(addr));
>     addr.can_ifindex = ifindex("can0");
     addr.can_ifindex = if_nametoindex("can0");
>     addr.can_addr.j1939.name = TEST;
@name is used for dynamic addressing.
If you're using static addressing, assign J1939_NO_NAME (== 0, so leaving is fine too).
      addr.can_addr.j1939.name = J1939_NO_NAME;

>     addr.can_addr.j1939.addr = 0x80;
>     addr.can_addr.j1939.pgn = 0x12300;
> 
>     bind(s, (void *)&addr, sizeof(addr));
better is:
	int ret;

	if (bind(...) < 0)
		perror("bind failed");
	
	if (send(s, data, sizeof(data), 0) < 0)
		perror("send failed");

If sizeof(data) <= 8, then this
will broadcast a message with _can_id_ 0x1923ff80:
* (/*priority*/6 << 26) | (/*pgn*/0x12300 << 8) | (/*source*/0x80).
* PGN 0x123 is of type PDU1 => destination address in PDU-specific
* no destination given => broadcast (0xff).

>     
>     sendto(s, data, sizeof(data), 0, (void *)&addr, sizeof(addr));
likewise, this would send the message to ..., yourself again.
can_id will be 0x19238080

I hope this clears up a bit.
J1939 isn't very transparent on the composition of it's CAN identifiers.
The can-j1939 stack deals with all issues, safeguarding you from protocol violations
on the bus, but the stack may return error codes when you try something illegal.
You should check them (i.e. doing "if (send(...) < 0) perror(...);")

Kind regards,
Kurt
