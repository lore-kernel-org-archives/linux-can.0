From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: netdev development process - was Re: [PATCH next-next 0/2] can: cc770:
 add support for the Bosch CC770 and Intel AN82527
Date: Thu, 01 Dec 2011 09:15:42 +0100
Message-ID: <4ED737AE.7030405@hartkopp.net>
References: <1322136448-7311-1-git-send-email-wg@grandegger.com>	<20111129.183950.1327835803051184146.davem@davemloft.net>	<4ED5CF14.4020502@hartkopp.net> <20111130.160727.1989923062226789802.davem@davemloft.net> <4ED73117.1020101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:19665 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1LAIPx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2011 03:15:53 -0500
In-Reply-To: <4ED73117.1020101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>, Urs Thuermann <urs@isnogud.escape.de>
Cc: Urs Thuermann <urs.thuermann@volkswagen.de>, linux-can@vger.kernel.org

Hello Marc and Urs,

what are your plans regarding a maintainer ship of your persons?

Urs is pretty absent and Marc is pretty active :-)

IMO we should update the MAINTAINERS file to make the responsibilities clear
to Dave & the rest of the world.

@Urs: Should we remove you from net/can maintainers? The fact that you are
module author of several code parts is not touched at all but your activities
to contribute to discussions is close to zero.

@Marc/Wolfgang: What are your thoughts about that? Is Wolfgang still enough or
would you like to share your activities?

I think the remarks from Dave hit the point and we should really try to
minimize confusion when talking to him in the future ...

Regards,
Oliver


>> A not very good dev process - job was done here communicating to me what is happening.
>> Endless revisions, and not clear indication to me what should or should
>> not be applied as a result.
> 
> 
> Well in this case i was just astonished why you applied a superseded patch set
> - but i must admit that the pile-up of posted versions was a bit confusing.
> Even there were platform and devtree patches that needed to be acked by other
> maintainers - IMO we should post these patches on netdev only when they are
> already acked by the platform/devtree guys.
> 
> @Wolfgang/Marc: We should return to discuss the CAN relevant patches on
> linux-can@vger.kernel.org before posting them on netdev. Don't know why this
> established & good process has changed over the time ...
> 
>> I want you guys to appoint someone to be the defacto CAN driver and
>> subsystem maintainer who collects and merges all the driver and
>> protocol patches into his tree, and acts as the one and only interface
>> for me when changes are ready to be included.
> 
> 
> I'm also not very happy someone else acking changes of my maintained sources -
> sometimes it feels like Wild West to me, who's acking first :-(
> 
> To make it clear:
> 
> 	Wolfgang Grandegger maintains drivers/net/can
> 
> and
> 
> 	Oliver Hartkopp maintains net/can
> 
> As Marc Kleine-Budde is also very active in CAN driver development we should
> probably add him to the drivers/net/can maintainers.
> 
> We'll continue the discussion on linux-can ML and give an update to the
> MAINTAINERS file if we sorted out any changes. So far Wolfgang and me remain
> the 'only interface' for you. Sorry for the traffic & confusion on netdev.


