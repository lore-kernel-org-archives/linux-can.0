From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 08:32:22 +0200
Message-ID: <5882451.nUC1A4BOX5@ws-stein>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56324 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760989Ab2DLGcZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 02:32:25 -0400
In-Reply-To: <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Am Mittwoch, 11. April 2012, 21:36:05 schrieb Fabio Baltieri:
> On Wed, Apr 11, 2012 at 9:02 PM, Oliver Hartkopp <socketcan@hartkopp.net> 
wrote:
> >>> And we should probably add a new CAN netlink command here
> >>> 
> >>>        http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/dev.c#L577
> >>> 
> >>> to configure the LED timer per interface: 0 -> LEDs off (==default)
> >> 
> >> Nice... I'm taking notes here. :-)
> > 
> > Hm - probably this is a bit heavy weighted suggestion from me.
> > 
> > Do you really think the timer value needs to be configurable or is a
> > simple
> > on/off switch ok too?
> 
> I think that if the bus only has a light traffic a longer time would
> be more helpful, otherwise any fixed time of some tenths of
> milliseconds should just do the job (that's how ledtrig-ide-disk
> works). A single module parameter looked like a decent compromise to
> me.
> 
> I should add a check to skip it entirely if led_off_delay == 0 as a
> run-time "optimization" if the feature is not used (triggers does not
> provide a use-counter). Do you think it should be disabled by default?
> 
> > The second question:
> > 
> > Is the LED "blinking" on traffic or is it just "on" for some time when a
> > CAN frame is processed?
> 
> It stays on for some time after each frame. Above a certain
> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
> tell periodic packets from bursts from it but nothing more.

I think a Tx or Rx trigger should just "start" one LED blink, e.g. ON for 
100ms and OFF for 100ms no matter if other packets being processed. This way 
you will constantly see a LED blinking if a specific load is exceeded. If it 
is at lower rate the LED will blink more rarely.
You could even go one step further and activate a LED if the CAN interface is 
UP and turn it off for some time if there is some traffic. So the LED could 
inidicate if the interface is being used and/or if there is some traffic.

Regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
