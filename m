From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: GS_USB
Date: Mon, 11 Nov 2013 16:41:38 +0100
Message-ID: <5280FAB2.3030600@hartkopp.net>
References: <1380889887.22484.2.camel@blackbox> <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox> <5e3f6029b128db63c69664deed10c5d6@grandegger.com> <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com> <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com> <1384135835.3749.31.camel@blackbox> <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:15461 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab3KKPlm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2013 10:41:42 -0500
In-Reply-To: <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>


>> Manual recovery is not supported. The node can leave bus off state if
> 
>> it detects 128 occurrences of 11 consecutive recessive bits on the bus.
> 
>> Maybe I can trick the controller out of bus off by doing a software
> 
>> reset. That's probably not going to be a clean solution though.
> 
> 
> 
> Would be nice if manual recovery is supported but it's not a requirement.
> 
> Maybe you could make the delay before restarting bus-off configurable
> 
> using the "restart-ms" argument.
> 
> 
> 
> For further information have a look to:
> 
> 
> 
> http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L891
> 
> 

Yes.

Usually the CAN controller sits in BUS_OFF until it detects correct CAN frames
_or_ until the controller is re-initialized.

The CAN controller should not recover itself as this might be wrong depending
on the use-case.

Therefore the manual "restart" can be initiated by some user application or it
can be handled inside the driver e.g. 200ms after a BUS_OFF detection by the
"restart-ms" option.

Regards,
Oliver

