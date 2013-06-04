From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Using can-utils
Date: Tue, 04 Jun 2013 20:12:18 +0200
Message-ID: <51AE2E02.3000900@hartkopp.net>
References: <673526D7-EDE8-4E9E-A0DD-D9B76BDECC5C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:10260 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3FDSMV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 14:12:21 -0400
In-Reply-To: <673526D7-EDE8-4E9E-A0DD-D9B76BDECC5C@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Niew Sh." <shniew@gmail.com>
Cc: linux-can@vger.kernel.org

On 04.06.2013 18:44, Niew Sh. wrote:

> I'm new to SocketCAN, do i need libsocketcan <git://git.pengutronix.de/git/tools/libsocketcan.git> to use the can-utils from <git://gitorious.org/linux-can/can-utils.git>?

No.

can-utils (gitorious)
-> a set of the major community tools that are usually used and referenced
(does not need libsocketcan to compile and run)

libsocketcan
-> a library for people that want to configure und control CAN interfaces from
C code (instead of using the 'ip' tool from the iproute2 package).


canutils (ptx flavour) http://git.pengutronix.de/?p=tools/canutils.git
-> five tools that are used and referenced in 'PTX dist' board support packs.
Not that much features but contains 'canconfig' for CAN interface
configuration as alternative to the 'ip' tool. canconfig uses libsocketcan.

> I mean to rightly test my CAN hardware.

I would recommend can-utils (gitorious).

> What about the can-utils from <http://www.pengutronix.de/software/socket-can/download/canutils/> is that obsolete? Please guide.
> 

See above.

Regards,
Oliver

