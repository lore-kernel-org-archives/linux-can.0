From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Mon, 03 Sep 2012 22:54:49 +0200
Message-ID: <50451919.20205@hartkopp.net>
References: <50191EA5.1040303@pengutronix.de> <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com> <20120824051016.GB1718@vandijck-laurijssen.be> <50376550.4020501@pengutronix.de> <20120824124248.GA422@vandijck-laurijssen.be> <20120824220142.GA1470@gmail.com> <5044A547.2010603@pengutronix.de> <20120903181335.GA415@vandijck-laurijssen.be> <20120903182925.GA28766@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:57465 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2ICUyx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Sep 2012 16:54:53 -0400
In-Reply-To: <20120903182925.GA28766@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

On 03.09.2012 20:29, Fabio Baltieri wrote:

> On Mon, Sep 03, 2012 at 08:13:35PM +0200, Kurt Van Dijck wrote:
>> On Mon, Sep 03, 2012 at 02:40:39PM +0200, Marc Kleine-Budde wrote:
>>> The net->ifindex is unique. But it's only an integer. Usually can0 has a
>>> ifindex != 0, so a simple can%d is contra productive here.
>>>
>>> Some pointers to related code:
>>> http://lxr.free-electrons.com/source/drivers/base/core.c#L1847
>>> http://lxr.free-electrons.com/source/drivers/base/core.c#L73
>>> http://lxr.free-electrons.com/source/include/linux/device.h#L695
>>>
>>> comments?
> 
> That would probabily makes really hard to choose the right
> default_trigger for led devices to get to the appropriate CAN LED in
> embedded systems, as trigger name would depend from other network
> devices and probing order (correct me if I'm wrong).
> 
> Something with device name would probaily be more appropriate here.
> 
>>
>> a very recent idea: something with netdevice notifiers and NETDEV_CHANGENAME ...
>> http://lxr.free-electrons.com/source/net/core/dev.c#L1030
>>
>> you could: rename the trigger, or if we think it's usefull,
>> block the netdev rename when its triggers are in use.
> 
> Blocking the rename looks overkill to me, what about using device name
> with an optional "port id" appended to it?  Sounds simpler...


The name of the device can only be changed when the interface is down.
Is it possible to put some scripting around it to detach and attach the leds
to the interfaces on ifup/ifdown triggers?

Regards,
Oliver

