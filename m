From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Transport Protocol
Date: Mon, 27 Feb 2012 15:05:25 +0100
Message-ID: <20120227140525.GB432@e-circ.dyndns.org>
References: <loom.20120113T122554-557@post.gmane.org>
 <loom.20120116T103812-141@post.gmane.org>
 <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
 <20120116153644.GA7763@e-circ.dyndns.org>
 <loom.20120207T160415-497@post.gmane.org>
 <20120208084602.GA412@e-circ.dyndns.org>
 <loom.20120216T104829-444@post.gmane.org>
 <20120216194911.GA447@e-circ.dyndns.org>
 <loom.20120224T154038-289@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:20389 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881Ab2B0OF2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Feb 2012 09:05:28 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120224T154038-289@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

> $echo can0 > /proc/net/can-j1939/net
> $ip link set can0 up type can bitrate 500000
> $ip addr add j1939 0x00 dev can0
ok
> I am still working with the simulator software.
> Now sent the TP.CM 0x1CEC009F 0x16 0x00 0xF0 0x30 0xFF 0x00 0xEE 0x00
Oeps, this is not right, for 3 reasons:
* 0x16 is defined in the extended transport protocol, which I think you're not using
* 0xf0 bytes can be sent in 0x21 packets; you will send 0x30 of them?

* j1939 defines PGN 0x00ee00 as address claim, which is exactly 8 bytes long,
and therefore will not use transport protocol at all.

fault 1 cause the following message.
fault 2 is 'not done', but I don't know by head what the result will be. Probably
I will be tolerant and accept it.
fault 3 is no problem for the kernel module, but it is a problem for higher layers
in userspace. They should all produce an error when such packet would finally arrive..
> 
> 
> Now it responses with this:
> 0X1CEC9F00 0xFF 0x05 0xFF 0xFF 0xFF 0x00 0xEE 0x00
yep.
> 
> and I get this message:
> $j1939xtp_rx_bad_message, pgn 0ee00
> $j1939xtp_rx_abort 2, 0ee00
yep
> 
> 
> I am pretty sure I did something wrong, can you please correct?
> 
> Is it possible if everything is done right to bridge the TP.CM and TP.DT
> directly with the previous implementation?
The bridge you're making will bridge the packets on j1939 level, which is
for transport protocol different than bridging on CAN level.
This means that after the entire transport protocol is received on can0,
transmission starts on can1.
> 
Kurt
