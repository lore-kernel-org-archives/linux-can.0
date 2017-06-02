From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: struct j1939_priv::kref
Date: Fri, 2 Jun 2017 16:12:06 +0200
Message-ID: <20170602141206.GA17454@airbook.vandijck-laurijssen.be>
References: <8dd1fbee-5488-3519-7997-c38220e4bf1a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:50810 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdFBOMT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jun 2017 10:12:19 -0400
Content-Disposition: inline
In-Reply-To: <8dd1fbee-5488-3519-7997-c38220e4bf1a@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

> Hello,
> 
> while reviewing the j1939 I stumbled over the struct j1939_priv....
> 
> > struct j1939_priv {
> > 	struct list_head ecus;
> > 	/* local list entry in priv
> > 	 * These allow irq (& softirq) context lookups on j1939 devices
> > 	 * This approach (separate lists) is done as the other 2 alternatives
> > 	 * are not easier or even wrong
> > 	 * 1) using the pure kobject methods involves mutexes, which are not
> > 	 *    allowed in irq context.
> > 	 * 2) duplicating data structures would require a lot of synchronization
> > 	 *    code
> > 	 * usage:
> > 	 */
> > 
> > 	/* segments need a lock to protect the above list */
> > 	rwlock_t lock;
> > 
> > 	int ifindex;
> > 	struct net_device *netdev;
> > 	struct addr_ent {
> > 		ktime_t rxtime;
> > 		struct j1939_ecu *ecu;
> > 		/* count users, to help transport protocol */
> > 		int nusers;
> > 	} ents[256];
> > 
> > 	/* tasklet to process ecu address claimed events.
> > 	 * These events raise in hardirq context. Signalling the event
> > 	 * and scheduling this tasklet successfully moves the
> > 	 * event to softirq context
> > 	 */
> > 	struct tasklet_struct ac_task;
> > 
> > 	/* list of 256 ecu ptrs, that cache the claimed addresses.
> > 	 * also protected by the above lock
> > 	 * don't use directly, use j1939_ecu_set_address() instead
> > 	 */
> > 	struct kref kref;
> 
> ...and the comment above the kref make no sense to me. Is it a left over
> from previous versions?

I belongs above 'addr_ent' now.

> 
> > 
> > 	/* ref counter that hold the number of active listeners.
> > 	 * This number itself is protected with a mutex
> > 	 */
> > 	int nusers;
> 
> I want to get rid of nusers and use kref only instead.
well, kref isn't really used (only initialized) anymore.
why get rid of nusers an use kref instead.
You can remove kref (here) safely and remove the initialize, I think.

Kurt
