From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: CAN-FD Transceiver Limitations
Date: Thu, 29 Jun 2017 16:21:42 +0200
Message-ID: <20170629142142.GF9244@lunn.ch>
References: <de1f6343-4b28-4a5f-c6df-4e54c09fcce2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:39080 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbdF2OVv (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 29 Jun 2017 10:21:51 -0400
Content-Disposition: inline
In-Reply-To: <de1f6343-4b28-4a5f-c6df-4e54c09fcce2@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de

On Wed, Jun 28, 2017 at 05:14:42PM -0500, Franklin S Cooper Jr wrote:
> Hi All,
> 
> The various CAN transceivers I've seen that support CAN-FD appear to be
> fairly limited in terms of their supported max speed. I've seen some
> transceivers that only support upto 2 Mbps while others support up to  5
> Mbps. This is a problem when the SoC's CAN IP can support even higher
> values than the transceiver.
> 
> Ideally I would think the MCAN driver should at the very least know what
> the maximum speed supported by the transceiver it is connected to.
> Therefore, either throwing an error if a request for a speed above the
> transceiver capability or lower the requested speed to what ever the
> transceiver is capability of doing.

Hi Franklin

> In either case I do not know if it makes sense to add a DT property
> within the MCAN driver or create another subnode that contains this
> information. For example I see some ethernet drivers support
> "fixed-link" subnode which is trying to solve a similar issue.

Hi Franklin

I would say fixed-link is trying to solve a different issue. You use
fixed-link when you don't have a PHY connected to the Ethernet MAC. A
MAC driver will normally tell the PHY driver what speeds its supports,
and ask the PHY to negotiate a speed both the MAC and PHY supports
with the peer device. The MAC then gets told of the resulting speed.
If this PHY does not exist, you cannot ask it to perform auto-neg, you
have no idea what the peer is capable of. Hence you add a virtual PHY
using fixed-link, which always returns the same speed. This works
because if you don't have a PHY, the MAC is generally connected to
another MAC on the same board, typically an Ethernet switch. Hence the
speed is a board property and fixed.

You appear to have a different issue. I don't know the CAN
subsystem. Is the transceiver part of the model? Is there an API
between the CAN-MAC and the CAN-transceiver? It sounds like you need
to add an API call from the MAC driver to the transceiver driver to
ask it what it is capable of. I don't see this as being a DT property.
The transceiver should know its own capabilities. And you have to
think about non-DT systems, e.g. CAN devices on USB dongles.

      Andrew
