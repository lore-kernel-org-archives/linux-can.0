From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Thu, 15 Nov 2012 22:04:55 +0100
Message-ID: <50A558F7.60005@hartkopp.net>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org> <50A4E5FC.5020103@pengutronix.de> <50A52266.8030301@hartkopp.net> <loom.20121115T201037-567@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:62790 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2KOVXS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 16:23:18 -0500
In-Reply-To: <loom.20121115T201037-567@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason White <white_jason_r1@cat.com>
Cc: linux-can@vger.kernel.org

On 15.11.2012 20:11, Jason White wrote:

> Oliver Hartkopp <socketcan@hartkopp.net> wrote on 11/15/2012 11:12:06 AM:
> 
>>
>> The can-gw frame router is part of mainline Linux 3.2+
>>
>>
> 
> I'm not sure I entirely follow what you are doing.  Here is what I think you
> mean.  Please correct me if I'm wrong.  You have implemented a network
> management layer that interfaces directly with can0.  All other applications
> interact with can0v, which is always up.  When you know the communication
> is stable you route between can0 and can0v.  Did I get that right?


Yep!

> 
> So do you take can0 down/up when timeouts occur with messaging?


No. I did not need to do so. But it is generally possible to down/up the
interfaces without destroying the cangw's routing table.

>  Is there
> any kind of startup delay associated with this?


Of what? The gateway route establishment? 

>  Is there any kind of
> delays going to can0v?


When a CAN frame is received on can0, the NET_RX softirq is invoked to handle
the CAN filters and passes the frame to the cangw ... which passes the frame
directly into the can0v interface.

Usually this is done withing the same softirq and you don't have any
noticeable delay.

See measurements in the text here:

http://permalink.gmane.org/gmane.linux.network/205565

>  
>> Officially the TX-timeout has been removed as the controller just sends out
>> the CAN frames, when it comes back to life ...
>>
>> The question is, if the controller gets into the BUS_OFF state and if the
>> restart-ms option (see ip tool) would help here.
>>
>> Regards,
>> Oliver
> 
> What do you mean by the TX-timeout or restart-ms option?


See:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=Documentation/networking/can.txt;h=820f55344edc0a035358fa643bbe79c48d4d887f;hb=HEAD#l817

Regards,
Oliver
