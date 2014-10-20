From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change handling.
Date: Mon, 20 Oct 2014 21:45:46 +0200
Message-ID: <5445666A.6090601@grandegger.com>
References: <5425AF94.5000206@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41242 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaJTTpt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Oct 2014 15:45:49 -0400
In-Reply-To: <5425AF94.5000206@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org

Hi Andri,

sorry for the long delay...

On 09/26/2014 08:25 PM, Andri Yngvason wrote:
> The handling of can error states is different between platforms.
> This is an attempt to correct that problem.
> 
> I've moved this handling into a generic function for changing the
> error state. This ensures that error state changes are handled
> the same way everywhere (where this function is used).
> 
> What's changed from the last version of this patch-set is that
> can_change_state() now relies on the individual states of the rx/tx
> counters rather than their individual count values.

To see if the state changes occur as expected could you please record
error message traces with candump for the following two scenarios:

1. send messages with cangen
   disconnect the cable
   reconnect the cable after a while until the error active state is
   reached.

2. set restart-ms=100
   send messages with cangen
   provoke a bus-off short-circuiting CAN low and high
   remove the short-circuit

Start with the SJA100 first.

Thanks,

Wolfgang.

