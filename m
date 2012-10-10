From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] Disintegrate UAPI for can
Date: Wed, 10 Oct 2012 19:00:24 +0100
Message-ID: <27643.1349892024@warthog.procyon.org.uk>
References: <5075B2F4.60708@pengutronix.de> <30687.1349789402@warthog.procyon.org.uk>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755697Ab2JJSAh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 10 Oct 2012 14:00:37 -0400
In-Reply-To: <5075B2F4.60708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: dhowells@redhat.com, socketcan@hartkopp.net, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net

Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/09/2012 03:30 PM, David Howells wrote:
> > Can you merge the following branch into the can tree please.
> > 
> > This is to complete part of the Userspace API (UAPI) disintegration for which
> > the preparatory patches were pulled recently.  After these patches, userspace
> > headers will be segregated into:
> > 
> > 	include/uapi/linux/.../foo.h
> > 
> > for the userspace interface stuff, and:
> > 
> > 	include/linux/.../foo.h
> > 
> > for the strictly kernel internal stuff.
> 
> Nice work David. The upstream for can-next is David Miller's net-next
> tree. He doesn't like if I pull unrelated stuff into my tree, so I'm
> going to cherry pick your patch. This is not yet possible, as net-next
> doesn't include the latest patches from the 3.7 merge window, so that
> compilation breaks. After the merge window closes David Miller merges
> back the latest changes to net-next. I'll postpone your patch until
> then, this means the code will go into v3.8. I'm not familiar with the
> UAPI conversion, should your patch go via linux-can and David's net into
> v3.7?

It's okay for the patch to go into 3.8 if that is easier for you.  As it's
scripted, I can regenerate your branch after -rc1 if that helps too.

David
