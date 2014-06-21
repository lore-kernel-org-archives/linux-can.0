From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sat, 21 Jun 2014 23:28:23 +0200
Message-ID: <20140621212823.GA28234@vandijck-laurijssen.be>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:21016 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755605AbaFUV2b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Jun 2014 17:28:31 -0400
Content-Disposition: inline
In-Reply-To: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luis de Arquer <ldearquer@gmail.com>
Cc: linux-can@vger.kernel.org

Hey Luis,

On Sat, Jun 21, 2014 at 02:51:13PM +0100, Luis de Arquer wrote:
> Hi all,
> 
> We have some Kvaser Lapcan PCMCIA cards at work which I found are not
> supported for linux -there is an old driver, but it is not compatible
> with current pcmcia subsystem and is not socketcan either.

I experienced the same situation. We had quite a few Softing CANcards.
So a wrote a driver.
I'm in no means a PCMCIA specialist. I'm only looking for some years
already to the (infrequent) changes there.

[...]
> 
> 2- What is the counterpart of 'pcmcia_request_io()'? There seems to be
> a 'pcmcia_release_io()', but it is not accessible. It is internally
> called by 'pcmcia_disable_device()', but 'pcmcia_disable_device()' is,
> on itself, the counterpart for 'pcmcia_enable_device()'. So, what is
> the right thing to do if 'pcmcia_request_io()' succeeds, but
> 'pcmcia_enable_device()' fails?

It may be usefull to understand the history of the pcmcia subsystem.
In the 2.4 days, it was hotpluggable while the rest of the kernel was not.
Today, the entire device model is hotpluggable, and a lot of the pcmcia_
system had been migrated.

Did you try to use request_resource, and ommitting pcmcia_request_io.

I can imagine that pcmcia_enable_device must come first, as resources
are not available when the device is disabled.

> 
> 3- I am requesting the IRQ *after* the call to
> 'pcmcia_enable_device()' -as seen in the peak_pcmcia driver. Would it
> be better to do it before?

The IRQ should only be fired when the CAN chip is running, which is way later.
You did well.

Kurt
