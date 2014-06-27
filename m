From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Bus off
Date: Fri, 27 Jun 2014 07:05:12 +0200
Message-ID: <20140627050512.GA1291@vandijck-laurijssen.be>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:23311 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019AbaF0FFZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jun 2014 01:05:25 -0400
Content-Disposition: inline
In-Reply-To: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

Hey,

On Thu, Jun 26, 2014 at 10:13:17AM -0700, Austin Schuh wrote:
> Does anyone know if the TX queues are cleared on BUS-OFF?

No queues are emptied, you will only loose the curent pending transmission.

> 
> I have a machine connected to a network where all the other CAN nodes
> shut off periodically.  I monitor whether or not they are sending, and
> don't send messages unless I think they are on.  Right after they shut
> off, I occasionally send out a message when they are off,

I assume this cannot be avoided due to timeouts.

> which triggers a bus-off.
> I'm seeing lots of bus-off/restarts due to
> restart-ms=1000 after the nodes shut down, and I'm pretty certain that
> I'm not sending anything at that time.  Any ideas on what is going on
> would be appreciated.

If you're not alone, a transmission is (normally) acked immediately
and the bus becomes idle again.

When you are the only active CAN chip, noone acks your message
and your transmission will be continuously repeated.
This makes you vulnerable for any bad bus condition.

If your bus conditions were good all the time, your would never
enter bus-off even if you transmit and are alone on the bus.

So, I _think_ that during shutdown or startup of your nodes, they
do (mayby shortly) bring a bad condition on the bus.
I would investigate the shutdown sequence of your nodes.
Some conditions I could think of/have experienced:
* after stopping the CAN chip, the CAN-TX pin returns being a GPIO
  and it's set as output.
* The CAN chip is stopped in the middle of transmission.
...

Kurt
