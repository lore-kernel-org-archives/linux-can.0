From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: About PCAN-USB issues
Date: Wed, 25 Jan 2012 11:25:31 +0100
Message-ID: <4F1FD89B.8090401@grandegger.com>
References: <1567213.2GCzMlGyKY@lisa> <4F1E9DA9.9060804@hartkopp.net> <4F1EE678.2050604@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:45065 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2AYKZe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2012 05:25:34 -0500
In-Reply-To: <4F1EE678.2050604@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Sebastian Haas <dev@sebastianhaas.info>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stephane,

On 01/24/2012 06:12 PM, Stephane Grosjean wrote:
> Hello all,
> 
> I'm finally back to the linux-can... I'm currently working on several
> projects so the peak_usb did progress slowly these last days...
> 
> Back to the issue: I changed the way the can state is handled in the
> peak_usb driver and finally get an easy tesbed to create bus-off
> events... Now, the driver puts the candev into that state only once, no
> more periodic error-warnings or else. I'm looking now to how the restart
> mechanism works.
> 
> 1st: since the restart can be automatic, the related do_set_mode
> callback is called from a timer context, in which you're not allowed to
> sleep. So I suppose this is the reason of some Kernel hangs you (Oliver)
> detected last week: the peak_usb driver (tries to) reset the device by
> sending an usb message, using usb_bulk_msg(), which usage is not allowed
> in such a context! To confirm, is someone able to do the same with the
> ems_usb driver, please? It seems that this driver acts as the peak_usb
> does.

The timer handler is called from softirq context, which is not valid for
usb_bulk_msg().

> 
> Moreover, it seems that the "manual" restart is also called from such a
> timer context, so the consequences are the same...

Yes, it uses the timer as well, see:

  http://lxr.linux.no/#linux+v3.2.1/drivers/net/can/dev.c#L406

Otherwise it would be called from the process context, which causes
other problems.

> I'll have to change the way that reset is done into full asynchronous mode.

You will find some comments here:

  http://lxr.linux.no/#linux+v3.2.1/drivers/usb/core/message.c#L192

Wolfgang.
