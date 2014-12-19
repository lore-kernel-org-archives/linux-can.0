From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Fri, 19 Dec 2014 10:33:51 +0100
Message-ID: <5493F0FF.7070101@hartkopp.net>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net> <loom.20141218T070747-796@post.gmane.org> <549280D0.6060507@hartkopp.net> <20141218121502.24633.14829@shannon> <5492D0A8.1060000@hartkopp.net> <5492DC38.9090501@hartkopp.net> <loom.20141219T004928-872@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:63355 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaLSJe7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 04:34:59 -0500
In-Reply-To: <loom.20141219T004928-872@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

On 19.12.2014 01:05, Tom Evans wrote:
>>
>>     https://gitorious.org/linux-can/can-utils/
> ...
>
> What is the relationship (if any) between this "can-utils" package and the
> "canutils" (latest update June 2010) that we're using from here?
>
>      http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/
>
> I note some common authorship (Marc Kleine-Budde).
>
> Both have cansend and candump utils, but the Pengutronics one also has
> "conconfig" which we rely on.

This has some historical reasons - of course ;-)

The can-utils that are now on gitorious.org (former berlios.de) are originally 
from Volkswagen Group Research.

And Pengutronix started their toolset based on the requirements to be able to 
ship it with OSELAS/ptxdist based board support packages.
IIRC Pengutronix provided the canconfig they needed even before the netlink 
configuration (with iproute2) was available.

To build your own CAN interface configuration tools canconfig and the 
libsocketcan from Pengutronix are a good way to start.

http://git.pengutronix.de/?p=tools/canutils.git
http://git.pengutronix.de/?p=tools/libsocketcan.git

 From the 'just user' perspective to send/dump/replay/visualize CAN stuff the 
gitorious can-utils are recommended and provide more functionalities.

That's why there is a Debian package can-utils. To be able to make it a Debian 
package and to support the autotools Marc e.g. provided the needed autotools 
infrastructure in can-utils.

Regards,
Oliver

ps. to configure my CAN interfaces I'm using a can_if script for 
Debian/Ubuntu, where you can configure bitrates for the interfaces using the 
'ip' tool from iproute2:

https://gitorious.org/linux-can/can-misc/source/etc/can_if

Just put this into /etc/init.d and say

	update-rc.d can_if defaults

Documentation is inside the can_if script.
