From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [Socketcan-users] sja1000 BasicCAN mode
Date: Tue, 15 Nov 2011 09:21:36 +0100
Message-ID: <20111115082136.GB331@e-circ.dyndns.org>
References: <CAF8b2jKKnpUeq_x8O6V4RfdAK741HuPKTqc=3fNRU6C2SDAJ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:45995 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329Ab1KOIVm (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Nov 2011 03:21:42 -0500
Content-Disposition: inline
In-Reply-To: <CAF8b2jKKnpUeq_x8O6V4RfdAK741HuPKTqc=3fNRU6C2SDAJ4A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yuriy Kiselev <kiselev.yuriy@gmail.com>
Cc: socketcan-users@lists.berlios.de, linux-can@vger.kernel.org

On Mon, Nov 14, 2011 at 09:08:29PM +0400, Yuriy Kiselev wrote:
> Hello!
> Implementation of BasicCAN mode for SJA1000 is in attachment.
> Now SJA1000_PELICAN_MODE macros in sja1000.h is used for definition PeliCAN
> or BasicCAN mode. It would be nice to create some menuconfig-wrapper, I
> think.
> I use this code for a few weeks and it looks stable.
I see no reason to use BasicCAN mode instead of PeliCAN mode.
Instead, I do see reasons to use PeliCAN mode:

* no problems when 29bit frames appear on the bus
* rx queue of 64 byte.

What is your motivation not to use PeliCAN mode?

Kurt
