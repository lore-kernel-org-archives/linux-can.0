From: "Max S." <max@schneidersoft.net>
Subject: Re: Bus off
Date: Thu, 26 Jun 2014 22:54:23 +0000
Message-ID: <1403823263.24938.12.camel@blackbox>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:52240 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbaFZWz4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Jun 2014 18:55:56 -0400
In-Reply-To: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

When there is only one node. The lone node will continuously attempt to
transmit.

the tx error counter will increase and the node will move from
error_active to error_passive, and then to bus_off. At least one node I
know of will leave bus_off when it receives 128x11 consecutive dominant
bits and ten try to send again.

If the controller will wait for linux to restart it, it will probably
retry transmitting the frame upon being restart.

Restart does not mean reset as far as i know.

Regardless of what state the linux queue is in the frame in the
controllers outgoing message objects will continue to try to send,
unless explicitly told to cancel transmission. (at least on the
controllers i know. not that many :/)

Hence you will see the cycling error frames.

typically heartbeat frames are used to tell if a node exists or not.
each node send a predefined message at a desired interval, and you just
listen.

Regards,
Max S.

On Thu, 2014-06-26 at 10:13 -0700, Austin Schuh wrote:
> Does anyone know if the TX queues are cleared on BUS-OFF?
> 
> I have a machine connected to a network where all the other CAN nodes
> shut off periodically.  I monitor whether or not they are sending, and
> don't send messages unless I think they are on.  Right after they shut
> off, I occasionally send out a message when they are off, which
> triggers a bus-off.  I'm seeing lots of bus-off/restarts due to
> restart-ms=1000 after the nodes shut down, and I'm pretty certain that
> I'm not sending anything at that time.  Any ideas on what is going on
> would be appreciated.
> 
> Thanks,
>     Austin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


