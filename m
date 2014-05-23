From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] CAN SJA100 controller emulation and
 SocketCAN based host CAN bus access
Date: Fri, 23 May 2014 11:42:25 +0200
Message-ID: <20140523094225.GA1260@stefanha-thinkpad.redhat.com>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz>
 <CAJSP0QXLCZYrvHpPQH6CSTkfL2ezdvZya32kuHfs4FgYvC_Btg@mail.gmail.com>
 <201405151553.07872.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51667 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaEWJm3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 May 2014 05:42:29 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so539049wiv.13
        for <linux-can@vger.kernel.org>; Fri, 23 May 2014 02:42:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201405151553.07872.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Oliver Hartkopp A <socketcan@hartkopp.net>, jinyang.sia@gmail.com, Stefan Weil <sw@weilnetz.de>, rtems-devel@rtems.org, linux-can@vger.kernel.org

On Thu, May 15, 2014 at 03:53:07PM +0200, Pavel Pisa wrote:
> The decisions for further development
> 
> Should be minimal working solution included in the QEMU
> mainline in short term?
> (months .. or rather wait for agreement on final
> infrastructure, may be years because of our other load
> and complexity of full model task)
> 
> Is preferred approach to open CAN QEMU fork on GitHub?
> Etc...

It sounds like there is doubt about whether anyone has enough time to
implement CAN more fully.  I'm not thrilled about reviewing patches if
it's a partial implementation with few end users - something like that
can be kept out-of-tree until someone with enough resources can polish
it and push it upstream.

A few more comments about the network subsystem:

The QEMU network subsystem doesn't emulate Ethernet.  It's just a way to
connect an emulated NIC with a host netdev (tap, socket, etc) with a few
extra services like link down/up, flow control, etc.

In the CAN world it would connect a CAN controller (e.g. Kvaser PCI)
with a host device (e.g. using libcan or whatever).  I don't think it's
necessary to emulate bus arbitration in this model, that should happen
via the host device (which is talking to an real CAN bus).

The question is whether the network subsystem's send/receive model works
or whether you need something CAN-specific like publishing RX/TX objects
along with their metadata (IDs, priorities, deadlines, etc).  That would
be a major difference and it would probably make sense it implement it
as a separate subsystem.

Stefan
