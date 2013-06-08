From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Sat, 08 Jun 2013 14:28:44 +0200
Message-ID: <51B3237C.7060904@hartkopp.net>
References: <zarafa.51b23e1c.16b0.5a9e858f2ffa17a7@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:51364 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3FHM2q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Jun 2013 08:28:46 -0400
In-Reply-To: <zarafa.51b23e1c.16b0.5a9e858f2ffa17a7@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 07.06.2013 22:10, Michael Luxen wrote:

> I'm looking for a easy solution to make the powerful cangw tool more comfortable for endusers (dummy user).
> 
> Therefore I prefer to have a webfrontend / Web GUI to configure the cangw rules with a webbrowser which is available on each PC/smartphone/etc
> 
> Is there already a configuration tool or best a Web GUI available which can i.e.:
> cangw
> - Load two Vector .dbc files (one for can0 and one for can1)

I would suggest to start with kcd files instead of dbc files, which are Vector
property.

E.g. The JAVA tool Kayak (http://kayak.2codeornot2code.org/) uses the kcd
format (see: http://kayak.2codeornot2code.org/tutorial.html). There's also a
kcd converter CANBabel at github: https://github.com/julietkilo/CANBabel

> - Select on one side (can0) the input CAN frame which should be routed from can0 to can via cagw
> - Select on the other side (can1) the input CAN fram whcih should be routed from can1 to can0 via cangw
> - Manipulate of CAN-frames with some logic operations +/-/*/div to use the modification features of cangw

Today there are only AND/OR/XOR/SET defined for CAN frame modifications.

To modify signals on the fly is a much more complex attempt than doing some
bit-wise operations. E.g. if you think about +/-/*/div operations: You need to
provide the other operands, you need to extract and shift the data for
processing and afterward inject it at the right place (shifting, adding the
original information that was not modified, etc).

I wonder if this can/should be done in kernel context in a proper manner.

> - start cangw
> 
> cansend
> - load a Vector .dbc file
> - select a CAN-frame for transmitting
> - select a CAN-signal to fillin a value to transmit
> - manipulate the CAN-frames/CAN-signals content/values independent
> - start cansend for CAN simulation
> 
> candump
> - configure can interface to monitor/log
> - start candump -l in background

I would suggest to preserve cansend and candump as-is.

Especially candump has become pretty complex by today to support all the
CAN_RAW socket options and control information (from CAN FD to dropcounters &
timestamps).

Probably some new tools like sigdump and sigsend (signal...) that make use of
kcd files are a better option here.

But i don't know how this can be adapted to a web-based interface then.

Best regards,
Oliver


> 
> 
> Environment background:
> I'm currently using the two internal CAN-Interfaces of the BeagleBone Black. They are perfectly working for me with the latest Angstrom or Debian images.
> 
> Thanks for any hint or pointing me to the right place!
> 
> Regards
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

