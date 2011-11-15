From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: RE: [Socketcan-users] sja1000 BasicCAN mode
Date: Tue, 15 Nov 2011 09:42:25 +0100
Message-ID: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDC5@SBSPORT.portnet.local>
References: <CAF8b2jKKnpUeq_x8O6V4RfdAK741HuPKTqc=3fNRU6C2SDAJ4A@mail.gmail.com>
 <20111115082136.GB331@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:59860 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753566Ab1KOJAc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Nov 2011 04:00:32 -0500
In-Reply-To: <20111115082136.GB331@e-circ.dyndns.org>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>, Yuriy Kiselev <kiselev.yuriy@gmail.com>
Cc: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


> -----Original Message-----
> From: socketcan-users-bounces@lists.berlios.de [mailto:socketcan-users-
> bounces@lists.berlios.de] On Behalf Of Kurt Van Dijck
> Sent: Tuesday, November 15, 2011 9:22 AM
> To: Yuriy Kiselev
> Cc: socketcan-users@lists.berlios.de; linux-can@vger.kernel.org
> Subject: Re: [Socketcan-users] sja1000 BasicCAN mode
> 
> On Mon, Nov 14, 2011 at 09:08:29PM +0400, Yuriy Kiselev wrote:
> > Hello!
> > Implementation of BasicCAN mode for SJA1000 is in attachment.
> > Now SJA1000_PELICAN_MODE macros in sja1000.h is used for definition
> PeliCAN
> > or BasicCAN mode. It would be nice to create some menuconfig-wrapper, I
> > think.
> > I use this code for a few weeks and it looks stable.
> I see no reason to use BasicCAN mode instead of PeliCAN mode.
> Instead, I do see reasons to use PeliCAN mode:
> 
> * no problems when 29bit frames appear on the bus
> * rx queue of 64 byte.
> 
> What is your motivation not to use PeliCAN mode?
> 
> Kurt

Kurt is correct. For my understanding, the so-called basic CAN mode of the SJA1000 is a compatibility mode for the 82c200. It makes no sense to support it any more with SJA1000 devices.

 Heinz
